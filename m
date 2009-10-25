From: Corey Trager <ctrager@yahoo.com>
Subject: Fw: [ANNOUNCE]  BugTracker.NET (FOSS) now supports git integration
Date: Sun, 25 Oct 2009 09:53:21 -0700 (PDT)
Message-ID: <169557.95216.qm@web65401.mail.ac4.yahoo.com>
References: <97625.96130.qm@web65401.mail.ac4.yahoo.com> <87k4yj8ta3.fsf@sanosuke.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 17:53:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N26LP-0002lq-Mw
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 17:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbZJYQxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 12:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbZJYQxR
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 12:53:17 -0400
Received: from web65401.mail.ac4.yahoo.com ([76.13.9.21]:43877 "HELO
	web65401.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752845AbZJYQxQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 12:53:16 -0400
Received: (qmail 96630 invoked by uid 60001); 25 Oct 2009 16:53:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1256489601; bh=Wd/cZIDXH9aWHzUSJHLWw7drwU94sAGYZZd8+GRv2Ao=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type; b=RJlyYhO+A9Kwr26KOjNFM8cNUo6eQbJmVVnug0vl25Cb7tcpGH4yGAAbNIDcxaaa/E4CSmglKtkiIIuv4iKz/Ccy2abUYZei0sORfQnJjwl7oBanLuu29bM3FykfzyfSWj4olmgX04AOnCV4C95JlkAXuZa4/H5MgkzHJ0yU8Bk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type;
  b=ADGayB0Mq2ELxBPGkye54UgIb8GuzMJ9vcJiwe9YSWYNVSgLr3Gavf5mr2MnU7RpfGL59nUAMYhfw2XnigRNgpPvcC38qFstvj2QIfGHKC2Lt4ojlXZHj67cu8nmcFp1H8fdwJKPpuv8JbWrJJvdEINml+NsEoyX3SkNlq3wQx4=;
X-YMail-OSG: D55z0BMVM1mEqJPpAP8fjTjaqrDPlscm8IGDDcU5eG87qsYvrBgHBqa_Gizc4W.zTtZayAJjGy36Ww3W0HmbMKZshC.79runEf.ht5tq.NQh1f2HlKHsIjxb4WPR18.HAit4vl20b0kyXkAOpzH0cmz6IQY_Y_V.vbRjf3QNoEOi1neSm1BwMt1J25B2Tt6TOEiHg0NP5TyWWRCgawcw6oCgjOZjHXgnBPhplBahpYJkcWd5R0.71_.fiqdnDu7be2i8vR2wnhAI0x9ApKWDl1AIoWEtXEZ5Mz2o8H1ddkyGjrB2vEHlLQVmkX5KkTRXV0mhG.30dYFp5jOvvinte9kai8FJ7fo4RWHBdm4oycWcCUmQqGbaZBNs120lk_5YW0ODkwmM.anoXNJVdRSILqqQMTO74gWremBo_1akB8CvKUV4gZtRvSOW
Received: from [75.56.60.139] by web65401.mail.ac4.yahoo.com via HTTP; Sun, 25 Oct 2009 09:53:21 PDT
X-Mailer: YahooMailRC/211.5 YahooMailWebService/0.7.361.3
In-Reply-To: <87k4yj8ta3.fsf@sanosuke.troilus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131223>


Right now it just recognizes a number at the very beginning of the commit message, but what I should do is make that configure.   That is, I'm using a regex to find the integer, so I can just make that regex be something that's easy to configure.  I'll get that done soon, maybe today.


----- Original Message ----
From: Michael Poole <mdpoole@troilus.org>
To: Corey Trager <ctrager@yahoo.com>
Cc: git@vger.kernel.org
Sent: Sun, October 25, 2009 9:03:48 AM
Subject: Re: [ANNOUNCE]  BugTracker.NET (FOSS) now supports git integration

Corey Trager writes:

> BugTracker.NET is a free, open-source, GPL,  ASP.NET bug tracking app.
> More info at http://ifdefined.com/bugtrackernet.html
>
> With the integration, if you do a commit like...
> git commit  -a -m "123 fixed the bug"
> ...then the hook script will link up the commit to bug 123.
>
> Here are screenshots of the Subversion integration, which looks pretty much like the git integration:
> http://ifdefined.com/doc_bug_tracker_subversion.html
>
> Feedback very welcome, good or bad.

Does it recognize bug IDs in the footer section of a commit message
(where Signed-Off-By and similar lines typically go)?

Michael Poole


      
