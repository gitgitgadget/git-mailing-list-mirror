From: Maxim Bublis <satori@yandex-team.ru>
Subject: [PATCH 0/2] fast-import: fix segfault and tests
Date: Thu, 28 Aug 2014 18:54:32 +0400
Message-ID: <1409237674-74185-1-git-send-email-satori@yandex-team.ru>
Cc: Maxim Bublis <satori@yandex-team.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 16:55:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN16b-0005uJ-Sg
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 16:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaH1Oy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 10:54:56 -0400
Received: from 95.108.175.165-red.dhcp.yndx.net ([95.108.175.165]:55954 "EHLO
	95.108.175.165-red.dhcp.yndx.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750823AbaH1Oyz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 10:54:55 -0400
Received: by 95.108.175.165-red.dhcp.yndx.net (Postfix, from userid 1533206276)
	id 1BB8E2046B1D; Thu, 28 Aug 2014 18:54:54 +0400 (MSK)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256092>

Removing root tree with filedelete command would lead to segmentation fault
in store_tree(). First patch from patch series adds test to show incorrect
behaviour and second one fixes bug by sanity check and load_tree() usage.

Maxim Bublis (2):
  t9300: test filedelete root
  fast-import: fix segfault in store_tree()

 fast-import.c          |  6 +++++-
 t/t9300-fast-import.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

-- 
1.8.5.2 (Apple Git-48)
