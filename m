Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFAA1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeDUKKA (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:10:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:34879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeDUKJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:09:58 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mg3h3-1eojfr1Tan-00NNkQ; Sat, 21
 Apr 2018 12:09:54 +0200
Date:   Sat, 21 Apr 2018 12:09:52 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] Colorize push errors
In-Reply-To: <cover.1522968472.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1524305353.git.johannes.schindelin@gmx.de>
References: <cover.1522968472.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:023mW6+kRTJmalwKjoWANstiub3vs1fzX3fz6HTbJ4I7V+8AZ5D
 o3NjrNEUiDL2yRebiGJDvaArFjmIBGfX7HAkzOgxzZBTQrEznSIzjM/5RCxXhFkoGFFdtRa
 6rYUjmxAVagJDFcJLeTUrFWYYXBii1aiRHCzxStAOG/MMgk6Ka4x68Z7t0JyuT69WMVw0sN
 NRmvaHGGmLyiCrssJdQrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y+JWkCml5zo=:c7N4ytbVgEshC9Sw0HSVi5
 HZbiRUZkrIjVFgcTPkGEjngIpeqNd4DL9FPjcsnG/aocETpNH7CcN3tpH9rXx+40pwsB2x/7w
 e33LeMpbqtKYZa2AXE3wH0Sxru9ejsIw+yggCa9ETJXMc4uj0YexvYKnQ5G+BH3+8nBYKXPTl
 ix2ayPvXybj1Vrh0eTE06M4sv3EraxrFPUlhpZkKJdKE3tvv7adAGDrdoRIA+4eo/chVSWizQ
 ft1kcV/Gsv6efPLNWPOfmLmY2qukE6D+8bysWtOxzixv9PcLBbyjz52g9c5tpsv+qPgQzhpvq
 mvVie5kq/oNWho23flIXWCqYYM5vIKK08sJ2M1NPlHTJ0ir0t0mFQiee08j7Y/aqaFZjvWqNn
 4/61YDsJIT03jWsFU6BBLR/FVnFCIw5c6MQErpTghSEPWiqHs9OvOjju1NvrGmOwyuee4MIax
 97LxROofQrWWvLeUs7iqv2Jd1sgSNRxlaG+ko5Nmocu/ezXzd5qR6L2OyNMcnbGz3IcuDLvle
 M3IKm64nCzkqCDBhemvV/o9FXYXVTH/Mg+q0QWzXPE8lIOvHmSKq1vfbB3qySL5TH+kbNX6Fb
 cyJVz9yc+X89d6KZAB+r0DzWQDx7oRkv/N+BAI7GUa0zYbpIv2Wa1BrY+OBc4f8o7H1WFyarm
 jwn0d1dcZs6D7E/EXgmdtB6aZT8TlRDNtQ/zuS+9yzy/b9eOfIgDkKh1t/zAUEMV87WE02zh7
 eauPXL5pMO3Z0DtyBvfmsOaQ5YJuc0XATJGtTLnI3RExyBJLh7P4MV2iEnPD2OCj32pg94nny
 k7qXFZSu8Qrt4j9EDbfmvcPI44OfJzWvijqQ5MBdaQbYLhoiJc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To help users discern large chunks of white text (when the push
succeeds) from large chunks of white text (when the push fails), let's
add some color to the latter.

The original contribution came in via Pull Request from the Git for
Windows project:

	https://github.com/git-for-windows/git/pull/1429

I almost forgot to submit v3. Guess it's a good thing I have a project
management system with tickets I can move through a story board...

Changes since v2:

- removed a bogus "squash! ..." from the commit message of 2/4

- removed the unnecessary here-doc from the test added in 4/4

- renamed color.advice.advice to color.advice.hint in 2/4 and 4/4


Johannes Schindelin (3):
  color: introduce support for colorizing stderr
  Add a test to verify that push errors are colorful
  Document the new color.* settings to colorize push errors/hints

Ryan Dammrose (1):
  push: colorize errors

 Documentation/config.txt   | 28 ++++++++++++++++
 advice.c                   | 49 ++++++++++++++++++++++++++--
 builtin/push.c             | 44 ++++++++++++++++++++++++-
 color.c                    | 20 +++++++-----
 color.h                    |  4 ++-
 config.c                   |  2 +-
 t/t5541-http-push-smart.sh | 12 +++++++
 transport.c                | 67 +++++++++++++++++++++++++++++++++++++-
 8 files changed, 211 insertions(+), 15 deletions(-)


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
Published-As: https://github.com/dscho/git/releases/tag/colorize-push-errors-v3
Fetch-It-Via: git fetch https://github.com/dscho/git colorize-push-errors-v3

Interdiff vs v2:
 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index 1fef60a7301..2cea0c6c899 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -1095,7 +1095,7 @@ color.advice::
  	are used only when the error output goes to a terminal. If
  	unset, then the value of `color.ui` is used (`auto` by default).
  
 -color.advice.advice::
 +color.advice.hint::
  	Use customized color for hints.
  
  color.branch::
 diff --git a/advice.c b/advice.c
 index 2121c1811fd..89fda1de55b 100644
 --- a/advice.c
 +++ b/advice.c
 @@ -36,7 +36,7 @@ static int parse_advise_color_slot(const char *slot)
  {
  	if (!strcasecmp(slot, "reset"))
  		return ADVICE_COLOR_RESET;
 -	if (!strcasecmp(slot, "advice"))
 +	if (!strcasecmp(slot, "hint"))
  		return ADVICE_COLOR_HINT;
  	return -1;
  }
 diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
 index 1c2be98dc2b..a2af693068f 100755
 --- a/t/t5541-http-push-smart.sh
 +++ b/t/t5541-http-push-smart.sh
 @@ -379,12 +379,6 @@ test_expect_success 'push status output scrubs password' '
  
  test_expect_success 'colorize errors/hints' '
  	cd "$ROOT_PATH"/test_repo_clone &&
 -	cat >exp <<-EOF &&
 -	To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
 -	 <RED>! [rejected]       <RESET> origin/master^ -> master (non-fast-forward)
 -	error: failed to push some refs to '\''http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'\''
 -	EOF
 -
  	test_must_fail git -c color.transport=always -c color.advice=always \
  		-c color.push=always \
  		push origin origin/master^:master 2>act &&
-- 
2.17.0.windows.1.15.gaa56ade3205

