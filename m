Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9036A20899
	for <e@80x24.org>; Sat, 19 Aug 2017 08:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdHSIMz (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 04:12:55 -0400
Received: from mout.web.de ([217.72.192.78]:57885 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdHSIMy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 04:12:54 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lu52Q-1dYII21CiM-011U9Y; Sat, 19
 Aug 2017 10:12:48 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit: remove unused inline function single_parent()
Message-ID: <0993ee6c-712b-505e-9cfc-364d7ab71261@web.de>
Date:   Sat, 19 Aug 2017 10:12:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Z0xvtPulOsmJp29PN0vR7outOm/fEJ+jt9PV+hXh8DIjnpsF8Zf
 NBRaZYYJKiFGyCsxKnH4xpUyCX+57Ggrnnzp7sqUMuuryYaxs9xryJT0UwmQc5O6ywCJmiD
 vmx6yi9f2708+u1DaNID6kXqxH3XNAFJD/83rlho1uxpg3S161I0m1/kJAKoRnOwVctaqU8
 A5XNrBfr3BeDKKERHkrbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PpuqxHIgO5U=:SLrGQgi1XpA0aeIc4gRz3t
 uec8UXweYAMGQBtGGYqgvBV76s1tjP5Bq319oU3R3HzcaYPArAkpCUU/hG81osOPiYR9eMRRp
 l4bxRaYKjzzi7M/VIoFWnjwFWoikoFnmAhhcFUXQCc/1lzCOWXoY33hFbtHEM2XgsUEFLYc4d
 ntB8/sKnfn817OS1a+9gPiV2K08MsTOoiS6YpFYg/oBpGXYHqMNQNaQNBcxjlw1Q0fLKpOETe
 Oh1Q6qWblvgD/2P+DgtvrdtaMfrdJcs2HVYqZ08fiR2V3pzx5tskpCHLL8P967eQSrJGgTQrh
 yOYj0GMYwLTjXcIY+RZ3m8KZx4xcK+f7FlAJfRnN804x8jW2z3qFtSNUCj18u66CU1eP9hQrN
 MsxC42a8bIGO4A4x+uFH7AnMkoBhkDFmdFt1tRPb+MzVjJ1LIT+gpGk0LUpnH0euEfkOWNmcB
 CHspwp+2Vo+InfS1fKQrGOi+omN9P4nBASPuvM8mcY97svkiTj1frzkwrHok1dtcGe4vw3sTC
 XeDzKWqs26x9GDhbI2HKgYhxcFCH2d2/vf7ESSJ4tHdXegyKaUtO2XmXSuTcuZvD+TXa9QPjH
 WA9j/QC9Oc5PxSyd0pb8NhKIqrqt36TKofAQ/LttOxQWD6aAeeijoVkhz6YCuaEjboTFVQRto
 8xe8daSVaS6iYZ+wBw55x01AwiA6kaDLYudV4vXWQS37tgnGzfaJs0xvVKXqqtZmDK6XGoIW7
 yRmeqP+f5RRuaH/dQjIJhcDwl0rGUH9yHyweIhrrBETT8q+sk/rW/Uwie+icKoF0ZLGCJ3y1b
 KRs+YmPVtx0Z7vZGQ5m6/UAkDM86535Tvb56lnA2oIHQ+VMjpo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

53b2c823f6 (revision walker: mini clean-up) added the function in 2007,
but it was never used, so we should be able to get rid of it now.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/commit.h b/commit.h
index 6d857f06c1..1283d2a51f 100644
--- a/commit.h
+++ b/commit.h
@@ -313,11 +313,6 @@ extern int interactive_add(int argc, const char **argv, const char *prefix, int
 extern int run_add_interactive(const char *revision, const char *patch_mode,
 			       const struct pathspec *pathspec);
 
-static inline int single_parent(struct commit *commit)
-{
-	return commit->parents && !commit->parents->next;
-}
-
 struct commit_list *reduce_heads(struct commit_list *heads);
 
 struct commit_extra_header {
-- 
2.14.1
