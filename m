From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/4] Add --graft option to git replace
Date: Wed, 04 Jun 2014 21:43:48 +0200
Message-ID: <20140604194118.23903.3019.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 07:29:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsQEx-0007M1-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 07:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaFEF3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 01:29:06 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:57363 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbaFEF3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 01:29:04 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id A591954;
	Thu,  5 Jun 2014 07:28:58 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250809>

Here is a small patch series to implement:

        git replace [-f] --graft <commit> [<parent>...]

This patch series goes on top of the patch series that
implements --edit.

There is only one change since v2 thanks to Eric:

- improve error messages in convert-grafts-to-replace-refs.sh
  (patch 4/4)

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
