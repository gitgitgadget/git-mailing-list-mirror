Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0ECA1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeA2UTS (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:19:18 -0500
Received: from mout.web.de ([212.227.15.3]:55712 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754133AbeA2UTM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:19:12 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M4Um4-1eyunj1dDY-00yfUM; Mon, 29
 Jan 2018 21:19:03 +0100
From:   tboegi@web.de
To:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 2/7] strbuf: add xstrdup_toupper()
Date:   Mon, 29 Jan 2018 21:19:01 +0100
Message-Id: <20180129201901.9269-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.2.g64d3e4d0cc.dirty
In-Reply-To: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:CuGsUz2cbYkl+lRf+ZVMtZHN19RPmP+n6dgcT+ELlqLa5RrBi50
 ujc/Ixd7cZTeYHuuMKk2Jmvtl4dw7Skyo0a9zW8Za3I1VqHg8YQW/RhBnRCyahkGLZvKVDt
 bg85Er7K2ruzHMbtjW/tVkp7IaCnRp/WgBLmbrcHTMemx+/vKCegW7HbhuWiLzkhfa3pM6C
 3C2cXKPz+jGexTN82A95Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/ZcBLg1FwJo=:MPZoHQarCim6yiZwAp/Vdp
 i22UyuSWxKpXtZYf6ajCLqadX7B7oNAsaLri/gbIduTofIjfHoQpsx/gQIF4p6Mj0+mz4pPjb
 8kNSIqSkXne9/3LHlewkID2tTUqafIq5okvsH8ldnX5ORNTomuYl3D3XcLh8bOgc/aKK/86eA
 6glBJx8kXKasah4YYX72dUeiwujJZCKpE25Q+QAEMIb7nGRNoIUfZZMvVwech1GjqfL0Hf3H9
 2+NMjaudXq2EcbyRuIlSsAcfEh2l2KQD8/HKQHy0/umYfKvgtnNGAkQ0dL9VCbFrrlR/ArWQl
 iVY6XoSzBeXIcJnqKEWxBueLAGB8kXYjr6yZ/oH2fg0L5kH3KqofaOLneXrnl0VIQdwOsX7Do
 PZb+ZcgS78FBdjyWLPCqPXYUCm1Cgq/FkgU8ohAZsA/gRi3OGIJoHoSde8K5l7FKAF/jf3Iz2
 J3rja0kgAQfDZ5v287k1T2AVNhVTQTDDKh5cLPPjvbTB/JhBW386XjM2vDoaTyxBTTzhhhia6
 W7DbymtOhXFdpSUBMEzqNEmoyNCjDkKAmUUJbnbOJ1E5RrVtcfYl/YdWHad8SQhahGKIQ3Y8Y
 GbUR0OvCtwKMDPV1pyhcGdWRyiyNnnc7nZWU4IvJOw6SdIsXe6zJgdhEb3rxJ/dMd0tbbuaQ6
 +hOd9Ah9DdX+bD/xgWnw2TIX0xlIqglBbIDEDYE7GBJkVUUcgatD+v5qAkbu/S+wBz735Fg2i
 LWiJBeOOxHOwr4RS/GBh58TP/lqJmvUtNCThcpZm0Hu9qzuUoNlSTcNnfqitENHHsF6ggQYWo
 f+igf4CYB9FaG6sk7XyQuXLnbHRErU0HepCAgMguZc9/3PIMeQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Create a copy of an existing string and make all characters upper case.
Similar xstrdup_tolower().

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 strbuf.c | 12 ++++++++++++
 strbuf.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 490f7850e..a20af696b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -784,6 +784,18 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }
 
+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d6..df7ced53e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -607,6 +607,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.16.0.rc0.2.g64d3e4d0cc.dirty

