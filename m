From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: [msysGit] Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Mon, 13 Apr 2015 10:54:16 +0300
Message-ID: <20150413105416.8a2d12b530344a61f5ecb0f1@domain007.com>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
	<39e23864-b75b-4fef-ab90-3413e4e76900@googlegroups.com>
	<b1cc6ba927238fdaa68f685be42002c7@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rupert thurner <rupert.thurner@gmail.com>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 13 09:54:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhZCO-0002As-HF
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 09:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbbDMHyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 03:54:24 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:42791 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbbDMHyX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 03:54:23 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	(authenticated bits=0)
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id t3D7sGxE022294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Apr 2015 10:54:18 +0300
In-Reply-To: <b1cc6ba927238fdaa68f685be42002c7@www.dscho.org>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267068>

On Sun, 12 Apr 2015 19:51:29 +0200
Johannes Schindelin <johannes.schindelin@gmx.de> wrote:

[...]
> > * it is talking german to me
> > 
> > would it be sufficient to delete
> > c:\Apps\gitwin\mingw64\share\locale\de\LC_MESSAGES\
> > resp the whole locale directory to let it speak english?
> 
> Probably. But the canonical solution is to set the `LC_ALL` or `LANG`
> environment variables accordingly.

JFTR, that won't probably fix `git gui` and `gitk` as they are started
directly, not via shell scripts, and hence are unaffected by whatever
tweaks are done in ~/.bashrc *unless* they're started from the
interactive Git bash shell and hence see that environment.

I would hence just stick LC_MESSAGES=en (or LC_ALL, or LANG) into the
environment variables (on the user's level) and solve this problem once
and for all future programs making use of Unix-y locale setup
conventions.
