Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35402018E
	for <e@80x24.org>; Wed, 29 Jun 2016 14:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbcF2ObP (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:31:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:52846 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbcF2ObN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:31:13 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LorB9-1boGt527VD-00gsF9; Wed, 29 Jun 2016 16:31:08
 +0200
Date:	Wed, 29 Jun 2016 16:31:07 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] t3404: add a test for the --gpg-sign option
In-Reply-To: <cover.1467210629.git.johannes.schindelin@gmx.de>
Message-ID: <0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de>
References: <cover.1467210629.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eElBMFtzweIwPzh36k9FZ1zffmYfsBvEHQEwgGXAX449uxzgWsm
 bNRV1kGXnL+OgUBRkyHYo+QUM5p6LoGyl3T/miKTc9kHyrEZw5Mi2e+Vu76gy4GgZDV+av/
 /PyLsoSF4Ti4pSkImdMgO1vzrs8LXiaWNnCshCT6asHAAOzIZw5AAnzWsJbWyUdx+N62q0O
 OCify6clIY2jpk4qKF+1w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:AuLUxqjAAhA=:6Xk9/iXfVqg6gqmGeaCocL
 FFe8FmNFiJ5U68Y0rFMMQuxINpT1qfgPuGgF6l0al8zR9H4jVLijwqdOu+fumkr1D6hgr2+NV
 wKYizQhLxUZqYrHrqMsQKER8Me7Jby2msym/eKUlkGEN0Ug6Ghrs4zq62MPSDw1f+wXgom10y
 QNc9NQ04FzUBrGcUb3RRUPloscNgbMT2g49WWYNC1Cm3Tq0RZ7vh66VIB/bwIGnVreweNIAj1
 8pDPRc83lO+xOgrSH8vUvEJnDUzWy1qq10IQhaIMBm3boSsfX7T8DRC5U10ICVjHxlO3/LuUq
 WzFOzlQVp3VAlLhZJ2kxbIWBlHRgUmNmkWnBUv7sT+cGYSSXQ/E8ZObn6QN7OpTs15+MlzHtK
 s/5WXcYL9ML+n29WpWZhwnfHzUDIJf+Ps7V+jM+boLYa18VNU3gdR7QKv+Ww+P8s0pe+0IagX
 T46l1ZrFoRVt7ABpKPdG0jnsVXV58CXdeEYIFo+ZK3nC6OPeXChaK1Agh5GLX2baqMMLUSMI/
 5dZB5PIAZqEGFqDgCd4JmusIdXq+S0wbOU4bxE5L89a7jgLTxgP9IzDrcbIk/VuCIED3csgfv
 p4uL1/e1Lpkupv0kPtLnMJ73sSo6+X4akRqP0Q88JeoeqZYRWbUBTwysXVjKjbgVOEM2ziS70
 5qjdIdhgOg97zeIVUicUDXO2KPeMUirw/FX+L9tlJKALuAslBwwROkYPDWN/nUWvA53wDM/+A
 jabENlGX3dpueVjLUVBwFN2nDFkXc8Jj8UOVLb0TuDaqNli8hksFObRGO+2gxC8Mu4I1l75pT
 szK85Hc
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To keep the time t3404 requires short (in this developer's Windows
setup, this single test already takes a painful 8 minutes to pass),
we avoid a full-blown GPG test and cop out by verifying the message
displayed to the user upon an 'edit' command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c7ea8ba..4c96075 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1281,4 +1281,11 @@ test_expect_success 'editor saves as CR/LF' '
 	)
 '
 
+EPIPHANY="'"
+test_expect_success 'rebase -i --gpg-sign=<key-id>' '
+	set_fake_editor &&
+	FAKE_LINES="edit 1" git rebase -i --gpg-sign=\" HEAD^ >out 2>err &&
+	grep "$EPIPHANY-S\"$EPIPHANY" err
+'
+
 test_done
-- 
2.9.0.270.g810e421
