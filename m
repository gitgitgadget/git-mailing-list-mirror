From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Adding --gpg-sign to cherry-pick, revert, am, rebase
Date: Sun,  3 Nov 2013 16:54:16 +0100
Message-ID: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 16:54:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd00s-0007t8-Vx
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 16:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806Ab3KCPyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 10:54:37 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:35769 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab3KCPyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 10:54:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 2CADB48BC
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:54:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uIvDSs32Eyab for <git@vger.kernel.org>;
	Sun,  3 Nov 2013 16:54:50 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id B2EDB3ECC
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:54:50 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 3D5BC43934; Sun,  3 Nov 2013 16:54:34 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237261>

Hello,

Here is a series of patches to add the --gpg-sign option to be able to
gpg sign commits, to the cherry-pick, revert, am and rebase commands.

Nicolas
