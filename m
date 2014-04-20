From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for
 Windows
Date: Mon, 21 Apr 2014 00:10:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com> <20140419184210.GB3617@book-mint>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbzwl-0004SD-Lh
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 00:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbaDTWKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 18:10:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:58909 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbaDTWKm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 18:10:42 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0LcnRD-1XJt8Z0wqd-00k5d3;
 Mon, 21 Apr 2014 00:10:40 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140419184210.GB3617@book-mint>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ksGQcgSASz1J+50fEF1TgRnSLv5mU0bj5cJDJRfqqidS2i4IeO5
 HeJlYeVdXI0lsImSn72iiJin8w9A3q48/V7PKnCNa1Hp+qUDoMPWCVwwyMGG7RitNhLHTo0
 1CAAbKcdA9NkRUspk4/3+GDPEp5csYGouLW94HYxTZisq3c/+dD9TYJA3yjyrCXMRdFNp3M
 nKsj9UUe7jhmimbm/5rOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246594>

Hi Heiko,

On Sat, 19 Apr 2014, Heiko Voigt wrote:

> Regarding mingwGitDevEnv[2]: That is a project started by Sebastian who
> also contributes to msysgit (and Git for Windows).

In fact, Sebastian is not only a contributor. He is co-maintainer of Git
for Windows.

> It eventually can (and probably should) be a successor of the current
> situation [...]

Sebastian hinted at it in many a discussion on the msysgit mailing list
(where those people who are serious about Git for Windows development hang
out, hint, hint, hint) that mingwGitDevEnv was born out of the needs
identified while maintaining Git for Windows.

Our tentative plan is to switch with Git 2.0 (unless the timing turns out
to be unfortunate). We have to put some more effort into mingwGitDevEnv
first, though: due to the differences between the old MSys committed into
msysgit.git repository on the one hand, and the MSys environment
initialized and updated by mingwGitDevEnv on the other hand, some of the
tests do not pass yet. (I also would like to look into getting the
performance improvement Hannes Sixt achieved by his patch [*1*] into
mingwGitDevEnv's Git installation, too.)

Despite the common lack of time and of developers willing to spend time to
contribute to the Git for Windows effort, I think we are well on track,
and it will be pretty exciting when we switch to mingwGitDevEnv-based
development of Git for Windows!

Ciao,
Dscho
