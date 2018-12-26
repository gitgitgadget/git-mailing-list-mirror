Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD809211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 23:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeLZXFt (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 18:05:49 -0500
Received: from sonic315.consmr.mail.bf2.yahoo.com ([74.6.134.253]:44534 "EHLO
        sonic315-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726966AbeLZXFt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 18:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1545865548; bh=aHCDJPX9Tdx+uImJw/KTaMH/aCokILHqrz6P5Eng9Ks=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kQtC4L62F7STWz+rv7UcQqEeBZ8kLWJGY3TyZ0U8yVKGAnB5MNxbLbf90NdxILRAaConjFbIYXmWC8kHw/PkkUSt187y5eqcWN/Qsb2YNlFVHkiPf4fmmit4JQp0i3ZlnyPUAufTyvd2/Z9PyxAzWyzmz+PrM/mjKD2AmNnLicwuCK2EpaVouIwhtD7sNeaq2DpPibO/W42J4vOuBuM+uVQuefUuxden0+KBaCnGDLCv6jp0j3bdOj5YT9jdzQc0X3sOgwcMEKzgXa1OcIWYWZwU90URpwh68+8LLDZt3wqnEHKDNHBw89rsYqZ9NffxHbCDiPC5DupSJai2Y1oknA==
X-YMail-OSG: 1fwhZ9IVM1kFF5lqlUldg8mk0bt1mCtbxjW9Adjr__CE400bmFvG7cLBYvO.6eY
 VQqRH3h5CVjaxuXKsIRc4P2_gMynqJRhQvmzIHRZ2Zc_tF7ps89EQa6Ng_PJe6gP0RPNCSQweh1R
 WHZTBR.RJuT36VpoLa2EjHGSYx_2a11YzR..0O8xzVzsraWYV.4iP6Pfnfp8YwqH_5JM6WjU7eRv
 UKn2YOfPpX5YBaeouq8PZNYfzElLifo3ypclyTcm5zCEcv2Q.Wz9Pf_L3p1pTA8X3JPaG6nnaxGQ
 _PZYpeUg0k1qzd5lYcyPP0YFQSgxWA_EjvJFALfGBawuIU.l231ARUeaLx1FxWFfIzzXXYgDS0uo
 Q8wNyTDlsupYHYwIw.8Tp_yiS69y9XdWoMccUJNMhg9AmnPjART5Fp7pcFmYxqhhS5AlT7aL9b5Y
 tEOCaAbY.CDXAoaiAbk8B4Yi8ZFDcy6EhP2MKQhARxsuy.Hyj64RqFoxlf3sdykR7nBbLCWNjBHY
 8OAiD0WF3iB4DaoQCwmy._TrCjYS.kJZcIYzree39FhcXTVknNznLWHpNCfeCwU8KBauQMF7Fb0f
 lbHl_.9Zi3sd19Rj9WrH0B8m3me1pSTgCZOlaqVHLKw4koiVbDOTJRheAhAfEw9pl2d0.0tn7Evj
 veHY5xnZogUEtHtsuYcXk9_5tb1sX.o9IjRrtKvjbTIzYTqgSzp8YFlyWWxeqdU3h9WCSOtjrQGp
 AcT1fj7bBVRN3VAAQh7jqIlsBHrXQ4ml._wgbD7714QPfbjn6MEv0VY2VVP5iHrVGHH3VR4vHUWZ
 Lgyp_LVfe55Hz4H_0PSIT0iZ8zJhiiUpKEwB1.AJNSEM8Zljxwtn0wa7jgoaxa3PrzKY5Zx4PNsz
 He2jVd6_iz92ZUYSX5iiVuLhKQgovXZ4f4Fv0g59y7_dNi5oQjT2JMvQ3bP0NLCPvfzCX2Q5Gtzg
 kYsGYWW7JlCME6FViwystB8mlT5aYU_INziRfvH1ZvNryHPu49kAj2Eml1diJl7BK_Xkl1lKYWgc
 RoiEsw2NmJRsECvFOLziuJbZqkj1KM7xHCVQ2_N3jKYxiAVIykwLDjPmMZSUp85E7k3X6uSzJ1vh
 q53.0vkYud25_sXZWHL1MGRf8Qw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Wed, 26 Dec 2018 23:05:48 +0000
Received: from 99.229.179.249 (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 98f6f8df7851f5cc32b027b3d2c09fa1;
          Wed, 26 Dec 2018 23:05:46 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 1/4] transport-helper: use xread instead of read
Date:   Wed, 26 Dec 2018 18:05:20 -0500
Message-Id: <20181226230523.16572-2-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181226230523.16572-1-randall.s.becker@rogers.com>
References: <20181226230523.16572-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This fix was needed on HPE NonStop NSE and NSX where SSIZE_MAX is less than
BUFFERSIZE resulting in EINVAL. The call to read in transport-helper.c
was the only place outside of wrapper.c where it is used instead of xread.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index bf225c698f..a290695a12 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1225,7 +1225,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
 		return 0;	/* No space for more. */
 
 	transfer_debug("%s is readable", t->src_name);
-	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
+	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
 	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
 		errno != EINTR) {
 		error_errno(_("read(%s) failed"), t->src_name);
-- 
2.17.0.10.gb132f7033

