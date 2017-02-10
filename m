Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD9F1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbdBJOWA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 09:22:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:55173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdBJOVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 09:21:31 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ln8gj-1butE11nen-00hL57; Fri, 10
 Feb 2017 15:20:28 +0100
Date:   Fri, 10 Feb 2017 15:20:13 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH] fixup! bisect--helper: `bisect_next_check` & bisect_voc
 shell function in C
Message-ID: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:t7Ibjy9YB/kuzAM8SAVaG6wrA+EGh/nLWr3XYrq5NxgOOD9EJeh
 soiove3BAZ4BkpJDVsyK5NKkES5aEcg0i5ONGl2JC7XZMwX7gyz8635T1NYx66tXDjb9wEO
 RLv1ARo56oV2hm9UAcBwYHECqgYrisn0t5M6YRBnLy2rxKJuYADLzXw9W5E0GKqibg8HHJj
 VikWL79DJEiOdyYALEdvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GUf2gPvU++w=:rTU/IZC08Puf9bX/ycOCcF
 2AAl1eZqmk/ajHLPttiqTK/fMAkf5O2HbCdRkTMBpx3TkXyz/2vsERGVroj1phOYx4FTFbpyh
 mXL/xNMeKUy4siRwDNToEntwVPGkdq5fAK99lz7kRpSQStqZ+eHaAjRnJU/rEDIe9qB7tMMXx
 lDX/GVR3azReZA8WPMGzpaQmOGj5iBWujw2v9AJIyc8CcAoDtofcchgMkkCt4/N7q0g+ef4EY
 2PnS/HGtfxmNivVPGwo8FjQZtW3euk27aq6sMDZZpmgUSfPLfuxKXXxEid61QtXi+6nLeu3w9
 3nYJ5cK7pUfR6/noEnJcBNYUGlf+rPa6IrLu7NvrF1XlZQTWyT9tK1vWhjJ0Gl5u3oQvid9VU
 5Z+/5vKQRPQBqBev/AfxcOGuNIQ497/F8/6DJouPvJc4Udiwy8eJneikWELhfcvoDMoBFNdna
 9CQiQEI+z7878mT2C/rLS7Vgsa0EsxCKySQ9qT6v5ZtmU/b3kkoXs+/8fPY4B935ozFB5fGMl
 87J1cHQyM9l2rD9hxh9QD05evUpEXiNdJqTXJgfDuBAad5ykIq28CJKIRiVsnaQZBaCj/HSW8
 +xV5iEabIVQTKW1zxrspMsU1oH7U7i+V1KbT8JC1Py/gygCntS2qHKjG7jeeGFOJUQGWMekE+
 RgJekTGnxHMVkmkxeSBfp+29s6ZaeUiEB+8Dqo+gDH8Fk3VzT4t9K8lXSe0+11sIe7NGE9SQW
 iJcb4SgChzCrE6Pib2t46wQl6aaFE2mNDKTX2rqp7Gn1DjTDyHfAeaUPiN2wLNY5bfeDe/NKz
 5obcAWNCSXX8rGa2DoRUjF+oZMNkIhCJZDNC2NKUttZBFLDhdf2WauIDAmEJymk3fSwgUjkJo
 +5s+zyhKYhpM8OYK2dNNQh/Morjn4ubun8TI0LQAgoVrJxlnm7G59C5NOtC+aN+8epTGGGv+t
 a/9KOt7MDEvrD1jg7jXUAbBbXzZVL0xv55/T13oiiughrjd4Gl6JBVf3uWU9dhUV84IzWffRe
 sQMegsW9SzbQKl8IbzD3cwER1S2YA79sDQCo6/m4oa5X+8Am2NcG7oIL8Qdz9/b1uA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is curious that only MacOSX builds trigger an error about this, both
GCC and Clang, but not Linux GCC nor Clang (see
https://travis-ci.org/git/git/jobs/200182819#L1152 for details):

builtin/bisect--helper.c:299:6: error: variable 'good_syn' is used
		uninitialized whenever 'if' condition is true
		[-Werror,-Wsometimes-uninitialized]
        if (missing_good && !missing_bad && current_term &&
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
builtin/bisect--helper.c:350:7: note: uninitialized use occurs here
        if (!good_syn)
             ^~~~~~~~

If you "re-roll" (or, as pointed out at the Contributors' Summit, better
put: if you send another iteration of the patch series), please squash
this fix in.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Based-On: pu at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git pu
Published-As: https://github.com/dscho/git/releases/tag/bisect--helper-fixup-v1
Fetch-It-Via: git fetch https://github.com/dscho/git bisect--helper-fixup-v1

 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8cd6527bd1..614a85ffb5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -280,7 +280,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 	int missing_good = 1, missing_bad = 1, retval = 0;
 	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	char *good_glob = xstrfmt("%s-*", terms->term_good);
-	char *bad_syn, *good_syn;
+	char *bad_syn = NULL, *good_syn = NULL;
 
 	if (ref_exists(bad_ref))
 		missing_bad = 0;

base-commit: 6fa4b393c01a84c9adf2e2435fba6de13227eabf
-- 
2.11.1.windows.1
