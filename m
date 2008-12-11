From: rdkrsr <rdkrsr@googlemail.com>
Subject: Re: Fwd: after first git clone of linux kernel repository there are changed files in working dir
Date: Thu, 11 Dec 2008 18:58:01 +0100
Message-ID: <d304880b0812110958u3da52e4fs7e5154ebe9a353a@mail.gmail.com>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
	 <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
	 <e32b7bb40812101220s370a64f1n3f7ecb56dd352405@mail.gmail.com>
	 <d304880b0812110142g41b80745ic09a7200e02dcdb0@mail.gmail.com>
	 <d304880b0812110915o6968050cufbb1e29c8bcea984@mail.gmail.com>
	 <alpine.LFD.2.00.0812110934180.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 18:59:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LApou-0001Jd-H7
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 18:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbYLKR6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 12:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbYLKR6F
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 12:58:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:36353 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbYLKR6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 12:58:03 -0500
Received: by rv-out-0506.google.com with SMTP id k40so987099rvb.1
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 09:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Mw8GALvDx1tHgv0+XIn8IEcCGCNQGvFomTL7Lob7UZc=;
        b=vLcnMtgM5Z6H0rds0lr1N/bSQTQtDI9WaXb119bd2MMkW1vc/lD0J60kz+i2nwMJCR
         Y4YkB7tkmfVGnzdpW0M08QgD0w/Mtae7eukOVzdI1bh/vm8tdJ9LnHerQZA+VilM76kO
         K7zrqrWkWebFbe5/ebBPhkaoT6yZC372gPC1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pcRmcRIb2TO9UcOe9DAt1I5NXaWFHR1109KNTEsdYYv5dXzkg7iFSCc+OSOnuIjw20
         l8tezw/L5v6LiJTEd+VhhD4Jl6XhK7s4Q1w3pd1JL0Sxfd+4GeSt5KJyT7eWt5vrOgob
         XTQLp+A01GLU1N99N99LV6/3+7mTMg/7PpTzU=
Received: by 10.141.13.13 with SMTP id q13mr1397016rvi.163.1229018281586;
        Thu, 11 Dec 2008 09:58:01 -0800 (PST)
Received: by 10.140.172.16 with HTTP; Thu, 11 Dec 2008 09:58:01 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812110934180.3340@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102810>

Thank you, Linus and Brett, for your answers.

I'm not developing linux kernel, I just wanted to experiment with git.
And then I didn't know if this is a normal behaviour of git. I'm using
windows xp and msysgit for this. And the file system is NTFS. I'm
using dual boot to sporadicly use linux and tried also linux in
virtual box. But both isn't really good. Maybe one day I dare to use
linux as my primary OS.

Red

2008/12/11 Linus Torvalds <torvalds@linux-foundation.org>:
>
>
> On Thu, 11 Dec 2008, rdkrsr wrote:
>>
>> I'm sorry that I didn't answer to git mailing list address. So here
>> comes the email again.
>
> You have a broken filesystem.
>
>> $ git status
>> # On branch master
>> # Changed but not updated:
>> #   (use "git add <file>..." to update what will be committed)
>> #
>> #       modified:   Documentation/IO-mapping.txt
>> #       modified:   include/linux/netfilter/xt_CONNMARK.h
>> #       modified:   include/linux/netfilter/xt_DSCP.h
>> #       modified:   include/linux/netfilter/xt_MARK.h
>> #       modified:   include/linux/netfilter/xt_RATEEST.h
> ...
>
> This is _exactly_ what happens if you try to develop the Linux kernel on a
> case-insensitive filesystem. The kernel source tree has several files that
> differ only in case, eg
>
>        Documentation/IO-mapping.txt
>        Documentation/io-mapping.txt
>        include/linux/netfilter/xt_tcpmss.h
>        include/linux/netfilter/xt_TCPMSS.h
>        ..
>
> and if you try to check it out on a broken filesystem, then the second
> file will overwrite the first one, and git will think that you have
> modified it.
>
> OS X? Afaik, you can fix it by using NFS or UFS. And I think ZFS has a
> case-sensitive mode too (and it may even be the default). In fact, I think
> newer versions of OS X even allow that piece-of-sh*t HFS+ to be case
> sensitive (and thus make it much less sh*tty).
>
> Of course, there are reports of some Mac software breaking when they use a
> real filesystem, but hey, what else is new?
>
>                        Linus
>
