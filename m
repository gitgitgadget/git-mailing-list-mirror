From: Strasser Pablo <strasserpablo@bluewin.ch>
Subject: Segfault in git 1.8.1.5
Date: Sat, 09 Mar 2013 21:16:03 +0100
Message-ID: <2078462.OF4zRmv4ar@pablohp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 21:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEQIt-000857-42
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 21:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab3CIUXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 15:23:13 -0500
Received: from zhhdzmsp-smta16.bluewin.ch ([195.186.227.132]:44483 "EHLO
	zhhdzmsp-smta16.bluewin.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751327Ab3CIUXM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Mar 2013 15:23:12 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2013 15:23:12 EST
Received: from [195.186.99.131] ([195.186.99.131:62884] helo=zhbdzmsp-smta13.bluewin.ch)
	by zhhdzmsp-smta16.bluewin.ch (envelope-from <strasserpablo@bluewin.ch>)
	(ecelerity 2.2.3.47 r(39824M)) with ESMTP
	id 7C/4D-25143-4889B315; Sat, 09 Mar 2013 20:16:05 +0000
Received: from pablohp.localnet (178.193.146.219) by zhbdzmsp-smta13.bluewin.ch (8.5.142) (authenticated as strasserpablo)
        id 5100862203F4D749 for git@vger.kernel.org; Sat, 9 Mar 2013 20:16:04 +0000
User-Agent: KMail/4.10.1 (Linux/3.7.10-1-ARCH; KDE/4.10.1; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217760>

Hello,

I segfault with the following command:

git checkout HEAD~1
git branch -u origin/master

I think it's because i'm in detached head.
A error message like cannot use this command in would be a better responce 
than a segfault.

Good day.
