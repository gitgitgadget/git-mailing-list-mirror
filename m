From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v5 0/5] git-submodule summary
Date: Tue, 11 Mar 2008 21:52:14 +0800
Message-ID: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 11 14:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4uj-0006eX-U2
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYCKNwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbYCKNwX
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:52:23 -0400
Received: from mail.qikoo.org ([60.28.205.235]:57648 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751956AbYCKNwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:52:22 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id BF7D4470AE; Tue, 11 Mar 2008 21:52:19 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76847>

Relative to v3 series, this series has following changes:

- Improve and fix 'show commit summary' patch
  * Remove --left-right when showing summary for modified modules
  * Remove '%h' from "--pretty=format:" for added/deleted/typechanged
    modules
  * Also compute sha1 for blob when blob has sha1 0{40}
- Merge commit log and document patch from junio
- Add test
