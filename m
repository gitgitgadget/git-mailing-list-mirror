From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Questions about the new
Date: Tue, 13 Oct 2009 09:49:55 +0200
Message-ID: <4AD43123.3060401@gmail.com>
References: <loom.20091012T115746-719@post.gmane.org> <4AD31EBF.6090307@viscovery.net> <4AD3619C.6010808@gmail.com> <7v8wfge2zu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:50:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxc9d-00007o-3F
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759087AbZJMHui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 03:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759050AbZJMHuh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:50:37 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:47079 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759030AbZJMHuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 03:50:37 -0400
Received: by fxm27 with SMTP id 27so9889997fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=+A5f3a/hioaQ62M8sCG61yUxJhSqVF2kwwmUMFjTR7s=;
        b=ObYRjlec6Eh8RWXmpY3qWdORJQ2W6c0UDi0aMu7Pv+axt1Sk9wrgLRD+We1XggNgoD
         cDf50s2TONn6QqVmf06jLhPPh/Cua5hQyEmd3SpkKfZjYWy7zonfUFQROO/DOrLq9EQo
         /fkTHwDLlD5Z+ftiHPx9JoO3zHUZ3uUUKTUyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hZN2vLKl8bSJh0YivAZVrt56vEPJzgHgRhK/uh+GNBAJSOWMIUpnf+CIBq30TS92Xy
         4rcJK7WEG8zdJuZSWQzldLcqVW91THZltQyPxK45a+UvzKNa2qmM5mMYfhtvCG/9iySc
         /vNoKjxUmji34kcNXSUWbbLWG9soimRh30HKo=
Received: by 10.103.84.6 with SMTP id m6mr2850988mul.26.1255420199263;
        Tue, 13 Oct 2009 00:49:59 -0700 (PDT)
Received: from ?192.168.1.12? (host34-7-dynamic.183-80-r.retail.telecomitalia.it [80.183.7.34])
        by mx.google.com with ESMTPS id j2sm2084671mue.46.2009.10.13.00.49.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 00:49:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7v8wfge2zu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130144>

Junio C Hamano wrote:
> Sergio Callegari <sergio.callegari@gmail.com> writes:
>
>   
>> If I want to replace some commit X by some commit X' I merely need to
>> modify the
>> parent information of all the commits that are child of X so that they
>> pretend
>> to be child of X', or am I missing something?
>>     
>
> You need to find all the commits that are child of X in the first place.
> What should happen if your colleague has such a commit in his repository
> (which you haven't fetched from yet), you enumerated all children of X
> known to you in your graft file and then you fetch from him?  You need to
> enumerate all children of X again to keep the graft file up to date.
>   
Ok, that is enlightening. When trying to sort out the differences, 
advantages and disadvantages of
operating on arcs (grafts like) or on nodes (replacements like) I was 
thinking local, rather than
distributed. Now the advantage of working on nodes is much clearer to me.

Thanks as usual for the very clear explanation.

Sergio
