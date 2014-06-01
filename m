From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/4] Add --graft option to git replace
Date: Sun, 01 Jun 2014 17:10:33 +0200
Message-ID: <20140601150409.15428.27017.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 17:11:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wr7QK-0000O8-Hd
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 17:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbaFAPLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 11:11:39 -0400
Received: from [194.158.98.14] ([194.158.98.14]:45818 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752288AbaFAPLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 11:11:36 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 6288E39;
	Sun,  1 Jun 2014 17:11:06 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250527>

Here is a small patch series to implement:

        git replace [-f] --graft <commit> [<parent>...]

This patch series goes on top of the patch series that
implements --edit.

The changes since v1 are the following thanks to Eric,
Junio and Peff:

- change commit message of patch 1/4
- added patch 4/4 that was previously sent separately
- in patch 4/4 rename the existing grafts file
  into grafts.bak

Christian Couder (4):
  replace: add --graft option
  replace: add test for --graft
  Documentation: replace: add --graft option
  contrib: add convert-grafts-to-replace-refs.sh

 Documentation/git-replace.txt             | 10 ++++
 builtin/replace.c                         | 84 ++++++++++++++++++++++++++++++-
 contrib/convert-grafts-to-replace-refs.sh | 29 +++++++++++
 t/t6050-replace.sh                        | 12 +++++
 4 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100755 contrib/convert-grafts-to-replace-refs.sh

-- 
2.0.0.rc0.40.gd30ccc4
