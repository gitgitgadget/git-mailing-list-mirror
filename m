From: Josef Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] guilt: add option guilt.diffstat
Date: Sat, 13 Dec 2008 01:23:13 -0500
Message-ID: <20081213062313.GE15407@josefsipek.net>
References: <20081213021422.GA28249@localhost> <20081213044357.GD15407@josefsipek.net> <200812130018.56061.bss03@volumehost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wu Fengguang <fengguang.wu@intel.com>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 07:24:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBNvX-0006de-TT
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 07:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577AbYLMGXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 01:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755553AbYLMGXP
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 01:23:15 -0500
Received: from josefsipek.net ([141.211.133.196]:38318 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512AbYLMGXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 01:23:14 -0500
Received: by josefsipek.net (Postfix, from userid 1000)
	id AA3261C01BA2; Sat, 13 Dec 2008 01:23:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200812130018.56061.bss03@volumehost.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102990>

On Sat, Dec 13, 2008 at 12:18:50AM -0600, Boyd Stephen Smith Jr. wrote:
> On Friday 2008 December 12 22:43:57 Josef Jeff Sipek wrote:
> >> +		if [ -n "$5" -o "x$diffstat" = "x1" ]; then
> >
> >Why the 'x' thing? I've seen it is some scripts before, but I can't think of
> >a reason to use it if the variable is surrounded in quotation marks.
> 
> '[' or test see the arguments after they are unquoted (normally).  So, 
> if "$diffstat" is "-n" it might try and do the -n test, rather than the = 
> test.

Oh. I haven't even thought of that posibility!

> It could be re-written as "1" == "${diffstat}" instead to avoid the x, but 
> it's not a big deal (to me).  That also looks backwards to a lot of people.

Including me.

Thanks for the info.

Josef 'Jeff' Sipek.

-- 
Penguin : Linux version 2.6.25.4 on an i386 machine (6135.73 BogoMips).
