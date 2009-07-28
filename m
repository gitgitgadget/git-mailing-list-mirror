From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2009, #02; Sun, 26)
Date: Tue, 28 Jul 2009 10:09:19 +0200
Message-ID: <4A6EB22F.6090007@gmail.com>
References: <7viqhfrfu5.fsf@alter.siamese.dyndns.org> <4A6EA86A.5010705@gnu.org> <7v3a8h8cdc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:09:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVhka-0006iU-V2
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 10:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZG1IJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 04:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZG1IJX
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 04:09:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:37438 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZG1IJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 04:09:21 -0400
Received: by fg-out-1718.google.com with SMTP id e21so981271fga.17
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=18cDycEi41CS5TbOYYEoBlvszJoxJQFaa92PQSBmNJo=;
        b=hERNJm8BLU2ZowSYaXL3c7OwMQXgGMu5wHU1LIxSma5BG+KD07HjxS4t/EIHpVV9r1
         k+IUBpDivQUDcFChowjpZv/Sl96B6QkAex9AC88Rden/3M6c1nk5NMC5lVUe+XPBa9v+
         Qdi1aCoc66bYINaelg0HUVQSTd2aCewPJKZZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QbnlfR5xFaNo9Fq2mruh27naxYDTPBO4ob8lO+c8oZ5zpzWdqNGr3dF0icLkvp4cs/
         uZAjejeBnbY9EdGsa5/yKwx4/GvEyxkQNSjEV5AbHJrdVAKTmALPUjHmYlGOKFIHjMMf
         r1OlL3KZ5hYxr7Xx6Br41ftet1rxhStRZueWM=
Received: by 10.86.30.16 with SMTP id d16mr3506874fgd.2.1248768560844;
        Tue, 28 Jul 2009 01:09:20 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-str.redhat.com [66.187.229.200])
        by mx.google.com with ESMTPS id 12sm15717911fgg.14.2009.07.28.01.09.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 01:09:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <7v3a8h8cdc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124220>

On 07/28/2009 10:01 AM, Junio C Hamano wrote:
> The last thing I want to do is to give end users
> a set of new command line options in 'master' (or even 'next'), only to
> revoke them before the next release.

Agreed.  However, some people expressed appreciation for the new 
git-push command-line option independent of the push.tracking work, of 
which I'd guess they might not even be aware.  If you agree, I would 
leave in pu the third patch ("add remote.*.pushHeadOnly") while merging 
the first two to next.

Paolo
