Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067DD1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756558AbcH2IEV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:04:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:63878 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756414AbcH2IEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:04:15 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lat5o-1bFu5D1bCq-00kQiP; Mon, 29 Aug 2016 10:04:03
 +0200
Date:   Mon, 29 Aug 2016 10:03:48 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/22] sequencer: use static initializers for replay_opts
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <66d69469a64bd80d3bf2b99a250ae04a649d94d1.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eD9xF44HcG+doopsoLZ2NIyFqNybhPWRhnfW3zNzRLR+084isoJ
 JFpWFwY7d90QImgUdVaHorB0QsCBrpAl+iliRnhWvE9QutEpT7iHGqxhW/ZT6c9jMjq00Vz
 gIub/k8PqPIS65900guUjJdek0KVz+MWR8iFGsGv34beYxXqaTmdJ0iZyGHHBBG4+1FRkcx
 Hx9Kg3o1AwDx0pPwyLo1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mrXdOecLq70=:g0WiaZFGSn2fT1/2DXUiaJ
 zxTcN0sMrbbrpoplKNmkeGyTZYhNtfapBAPtLdXlsuEuawk6zzJmKAyMQr+iifpA59oXvIH8u
 URoL0uhFEAG4HzMEp7U9Ngj6bGsTyjk9ED29NZo4AGCMIqOo6C85LdCYST6RC+mU+BmcTfznD
 2z/XDgrWKKk6SxfTp9GspNkfuVjkT1YlnC0kLN70A2z6tx/wOJf86wuJw9N8EwdlzTld3Kh5p
 +z74S553OKVI+gCWFY6YJFwCOh80TsqLm7pDn9rPG4YzEaHmj0DA6XRMo5Y7x8DVgZVCLZ1Nz
 dJwn2HfqRCow44/1WVfIpasvdpeIbcmW8thpna9TAO60EJfjT9GzWcv6tZ8ADLVtOzUrvQCI5
 E7KNMjkOeLtRUkGg4Y+NuoQD9t28rhmQRbGB0KnaCHVrZqLCdlbrqj+t6DDojqBpmNqo/GCXW
 Lb9juNXTDPD5ilG5spUAgJlq3INMHSL7YQ+lGhti3u1P0nYnf1SIWMc65wpsfay4nL56FVSc5
 8HFH42EKT1rwxKh5R1JuYD7YnETDtk8XALrDOymYv+gEaZ0U/zZgate7Ej2opeXxh6CI6aRFW
 it2w6XZOEhYEKnNmSGTBiHBK7IfSW4x0cdnLwxxl18yEkFy4ekxYdvK4cuHKdtHCO10Se9L7+
 uEQx+AZ1bEaoD4/+1RWHZe7UDTldqC6B0vFlnaGL5MIFWUpOLLcJSLL94Vpj83ksB3UDM66iO
 at0vRnCq6vSYoFHdZ9aX4rCJVioQT4ALhHdmEURb2WwMxpHISPjTgEXUwoEF9garCtyUVDlFq
 PUyt9eL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/revert.c | 6 ++----
 sequencer.h      | 1 +
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 4e69380..7365559 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -178,10 +178,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
-	struct replay_opts opts;
+	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
 
-	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REPLAY_REVERT;
@@ -195,10 +194,9 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
-	struct replay_opts opts;
+	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
 
-	memset(&opts, 0, sizeof(opts));
 	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
diff --git a/sequencer.h b/sequencer.h
index 5ed5cb1..2ca096b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -47,6 +47,7 @@ struct replay_opts {
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
 };
+#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL }
 
 int sequencer_pick_revisions(struct replay_opts *opts);
 
-- 
2.10.0.rc1.114.g2bd6b38


