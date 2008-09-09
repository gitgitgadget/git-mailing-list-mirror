From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: gitignore patterns
Date: Tue, 9 Sep 2008 15:23:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0809091521120.15561@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 00:24:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdBdZ-0004oD-5X
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 00:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbYIIWXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 18:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbYIIWXd
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 18:23:33 -0400
Received: from xenotime.net ([66.160.160.81]:51992 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753000AbYIIWXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 18:23:32 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <git@vger.kernel.org>; Tue, 9 Sep 2008 15:23:30 -0700
X-X-Sender: rddunlap@shark.he.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95449>

Hi,

In the kernel tree, I see 2 .gitignore files that use "+pattern":

./arch/blackfin/include/asm/.gitignore:+mach
./arch/blackfin/boot/.gitignore:+vmImage

However, I can't find anything about '+' on the gitignore(5) man page
at http://www.kernel.org/pub/software/scm/git/docs/gitignore.html .

Does the '+' mean something special or is it just a character in the
filename/dir pattern?

Thanks,
-- 
~Randy
