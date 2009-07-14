From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Re: Make 'git show' more useful
Date: Tue, 14 Jul 2009 08:25:02 +0200
Message-ID: <4A5C24BE.4090804@gnu.org>
References: <7vtz1gi67v.fsf@alter.siamese.dyndns.org> <1247528614-24590-1-git-send-email-bonzini@gnu.org> <alpine.LFD.2.01.0907131652120.13838@localhost.localdomain> <alpine.DEB.1.00.0907140324140.3155@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 14 08:25:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQbS4-0007cf-Mb
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 08:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZGNGZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 02:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbZGNGZJ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 02:25:09 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59265 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbZGNGZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 02:25:07 -0400
Received: by fxm18 with SMTP id 18so2611125fxm.37
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Sm8Tdc3d/ZdcV0bvneHFSz/uRn3UYDtpRFCKK+FLmQQ=;
        b=ZuNLKK+4HnuU2mTyybqxgWY9HPmCKiXalWMA4EnwHneWJY1/APNQMPQ2NtItgQTOPf
         ZUxVE9QVf5EU5JesaTI9SHtZak4BhtG6HDkN2otkgr7Sxdy4u5rYuwIzNxxBy8vAs/Aq
         hwUvgE7eEbojmL0V5aiBByJYLjMSWaOqO38GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=DyZRPpu5w97nYVgTTRfplX3SwEVZw8MKM0NbXu62LKf41wkRgkO+eCJTjaiCyiM9G+
         K5K32LtUq71If/k+CKFV16/d149NiLjbwB+T+P8scjUHPB30aNb1NWvtlg+oufTLyFMe
         TnvybmGMu0N75D7nYj/V0ql6PR5yfHovG0W2A=
Received: by 10.204.71.65 with SMTP id g1mr5993053bkj.27.1247552705102;
        Mon, 13 Jul 2009 23:25:05 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 26sm9217861fks.1.2009.07.13.23.25.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Jul 2009 23:25:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <alpine.DEB.1.00.0907140324140.3155@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123220>


>> The actual "--no-walk" flag was then added over a year later by Dsco, in
>> commit 8e64006eee ("Teach revision machinery about --no-walk").
>>
>> Doing a "git log -p -S--no-walk", I have to admit that I don't find a
>> single actual _use_ of --no-walk.
>
> Actually, I remember very precisely why I introduced it.  The difference
> between "git log --no-walk a b c" and "git show a b c" is that "git log"
> sorts the commits by commit time, which is pretty important in my case.

Very nice.  Can you add a test for that?

(OTOH do-walk seems to be superseded by Linus's patch).

Paolo
