From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH] git-stash: fix usage string
Date: Tue, 03 Jul 2007 07:41:31 +0900
Message-ID: <20070624192216.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 00:52:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Ukt-000590-0i
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 00:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbXGBWwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 18:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbXGBWwY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 18:52:24 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:40926 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbXGBWwY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 18:52:24 -0400
Received: from fe0.bluebottle.com (internal.bluebottle.com [206.188.24.43])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l62MqNkE031618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 15:52:23 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:date:subject:message-id:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=NTXhe2H9+LxhcfA51QO72EJ/fZZu183HpWLx3J2u53mAsvkG3DQDHzHhjvkcsDvSx
	QVc/+Ew/t2wnVXrLJTmsNHLwEpLV4bMt/FuO8Qv1ndG8JJGUTb66A7Jssald+pC
Received: from nanako3.mail.bluebottle.com (eu85-85-72-37.clientes.euskaltel.es [85.85.72.37])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l62MqB5O017260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 15:52:21 -0700
X-Trusted-Delivery: <dfdb892e495130fed1adf7125d745975>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51419>

The command requires an explicit "save" subcommand, but the usage string
does not talk about it.

This matches the usage string with the SYNOPSIS string in the documentation.

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>
---

I do not know if my opinion matters much but I think it is nicer to save a
new stash without a subcommand than to list existing stash data.

 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 18d3322..62f9f7a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2007, Nanako Shiraishi
 
-USAGE='[ | list | show | apply | clear]'
+USAGE='(save | list | show [<stash>] | apply [<stash>] | clear)'
 
 . git-sh-setup
 require_work_tree
-- 
1.5.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Find out how you can get spam free email.
http://www.bluebottle.com
