From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Jan 2011, #01; Tue, 4)
Date: Sat, 8 Jan 2011 20:47:20 +0100
Message-ID: <201101082047.20446.j6t@kdbg.org>
References: <7vipy4dy8y.fsf@alter.siamese.dyndns.org> <4D28AF82.4040102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jan 08 20:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pbelo-0007KZ-4x
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 20:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159Ab1AHTr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 14:47:28 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:2659 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750965Ab1AHTr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 14:47:27 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AA955A7EB0;
	Sat,  8 Jan 2011 20:46:00 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B5BA419F5C4;
	Sat,  8 Jan 2011 20:47:20 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4D28AF82.4040102@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164839>

On Samstag, 8. Januar 2011, Ramsay Jones wrote:
> Junio C Hamano wrote:
> > * rj/test-fixes (2010-12-14) 4 commits
> >  - t4135-*.sh: Skip the "backslash" tests on cygwin
> >  - t3032-*.sh: Do not strip CR from line-endings while grepping on MinGW
> >  - t3032-*.sh: Pass the -b (--binary) option to sed on cygwin
> >  - t6038-*.sh: Pass the -b (--binary) option to sed on cygwin
> >
> > I don't think people on different vintage of Cygwin agreed they are good
> > workarounds---please correct me if I am mistaken.
>
> No, it was different vintages of MinGW not Cygwin. Well, to be more
> precise, it is the different versions of sed that are installed in MinGW by
> the msysGit installer. ;-)
>
> I used msysGit-fullinstall-1.6.4-preview20090729.exe to install msysGit,
> 18 months ago, and my version of sed is quite old. However, these patches
> (which were done mainly for the benefit of cygwin) were written assuming
> the more recent sed version installed by a more recent msysGit installer.
> (judging by commit ca02ad34.) In other words, the sed version on cygwin
> is new enough to know about the -b (--binary) option and so is the more
> recent msysGit installers (but I don't know exactly which version).
>
> I can use my patch #14, which you didn't pick up, to run the above tests
> on my old installation. (Johannes was the only other laggard identified
> and he claims to be upgrading soon! :-D Yeah, I should too.)
>
> So, unless Johannes can think of something I've missed, I think all of
> these commits are good to go...

I've upgraded meanwhile ;-) and have been using this branch since it was 
published the first time. From my POV, these series should go in.

-- Hannes
