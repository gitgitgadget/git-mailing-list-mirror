From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: problem using jgit
Date: Mon, 21 Jul 2008 02:24:45 -0400
Message-ID: <p06240809c4a9d887fda4@[192.168.1.106]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 08:34:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKoyu-0000OC-AE
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 08:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbYGUGdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 02:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbYGUGdp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 02:33:45 -0400
Received: from deanbrook.org ([66.160.189.173]:38836 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752578AbYGUGdo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 02:33:44 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jul 2008 02:33:44 EDT
Received: from 70.41.163.170 ([70.41.163.170]) by deanbrook.org for <git@vger.kernel.org>; Sun, 20 Jul 2008 23:25:15 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89308>

I've setup a simple test class that integrates jgit to clone a git 
repository. However I'm getting a NullPointerError when 
RevWalk.parseAny ends up producing a null object id.

The code and the stack trace for the error are here:

   http://pastie.org/237711

This problem occurs using the jgit from the master branch from this repo:

   git://repo.or.cz/egit.git
