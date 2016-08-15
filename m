Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65671F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 16:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbcHOQkL convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Mon, 15 Aug 2016 12:40:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35938 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbcHOQkK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 12:40:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so11953608wmf.3
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 09:40:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4imz0zKJTGNDhp72jcwWgpqrXfLOdOYv1R5vZ6xWoKY=;
        b=ji8eS4BU4aSFr9zRwiRVWlADXsMpWJw3zIQSYbg6Lgma6onXWE5v702HUx9t7bIBKJ
         E4qxl/Qme22aYSHgZuOfmtoKqUC5CN2MIux1kLn/yZtT1tGVydlcG/zzWnl3dlaAY30E
         KhXCM6yVLndXhCaRasXWaqnIw8tGRjOpYraL5DJdm9Knyns+sEnX4uI72e54HIgAP4hO
         As2fhG2yfVopnvJM9DHY2O4GvmhBJRs/wZ7RxMlTeWJjjYpFPbZkgrbeNORW/qmSsVYy
         SNux/LN9cVD6XzKo39kT2nw9xFJN8QxErcaOLqFvyhL5m9U1+za0b+JURBKWQVSI+jgU
         yfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4imz0zKJTGNDhp72jcwWgpqrXfLOdOYv1R5vZ6xWoKY=;
        b=frZzPPPzAbXU5gydDUtk/7z0QWpnYMJNmuKUJJaMV/t/t2bF+lag0dP+4qjh+j8Wjr
         ABlFBCxwNDOeQaZu+Kf5TU1TXkSQ4hrwxa/3ev5eipKY8PPiPtryEGvhuytnjGvFWHvt
         +fkTXm3GbQpZzQyK0SLM8SBsNIWShWS6j3rOnP81vlg6QuX6kYWtEXAzIktkgfE5+IC0
         RSI4ZPSpTysVE/15ZeAN7MHgk93fB9TCCs0LT5t6uiUMbUo10pbBN1Fx6oUI71y3JGho
         DsJ7AfHWTPdU+zJDFu1eM5e1YEV6WN4aIW6EFYwyhDH9TRN06eH+lr1Nki5FGArRT1m+
         7Paw==
X-Gm-Message-State: AEkoouv25nssZ+WRtmpn6QQW2QBT/gxDMKVvpCvZ8T0AkiLoUvY/g7338jRfOtRsrMwzww==
X-Received: by 10.28.22.6 with SMTP id 6mr16901144wmw.55.1471279208877;
        Mon, 15 Aug 2016 09:40:08 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f10sm22257303wje.14.2016.08.15.09.40.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 09:40:08 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/3] diff-highlight: add some tests.
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160730151149.15980-2-henderson.bj@gmail.com>
Date:	Mon, 15 Aug 2016 18:40:06 +0200
Cc:	git@vger.kernel.org, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <A2BCF055-D3FD-4EFC-88FF-A3916BCF8FDF@gmail.com>
References: <20160730151149.15980-1-henderson.bj@gmail.com> <20160730151149.15980-2-henderson.bj@gmail.com>
To:	Brian Henderson <henderson.bj@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 30 Jul 2016, at 17:11, Brian Henderson <henderson.bj@gmail.com> wrote:
> 
> ---
> contrib/diff-highlight/Makefile                  |  5 ++
> contrib/diff-highlight/t/Makefile                | 19 +++++++
> contrib/diff-highlight/t/t9400-diff-highlight.sh | 63 ++++++++++++++++++++++
> contrib/diff-highlight/t/test-diff-highlight.sh  | 69 ++++++++++++++++++++++++
> 4 files changed, 156 insertions(+)
> create mode 100644 contrib/diff-highlight/Makefile
> create mode 100644 contrib/diff-highlight/t/Makefile
> create mode 100644 contrib/diff-highlight/t/t9400-diff-highlight.sh
> create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh
> 
> diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile

Would it make sense to add the contrib tests to the Travis-CI build, too?
https://travis-ci.org/git/git/branches

- Lars