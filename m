From: mhagger@alum.mit.edu
Subject: [PATCH 0/2] Fix some constness errors in fetch-pack
Date: Wed,  2 May 2012 12:40:57 +0200
Message-ID: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 12:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPWzk-0006EL-V4
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 12:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab2EBKlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 06:41:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37023 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab2EBKlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 06:41:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q42Af4FW009926;
	Wed, 2 May 2012 12:41:04 +0200
X-Mailer: git-send-email 1.7.10
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196797>

From: Michael Haggerty <mhagger@alum.mit.edu>

Fix some constness errors that I noticed while reading the code in
builtin/fetch-pack.c.

Michael Haggerty (2):
  cmd_fetch_pack(): declare dest to be const
  cmd_fetch_pack(): fix constness problem and memory leak

 builtin/fetch-pack.c |  152 +++++++++++++++++++++++++-------------------------
 1 file changed, 77 insertions(+), 75 deletions(-)

-- 
1.7.10
