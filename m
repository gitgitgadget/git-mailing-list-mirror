From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/7] Bisect dunno
Date: Sun, 14 Oct 2007 14:28:26 +0200
Message-ID: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 14:21:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih2TN-0000tZ-W5
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 14:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbXJNMVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 08:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755202AbXJNMVY
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 08:21:24 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:38778 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbXJNMVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 08:21:23 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 79F9E1AB302;
	Sun, 14 Oct 2007 14:21:21 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 3B7E71AB2CE;
	Sun, 14 Oct 2007 14:21:21 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60834>

Hi all,

Here is my bisect dunno patch series again.
The changes since last time are the following:

[PATCH 1/7] rev-list: implement --bisect-all
[PATCH 2/7] Bisect: fix some white spaces and empty lines breakages.

-> No change.

[PATCH 3/7] Bisect: implement "bisect dunno" to mark untestable revisions.

-> Added dunno stuff in "bisect_replay" that I had forgotten.
-> Use "bisect_write_good" and "bisect_write_bad" in "bisect_replay" 
while at it.

[PATCH 4/7] Bisect: factorise "bisect_write_*" functions.
[PATCH 5/7] Bisect: factorise some logging into "bisect_write".
[PATCH 6/7] Bisect: factorise "bisect_{bad,good,dunno}" into "bisect_state".

-> Some new factorisation and clean up work.

[PATCH 7/7] Bisect: add "bisect dunno" to the documentation.

-> Document "bisect dunno" and fix some short usage descriptions.

Regards,
Christian.
