From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 0/3] Annotate updates
Date: Thu, 2 Mar 2006 00:16:36 -0500
Message-ID: <114127659642-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 06:17:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEgCC-0008Mt-V6
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 06:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWCBFRN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 00:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWCBFRN
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 00:17:13 -0500
Received: from mail.autoweb.net ([198.172.237.26]:27834 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750823AbWCBFRM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 00:17:12 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FEgBZ-00030K-Hq; Thu, 02 Mar 2006 00:17:11 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FEgBR-0000nl-Vn; Thu, 02 Mar 2006 00:17:02 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FEgB2-00043O-F3; Thu, 02 Mar 2006 00:16:36 -0500
In-Reply-To: 
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17048>

The following changes since commit 2b74cffa9179eed274be2a38c59b7e323c813737 are
found in the git repository at:

  http://h4x0r5.com/~ryan/git/ryan.git annotate-upstream

and will follow this email as replies in patch format.

Ryan Anderson:
      Handle \No newline at end of file.
      annotate: Add a basic set of test cases.
      annotate: --rev-file (-S) is not a boolean parameter

 git-annotate.perl   |    8 ++++-
 t/t8001-annotate.sh |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletions(-)
 create mode 100755 t/t8001-annotate.sh
