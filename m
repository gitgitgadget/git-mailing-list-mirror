From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/2] Fix reference name format check and normalization
Date: Sat, 27 Aug 2011 06:12:42 +0200
Message-ID: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 06:13:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxAH5-0006gZ-8D
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 06:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755Ab1H0EN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 00:13:28 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35071 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1H0EN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 00:13:28 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED1A9.dip.t-dialin.net [84.190.209.169])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7R4DCBV009101;
	Sat, 27 Aug 2011 06:13:12 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180217>

This patch series consists of "Do not allow refnames to start with a
slash" as previously submitted (and improved by Junio) and a second
patch that forbids DEL characters in reference names and adds tests of
control characters in reference names.  It should be applied to maint.

Michael Haggerty (2):
  check-ref-format --print: Normalize refnames that start with slashes
  Forbid DEL characters in reference names

 builtin/check-ref-format.c  |    6 +++---
 refs.c                      |    2 +-
 t/t1402-check-ref-format.sh |    9 +++++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
1.7.6.8.gd2879
