Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3361F406
	for <e@80x24.org>; Sat, 23 Dec 2017 00:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756734AbdLWA3G (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 19:29:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:54226 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755934AbdLWA3G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 19:29:06 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmKOI-1f29Pz2U0Q-00ZzWY; Sat, 23
 Dec 2017 01:29:01 +0100
Date:   Sat, 23 Dec 2017 01:29:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Julien Dusser <julien.dusser@free.fr>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Fix urlencode format string on signed char.
In-Reply-To: <9073fcc7-c751-5563-81c8-d4992eefd298@free.fr>
Message-ID: <alpine.DEB.2.21.1.1712230125341.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20171222172437.19505-1-julien.dusser@free.fr> <xmqqk1xeph6r.fsf@gitster.mtv.corp.google.com> <9073fcc7-c751-5563-81c8-d4992eefd298@free.fr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RM1GQJ3jtYjmgWhD+Z8r7wSTngYmYkNzQIjQW2+DU9iT3o6IHF8
 8m8db71NEz7Yxj4rHbVmk6wsJS5Wpg2zuv3tIEiF5ACp2UCLSCD4G5PmL6+uQu/TG4kvL/p
 4oBJqGI7+DQ90Absw6BorbydQXqSnDCps8TcZqmtKZqsjNk3XuJq9X5PPUklpvrjCLQtGBX
 MWorBfPho9J3GmgSeZCGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:faB0WdTftCU=:3VEDKc3wNoh1xK1e45gSLv
 4HQbPgRAZyl4Njx0b9feHiddTAYE1ldNirlj2F8Xd9C/Gm3BUwv9Y+xOiM2tRawT5uaK0JDo8
 OGUCYsNemTNOmgJOnDq1/g/i0PJ5CYy5F024zIOIVN292Bo432MXc//IDdKetIZq4gaBluKgv
 Vss4+fuXN8f0mfqGs+57EomgfjX4P7h1Jr/a8KmwaoEnRtmbOx4keW3DU3NNrOfXxt4UKcUX1
 TArdw3w2HZYIcAA6kyS/FEtutawtJjKiR366NC91PiPRycg/2GTxhDzo2tafUlyE7b2w0mBdU
 YQWwk1CkMp1J3W2gtjA5mGWIrH0Crw900fJoZwvrsExlSsziGwli+XFIZ0jk5SUB80aG2gLvH
 8FiEhiyZwfcnai83dobcieSOBA4LQzvdoJ6zqk3nM3ZczhkOSGaLFERTHKxu2fCQ5fVgKTQnJ
 xuuySCuxEqB/Qw4ntGsxELTd1abQgJNTAV6jTGoTZcACtjFv9KBjQH2Ydp0KT+ZrO/azvr/ZR
 UWSINlCP082RoAyfA9wEkVxGP1CADtd8zZSGD7ryCljJ+w6/nSkcE7q17k6HssODKDWCzeb9s
 ZodKB2fBkB6OjSwxFDF4LWb7o8MyVtddSRwZ8NxHuocUBVaaPMvvH2QaBUrSMytJZXecIep8c
 JQucajOnYKkg+remB+CmjCl0rpFfI03AoDbxUKHCjGMBYPmb26vmjVk9GPMKFtbcw3ipELbz8
 t7dN909ZBt0IKfNE9w8NM+r7oAr+FuZIGEiAbpYNV+UG80OIv/v7MJE4B4oWrt2FcLd8Wf/qN
 T9YWG1kgpIxPE8n8JV4xn8+GhdHlOcnllSR+yklpuhYCU1GKzA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Julien,

On Sat, 23 Dec 2017, Julien Dusser wrote:

> Thank you for review. I didn't find any other error.
> Code in http.c:quote_ref_url() is almost the same but ch is a signed int, so
> there's no issue.

But that ch comes from a signed char *, so it actually *is* an issue: if
you cast a signed char of value -1 to an int, it will still be -1. So
we'll also need:

-- snipsnap --
diff --git a/http.c b/http.c
index 117ddae..ed8221f 100644
--- a/http.c
+++ b/http.c
@@ -1347,7 +1347,7 @@ void finish_all_active_slots(void)
 }
 
 /* Helpers for modifying and creating URLs */
-static inline int needs_quote(int ch)
+static inline int needs_quote(unsigned char ch)
 {
 	if (((ch >= 'A') && (ch <= 'Z'))
 			|| ((ch >= 'a') && (ch <= 'z'))
@@ -1363,11 +1363,11 @@ static char *quote_ref_url(const char *base, const char *ref)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *cp;
-	int ch;
+	unsigned char ch;
 
 	end_url_with_slash(&buf, base);
 
-	for (cp = ref; (ch = *cp) != 0; cp++)
+	for (cp = ref; (ch = (unsigned char)*cp); cp++)
 		if (needs_quote(ch))
 			strbuf_addf(&buf, "%%%02x", ch);
 		else
