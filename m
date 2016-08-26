Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805C31FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 22:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754536AbcHZWmN (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 18:42:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62698 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754533AbcHZWmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 18:42:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1BA63A3D3;
        Fri, 26 Aug 2016 18:42:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tg3wiS5jwk6y6LOQ919MUqRTK9U=; b=LFoTo3
        79dxWKxFOWCmMIdO+LNyffN5Y6bCWWgj6lCOkK/aC4nvOjYabwSg4l9ThBl2JEDv
        R3X41bbgdybL5Uxw1HZe6goF20gK1PFr3SCFPwGTM+/30+fitHItxq0vh/sWjvCZ
        2esvbdSiWMPQOkol0icAk8Q3ZczHa8GGryGm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LNnyrCS6fxpYKyFAMIctPiH6KYCpSvLV
        /3cBLDXIWgAE9hjBY28n/D0HwpnoZI26M3+8mGtFKhz/44A0a5ri4E0rO9GEYuK5
        taTgtCFT0T27j70nNIlDhCgeSbIO1fY9WbHFBK6vJRQVsGtNuwoQzfdej29PA/1r
        BQNg2e5XboE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C99163A3D2;
        Fri, 26 Aug 2016 18:42:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 485313A3D1;
        Fri, 26 Aug 2016 18:42:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, dev+git@drbeat.li
Subject: Re: [PATCH] Documentation/SubmittingPatches: add quotes to advised commit reference
References: <20160826222714.31459-1-sbeller@google.com>
Date:   Fri, 26 Aug 2016 15:42:09 -0700
In-Reply-To: <20160826222714.31459-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 26 Aug 2016 15:27:14 -0700")
Message-ID: <xmqqk2f3duf2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53BB5C58-6BDE-11E6-82EC-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Junio finds it is easier to read text when the commit subject is quoted.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/SubmittingPatches | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 500230c..a591229 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -123,7 +123,7 @@ archive, summarize the relevant points of the discussion.
>  
>  If you want to reference a previous commit in the history of a stable
>  branch use the format "abbreviated sha1 (subject, date)". So for example
> -like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
> +like this: "Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
>  noticed [...]".

Thanks, but it is not sufficient as you would not see the need for
quoting without the example.

My preference is not a main deciding factor in this case anyway.  A
more important reason why it makes sense to quote (aside from the
fact that it makes more sense when reading) is because we already
have a tool support for that.

Perhaps something like this instead?

-- >8 --
From: Beat Bolli <dev+git@drbeat.li>
Subject: SubmittingPatches: use gitk's "Copy commit summary" format
Date: Fri, 26 Aug 2016 18:59:01 +0200

Update the suggestion in 175d38ca ("SubmittingPatches: document how
to reference previous commits", 2016-07-28) on the format to refer
to a commit to match what gitk has been giving since last year with
its "Copy commit summary" command; also mention this as one of the
ways to obtain a commit reference in this format.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 Documentation/SubmittingPatches | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 500230c..15adb86 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -122,9 +122,14 @@ without external resources. Instead of giving a URL to a mailing list
 archive, summarize the relevant points of the discussion.
 
 If you want to reference a previous commit in the history of a stable
-branch use the format "abbreviated sha1 (subject, date)". So for example
-like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
-noticed [...]".
+branch, use the format "abbreviated sha1 (subject, date)",
+with the subject enclosed in a pair of double-quotes, like this:
+
+    Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
+    noticed that ...
+
+The "Copy commit summary" command of gitk can be used to obtain this
+format.
 
 
 (3) Generate your patch using Git tools out of your commits.
