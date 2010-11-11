From: David Fries <david@fries.net>
Subject: [PATCH 0/3] gitk: improve dark background
Date: Wed, 10 Nov 2010 22:59:54 -0600
Message-ID: <1289451597-6950-1-git-send-email-david@fries.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 06:12:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGPSa-0005MF-IQ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 06:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920Ab0KKFMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 00:12:07 -0500
Received: from SpacedOut.fries.net ([67.64.210.234]:36106 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab0KKFMG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 00:12:06 -0500
X-Greylist: delayed 720 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Nov 2010 00:12:06 EST
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id oAB505Ou007004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 23:00:05 -0600
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id oAB505hm007003
	for git@vger.kernel.org; Wed, 10 Nov 2010 23:00:05 -0600
X-Mailer: git-send-email 1.7.2.3
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Wed, 10 Nov 2010 23:00:05 -0600 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161208>

The gitk preferences allow for the user to select different colors.
The setui is even set to dynamically detect how light or dark the
background is and set the selection color to be the opposite, but
there are a few other color selections that don't currently work with
a dark background such as the black outlines.  This patch improves the
color selection.  In some cases it just needs to use the current
forground color, other places it is more complicated.

The gitk_colors branch can be pulled from,
git://gitorious.org/~dfries/git/dfriess-git-mainline.git

my relevant .gitk config file settings,

set mainfont {Helvetica 8}
set textfont {Courier 8}
set uifont {Helvetica 9 bold}
set uicolor grey85
set bgcolor black
set fgcolor white
set colors {green red blue magenta darkgrey brown orange}
set diffcolors {red green cyan}
set markbgcolor #404060
set selectbgcolor gray50
