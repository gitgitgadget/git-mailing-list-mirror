From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/3] git-help: add new options -w (for web) and -i (for
 info)
Date: Sun, 2 Dec 2007 06:03:28 +0100
Message-ID: <20071202060328.68d35932.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 05:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IygtX-0002WQ-O7
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 05:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbXLBE47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 23:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbXLBE47
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 23:56:59 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:57926 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680AbXLBE46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 23:56:58 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4E6711AB2AE;
	Sun,  2 Dec 2007 05:56:56 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 953EA1AB2A9;
	Sun,  2 Dec 2007 05:56:55 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66754>

Hi,

Here are the changes since my last RFC/PATCH:

[PATCH 1/3] git-help: add -i|--info option to display info page:

- info is now in a separate patch

[PATCH 2/3] git-help: add -w|--web option to display html man page in a browser.

- git-html-help.sh has been renamed git-browse-help.sh
- use web.browser config option instead of web.tool
- look up for the following documentation directories:
	"$PREFIX/share/doc/git-doc"
	"$PREFIX/share/doc/git-core-$GIT_VERSION"
not only the first one 
- add links, lynx and dillo has possible browsers
- git-browse-help.sh accept both -b|--browser and -t|--tool to specify
a browser (to be consistent with both git-mergetool and git-instaweb)
- improved launching of firefox|iceweasel and konqueror

[PATCH 3/3] Use {web,instaweb,help}.browser config options.

- improve consistent use of config options between git-browse-help and
git-instaweb

Thanks for your reviews,
Christian.
