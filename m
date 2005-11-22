From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] remove unused variable
Date: Tue, 22 Nov 2005 15:58:41 +0100
Message-ID: <81b0412b0511220658y31e7d0feuea0729706ca3a11d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4898_14022581.1132671521975"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 22 16:01:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeZbo-0001IL-8r
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 15:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVKVO6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 09:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVKVO6o
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 09:58:44 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:38879 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964957AbVKVO6n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 09:58:43 -0500
Received: by nproxy.gmail.com with SMTP id n28so140409nfc
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 06:58:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=fyD4fAXsw08g+j8pVmZhr3aKRN2OFW8O0bebFtCV0Q0BbhuHzuV3CvGRt6EtbRYk8wsLCFrRAdqhrOR5Uc2rgVqIHdu3eYc0OHsRVxJjFGZfgUaloIR+ACiu0Xes/Y9BC0isDFLaweBerRh9WTQ4kmEKhbqGBwd/v649LtTK6WY=
Received: by 10.48.230.18 with SMTP id c18mr389266nfh;
        Tue, 22 Nov 2005 06:58:41 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Tue, 22 Nov 2005 06:58:41 -0800 (PST)
To: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12552>

------=_Part_4898_14022581.1132671521975
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It is just assigned, nothing more.

------=_Part_4898_14022581.1132671521975
Content-Type: text/plain; name=0002-remove-unused-variable.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0002-remove-unused-variable.txt"

Subject: [PATCH] remove unused variable

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>


---

 pack-redundant.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

applies-to: da2488b3948b36edb6f468ad16e247d500679f01
0aeca0da8c4184a8ace0f70ff611527c7f2df75a
diff --git a/pack-redundant.c b/pack-redundant.c
index 3681170..8b37da9 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -493,12 +493,10 @@ static void load_all_objects(void)
 {
 	struct pack_list *pl = local_packs;
 	struct llist_item *hint, *l;
-	int i;
 
 	llist_init(&all_objects);
 
 	while (pl) {
-		i = 0;
 		hint = NULL;
 		l = pl->all_objects->front;
 		while (l) {
---
0.99.9.GIT

------=_Part_4898_14022581.1132671521975--
