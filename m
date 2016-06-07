From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v4 0/3] Documentation more consistent
Date: Wed,  8 Jun 2016 00:35:04 +0200
Message-ID: <20160607223507.18061-1-tom.russello@grenoble-inp.org>
References: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
Cc: erwan.mathoniere@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	jordan.de-gea@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 00:39:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPbI-0003jB-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423395AbcFGWfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:35:30 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:49558 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161390AbcFGWf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:35:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id CE4FE256B;
	Wed,  8 Jun 2016 00:35:23 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6FAUPBq2C5CA; Wed,  8 Jun 2016 00:35:23 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3528A24F3;
	Wed,  8 Jun 2016 00:35:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 2B76B2066;
	Wed,  8 Jun 2016 00:35:23 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yN_ribk_kqLp; Wed,  8 Jun 2016 00:35:23 +0200 (CEST)
Received: from ux-305.numericable.fr (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id E574D2064;
	Wed,  8 Jun 2016 00:35:22 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296745>

Hello,
as `MAN_BOLD_LITERAL` knob is just now turned on by default with 5945717
(Documentation: bold literals in man, 2016-05-31), it is the right time to
make our documentation more consistent.

 Documentation/CodingGuidelines        |  13 ++++--
 Documentation/config.txt              |  58 ++++++++++++-------------
 Documentation/date-formats.txt        |   2 +-
 Documentation/diff-generate-patch.txt |   2 +-
 Documentation/git-bisect-lk2009.txt   |   2 +-
 Documentation/git-bisect.txt          |   2 +-
 Documentation/git-commit.txt          |   4 +-
 Documentation/git-config.txt          |   2 +-
 Documentation/git-daemon.txt          |   2 +-
 Documentation/git-filter-branch.txt   |   2 +-
 Documentation/git-help.txt            |   2 +-
 Documentation/git-http-backend.txt    |   8 ++--
 Documentation/git-init.txt            |   2 +-
 Documentation/git-log.txt             |   4 +-
 Documentation/git-notes.txt           |  20 ++++-----
 Documentation/git-p4.txt              |   4 +-
 Documentation/git-quiltimport.txt     |   4 +-
 Documentation/git-replace.txt         |   2 +-
 Documentation/git-sh-setup.txt        |   2 +-
 Documentation/git.txt                 | 122 ++++++++++++++++++++++++++--------------------------
 Documentation/gitremote-helpers.txt   |   2 +-
 Documentation/gitweb.conf.txt         |   2 +-
 Documentation/gitweb.txt              |   4 +-
 Documentation/merge-config.txt        |   2 +-
 24 files changed, 138 insertions(+), 131 deletions(-)
