From: bill lam <cbill.lam@gmail.com>
Subject: Re: commit --quiet option
Date: Wed, 25 Nov 2009 10:06:23 +0800
Message-ID: <20091125020623.GC4048@debian.b2j>
References: <20091124051622.GB18003@debian.b2j>
 <7vtywj76k4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 03:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND7HW-0007UX-Q0
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 03:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242AbZKYCGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 21:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758240AbZKYCGa
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 21:06:30 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:42877 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758180AbZKYCGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 21:06:23 -0500
Received: by pwi3 with SMTP id 3so4561963pwi.21
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 18:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=l/N7mCeEjCSALSbfjW/coL2wSiEeYP8DrcZYfo6VZsE=;
        b=UJdPb7rd6CD3wKKQe/VtJe5W/SSBpsX8iqBzJdV7BrYOMZ2SSNZeKEHhisHqemgzgI
         JKhu/f0Di5Y0tjbgtTMPdzY5780ePldEXCdWaAGO7jx4uPCJ7NvKwxYM3D2WJ5jRjQhi
         BP6Odvlzbkyus6wdrNfOtGoDYDyqK6iHY4UXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iPfxev+de5yFd0zXcK5h812k2PA53WCuHK1E1qBKMOtuXxcfQW/BwMkrDVNi6B8PtW
         ySrAd98oe5+WD/NbsVT2Fl/EMWH1lFIQSLEUH2HhTN0O1242JMWkXjcJTAAgrcLYGXWk
         +mIqSccUwxRX3B2XIW66xS7ymmRz6Nv7uu18k=
Received: by 10.114.33.14 with SMTP id g14mr14079054wag.124.1259114789446;
        Tue, 24 Nov 2009 18:06:29 -0800 (PST)
Received: from localhost (pcd589021.netvigator.com [218.102.121.21])
        by mx.google.com with ESMTPS id 22sm3541946pxi.2.2009.11.24.18.06.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 18:06:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtywj76k4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133607>

On Tue, 24 Nov 2009, Junio C Hamano wrote:
> bill lam <cbill.lam@gmail.com> writes:
> 
> > In git version 1.6.6.rc0.15.g4fa8a0 using the --quiet option it still
> > show some output.  Is that intended?  Specifically I would like to
> > exclude message about the untracked files when using --quite option.
> 
> Given that you are getting "you told me to make a commit without preparing
> anything to commit" error message, I think it can be argued in both ways.
> 
>     $ git commit -q -uno -m 'meaningless message'
> 
> would omit the listing of Untracked files; a better alternative, depending
> on what are listed in the section (I take "a123" is an example made-up for
> reproduction recipe, and you are probably getting something like 'foo.bak'
> in real life), might be to update your .gitignore, though.

That git-commit is intended to run inside a cron job for backup from
home folder and .files, so 'commit' is better than 'meaningless
message'.  .gitignore is already maintained however those 'a123' is a
real life example, they are artifacts of '3m post-it' files because I
rarely use clipboard (c-ins/c-ins) to copy text from one application
into another. 

Thanks for tips on -uno option.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
