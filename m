From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH v2 0/2] fix normalization of foreign idents (now with test cases)
Date: Tue, 7 Sep 2010 22:00:24 +0200
Message-ID: <E1Ot4NM-0002xk-Ed@chiyo.mc.pp.se>
References: <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 22:09:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot4U8-0003iV-5S
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 22:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208Ab0IGUJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 16:09:34 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:41682 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758182Ab0IGUJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 16:09:32 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id BEA9AFB16;
	Tue,  7 Sep 2010 22:02:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1283889761; bh=LIJdQnLqEcAx2SfT07Lhsrhvky0l+1HtcNtAfHtOYr0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=HsAD
	Zx+W3gknazZBQ8SaMhT6G8rr6OI6b6AEVr5vBrsGPdP+gehSRHc4I5zfsLd08NMBkcc
	pSeVmJrlGYmk6n4PKS0dQ8rpG6fcb705wzWgcpor7awEcMgTBXXPNICpTC+1BLtXhMc
	5YVX9MSbankmtE3MPabdMfiZ7AAGABOd8=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <f1c36c4f8a6a2d45ee4283ae3bef93abb00bc8a8@chiyo>)
	id 1Ot4NM-0002xk-Ed; Tue, 07 Sep 2010 22:02:40 +0200
In-Reply-To: <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155736>

* Rebased against current master (7505ae2)
* Test cases added

Marcus Comstedt (2):
  convert: fix normalization of foreign idents
  t0021: test checkout and commit of foreign idents

 builtin/apply.c       |    2 +-
 builtin/blame.c       |    2 +-
 cache.h               |    3 +-
 combine-diff.c        |    2 +-
 convert.c             |   23 +++++++++++++++----
 diff.c                |    2 +-
 sha1_file.c           |    3 +-
 t/t0021-conversion.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 84 insertions(+), 11 deletions(-)

-- 
1.7.2
