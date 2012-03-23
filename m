From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [GIT GUI PATCH 0/2] teach git gui to open the configured editor
Date: Fri, 23 Mar 2012 18:30:26 +0100
Message-ID: <cover.1332523097.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:37:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB8Qy-000419-A4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000Ab2CWRhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:37:46 -0400
Received: from darksea.de ([83.133.111.250]:59638 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755227Ab2CWRhp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 13:37:45 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Mar 2012 13:37:45 EDT
Received: (qmail 14360 invoked from network); 23 Mar 2012 18:31:02 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Mar 2012 18:31:02 +0100
X-Mailer: git-send-email 1.7.10.rc1.29.gf035d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193775>

This patch series adds a new right click menuitem which allows the user
to open the configured editor with the currently viewed file. For some
popular editors it is also able to move the cursor close to the watched
line.

Please have a look at the parsing of the configured editor commandline.
I tested it for most situations. Maybe someone has an idea for a more
elegant way to split up between arguments and command.

Currently I substitute all ' with " and then abuse the lindex command for
trimming and splitting.

Cheers Heiko

Heiko Voigt (2):
  git-gui: teach _which procedure to work with absolute paths
  git-gui: add "open in editor" diff context menu entry

 git-gui/git-gui.sh |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

-- 
1.7.10.rc1.29.gf035d
