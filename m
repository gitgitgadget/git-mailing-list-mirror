From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 0/4] builtin-status: submodule summary support
Date: Sat, 12 Apr 2008 23:05:29 +0800
Message-ID: <1208012733-18211-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 12 17:06:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkhJL-0003cF-Tk
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYDLPFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 11:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbYDLPFi
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:05:38 -0400
Received: from mail.qikoo.org ([60.28.205.235]:45351 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752611AbYDLPFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:05:37 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 1CDB0470AE; Sat, 12 Apr 2008 23:05:33 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79356>

The 2nd patch of v2 are splitted to 2 patches in v3 (the 1st and 3rd one)
to support bool/int behaviour of status.submodulesummary.

The other 2 patches are the same as v2.

Ping Yin (4):
      config.c: Add git_config_bool_or_int to handle bool/int variable
      git-submodule summary: --for-status option
      builtin-status: submodule summary support
      buitin-status: Add tests for submodule summary
