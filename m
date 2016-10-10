Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077C9207EC
	for <e@80x24.org>; Mon, 10 Oct 2016 03:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbcJJDEf (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 23:04:35 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56189 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbcJJDEe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 23:04:34 -0400
Received: from [IPv6:2607:fb90:4a5:84ad:61ac:5013:e853:d7aa] (unknown [IPv6:2607:fb90:4a5:84ad:61ac:5013:e853:d7aa])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DB8BA172094;
        Mon, 10 Oct 2016 05:04:29 +0200 (CEST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20161010025323.9415-1-jeremyhu@apple.com>
References: <20161010025323.9415-1-jeremyhu@apple.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better handle distro changes to DEF_VER
From:   Josh Triplett <josh@joshtriplett.org>
Date:   Sun, 09 Oct 2016 20:04:24 -0700
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>, git@vger.kernel.org
CC:     Junio C Hamano <gitster@pobox.com>
Message-ID: <E0254A0C-8BEC-4B88-A352-BA075B49BFA7@joshtriplett.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 9, 2016 7:53:23 PM PDT, Jeremy Huddleston Sequoia <jeremyhu@apple.com> wrote:
>Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae
>Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>CC: Josh Triplett <josh@joshtriplett.org>
>CC: Junio C Hamano <gitster@pobox.com>

Looks reasonable to me. Didn't realize git versions could have spaces.
Reviewed-by: Josh Triplett <josh@joshtriplett.org>

> t/t4014-format-patch.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>index 8d90a6e..33f6940 100755
>--- a/t/t4014-format-patch.sh
>+++ b/t/t4014-format-patch.sh
>@@ -754,7 +754,7 @@ test_expect_success 'format-patch
>--ignore-if-in-upstream HEAD' '
> 	git format-patch --ignore-if-in-upstream HEAD
> '
> 
>-git_version="$(git --version | sed "s/.* //")"
>+git_version="$(git --version | sed "s/git version //")"
> 
> signature() {
> 	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"


