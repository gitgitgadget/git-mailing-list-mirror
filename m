From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 11/25] gettextize: git-merge "In-index merge" message
Date: Thu,  2 Sep 2010 19:40:32 +0000
Message-ID: <1283456446-22577-12-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFfa-00061i-IW
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637Ab0IBTlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62423 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629Ab0IBTls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:48 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282223wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=bCzbznXJUDQWg+hpuMo1XCi8+2qoCK7uagfa482yVgg=;
        b=BfCCTQ/RAg5DxYLZgGzGQhUhikMaEVGgo76VMadx4giWkXpQa6cwrMYK8m4hUBRZdD
         tRYvjdqzF+Bp2MUgPY8xaInaM3aJAzNQQsvi73ebCWiT7fOGy/hJH/UIFRbrhV9nj327
         cv+EATj+b8J3DGh493mAZA+XWj3oqinfreBQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fZPJHHlYwpi+5CIx4pVJUsmIQiUggAcpcwX4pCGcS/Enu+mI0kPpbc3g5467vFPGkG
         L305P+sCYBW8htQHMBRhjbRvZC/COgOLssBSHrZLPIpcuxhGci9BikluttNj04zj4+iC
         RtVYMpLJrKN/xbM7yLBnytBzGIKTD3vKXd2p8=
Received: by 10.227.151.195 with SMTP id d3mr10053454wbw.170.1283456507443;
        Thu, 02 Sep 2010 12:41:47 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155171>

Make the "In-index merge" message translatable. This just emits to
stdout via finish(), so translating it should be fine.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index bf3b313..956ce14 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -791,7 +791,7 @@ static int merge_trivial(void)
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
 	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
-	finish(result_commit, "In-index merge");
+	finish(result_commit, _("In-index merge"));
 	drop_save();
 	return 0;
 }
--=20
1.7.2.2.614.g1dc9
