From: David Fries <david@fries.net>
Subject: [PATCH 0/3] gitk: improve dark background
Date: Fri, 26 Nov 2010 16:41:36 -0600
Message-ID: <20101126224136.GA26477@spacedout.fries.net>
References: <1289451597-6950-1-git-send-email-david@fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 23:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM6zN-000076-RT
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 23:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab0KZWlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 17:41:52 -0500
Received: from SpacedOut.fries.net ([67.64.210.234]:47255 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0KZWlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 17:41:51 -0500
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id oAQMfb1N026706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 26 Nov 2010 16:41:37 -0600
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id oAQMfaNB026705;
	Fri, 26 Nov 2010 16:41:36 -0600
Content-Disposition: inline
In-Reply-To: <1289451597-6950-1-git-send-email-david@fries.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Fri, 26 Nov 2010 16:41:37 -0600 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162282>

Junio,

I submitted the 'gitk: improve dark background' patch to the list,
made improvements based on the feedback, and submitted the result two
weeks ago without any further feedback.  I put my changes off of
master, but gitk is identical in both maint and master.  Can you pull
the changes?

branch gitk_colors from
git://gitorious.org/~dfries/git/dfriess-git-mainline.git

This e-mail is also a replay to the last posting of the patches.

On Wed, Nov 10, 2010 at 10:59:54PM -0600, David Fries wrote:
> The gitk preferences allow for the user to select different colors.
> The setui is even set to dynamically detect how light or dark the
> background is and set the selection color to be the opposite, but
> there are a few other color selections that don't currently work with
> a dark background such as the black outlines.  This patch improves the
> color selection.  In some cases it just needs to use the current
> forground color, other places it is more complicated.
> 
> The gitk_colors branch can be pulled from,
> git://gitorious.org/~dfries/git/dfriess-git-mainline.git
> 
> my relevant .gitk config file settings,
> 
> set mainfont {Helvetica 8}
> set textfont {Courier 8}
> set uifont {Helvetica 9 bold}
> set uicolor grey85
> set bgcolor black
> set fgcolor white
> set colors {green red blue magenta darkgrey brown orange}
> set diffcolors {red green cyan}
> set markbgcolor #404060
> set selectbgcolor gray50

-- 
David Fries <david@fries.net>
http://fries.net/~david/ (PGP encryption key available)
