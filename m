From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Mon, 18 Jan 2010 16:30:46 +0100
Message-ID: <4B547EA6.5070203@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 16:42:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWtkX-0005sw-Ve
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 16:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab0ARPme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 10:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873Ab0ARPme
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 10:42:34 -0500
Received: from mailgw1.uni-kl.de ([131.246.120.220]:49204 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab0ARPmd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 10:42:33 -0500
X-Greylist: delayed 725 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2010 10:42:33 EST
Received: from dfki.uni-kl.de (dfki-1002.dfki.uni-kl.de [131.246.195.2])
	by mailgw1.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id o0IFUQem003069;
	Mon, 18 Jan 2010 16:30:26 +0100
Received: from serv-2100.kl.dfki.de (serv-2100.kl.dfki.de [192.168.21.180])
	by dfki.uni-kl.de (8.13.8+Sun/8.11.4) with ESMTP id o0IFUQEh001293;
	Mon, 18 Jan 2010 16:30:26 +0100 (CET)
Received: from [192.168.21.153] (pc-2163.kl.dfki.de [192.168.21.153])
	by serv-2100.kl.dfki.de (8.13.8+Sun/8.13.8) with ESMTP id o0IFUP58006076;
	Mon, 18 Jan 2010 16:30:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137387>

Hi!

I have been using submodules for a while, and been quite happy with
them.  Just updating to the latest next (1.6.6.443.gd7346), a strange
problem has occurred.  All my submodules (which are in fact unmodified)
show as modified and dirty

diff --git a/extern/utils b/extern/utils
--- a/extern/utils
+++ b/extern/utils
@@ -1 +1 @@
-Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1
+Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1-dirty


Anyone have an idea what is going on here?  (Related to the recent topic
by Jens Lehmann? cc:ed)  Unfortunately, I don't have the time to dig
into this right now, but I'll try to do it later tonight if the problem
remains.

/Gustaf
