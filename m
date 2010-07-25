From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH av/i18n 2/2] Make git-sh-i18n executable
Date: Sun, 25 Jul 2010 11:50:56 +0200
Message-ID: <d890d9ba7d967e6a191cb47194379d8f9ca5cd0d.1280051448.git.trast@student.ethz.ch>
References: <ba054975988a4a799bcd81a74acd865815ae9bf5.1280051448.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 11:51:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcxrN-0006Ri-SF
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 11:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587Ab0GYJvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 05:51:00 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:24298 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab0GYJu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 05:50:58 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Jul
 2010 11:50:56 +0200
Received: from localhost.localdomain (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 25 Jul
 2010 11:50:56 +0200
X-Mailer: git-send-email 1.7.2.289.g93c76
In-Reply-To: <ba054975988a4a799bcd81a74acd865815ae9bf5.1280051448.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151720>

git-sh-i18n was not picked up by the valgrind wrapper code because
that tests for the executable bit.  Since there does not seem to be a
particular reason why it needs to be non-executable, and this is the
path of least special-casing to fix --valgrind testing, just make it
executable.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 git-sh-i18n.sh

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
old mode 100644
new mode 100755
-- 
1.7.2.289.g93c76
