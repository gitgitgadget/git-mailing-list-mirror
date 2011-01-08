From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Jan 2011, #01; Tue, 4)
Date: Sat, 08 Jan 2011 18:40:02 +0000
Message-ID: <4D28AF82.4040102@ramsay1.demon.co.uk>
References: <7vipy4dy8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 19:42:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbdkV-00028z-3Q
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 19:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086Ab1AHSmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 13:42:42 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:37950 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750965Ab1AHSml (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jan 2011 13:42:41 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PbdkO-00018x-dj; Sat, 08 Jan 2011 18:42:40 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vipy4dy8y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164836>

Junio C Hamano wrote:
> 
> * rj/test-fixes (2010-12-14) 4 commits
>  - t4135-*.sh: Skip the "backslash" tests on cygwin
>  - t3032-*.sh: Do not strip CR from line-endings while grepping on MinGW
>  - t3032-*.sh: Pass the -b (--binary) option to sed on cygwin
>  - t6038-*.sh: Pass the -b (--binary) option to sed on cygwin
> 
> I don't think people on different vintage of Cygwin agreed they are good
> workarounds---please correct me if I am mistaken.

No, it was different vintages of MinGW not Cygwin. Well, to be more precise,
it is the different versions of sed that are installed in MinGW by the
msysGit installer. ;-)

I used msysGit-fullinstall-1.6.4-preview20090729.exe to install msysGit,
18 months ago, and my version of sed is quite old. However, these patches
(which were done mainly for the benefit of cygwin) were written assuming
the more recent sed version installed by a more recent msysGit installer.
(judging by commit ca02ad34.) In other words, the sed version on cygwin
is new enough to know about the -b (--binary) option and so is the more
recent msysGit installers (but I don't know exactly which version).

I can use my patch #14, which you didn't pick up, to run the above tests
on my old installation. (Johannes was the only other laggard identified
and he claims to be upgrading soon! :-D Yeah, I should too.)

So, unless Johannes can think of something I've missed, I think all of
these commits are good to go...

ATB,
Ramsay Jones
