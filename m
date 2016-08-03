Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D171F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbcHCWNR (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:13:17 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36441 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbcHCWNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:13:16 -0400
Received: by mail-io0-f180.google.com with SMTP id b62so256515556iod.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 15:11:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yy53oGXxzQOu11KkEQ0bTNHh8kqmQ3IWyYMj/CMSkis=;
        b=QCOQw/WfMD3fpUIIQtnigIFnGAgoNqg2ezapsZjXHD33gEJ2ZwQ+N4KMeqtkgJlGSK
         Qof/wYyLgL8yYv9zxQ0EBHlS+Me+2JxDEQOI9aMwVvj4MpS1HCMMS9XQ2K3Otxcd6E3z
         +ZmJBRCojhrCilm6iWCTXlra3i6fCVfkKLxpqJL0AZJ0afcKinYm8/xw7R1ZnLAB9aj7
         cgiCvXnTGyqUgRpaZGXzS7XQkuuZE2PLkiInCq/iRVMMaXIbMEwnwsmWiPxs/XCzHeK4
         bN/DhYxMbGt9P1LQsPA/VtCg4fY75HO5MJphF4WaqUehpesyAYJ01G6IoFSOVLBkj3Dz
         K1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yy53oGXxzQOu11KkEQ0bTNHh8kqmQ3IWyYMj/CMSkis=;
        b=jETZhu3ZcFIhcoCk+K14SuA3xTYpyXYTLNOyMpyCSGjOMiwFnCdjAxtsxURNeCsQlZ
         /d1ob6He+cn9BMC0Cc9phHmBT0X3k21osEBlnY3d28NUejpv5sYaiGwR5nNqNhXWdQ2C
         UB5gbF4QNQUsGQHsWA/orJs2TW0/e7h8tQvu7tCDBsHdHs/U0QXE/qfWgbxbRwfiTCVC
         LqnBwjBNbX2Pd0At7st6Lq3jC81YvlrCR2gr0xAm4pwtrVL6ZmBiXCKW94GK91p6zrmA
         EmehaHMKvTGhXJwEwJ71T7JmEW41xWBak8C6KWFmcE/1sQgq/HuspuWkuH8D5Xyjj+wp
         q0+g==
X-Gm-Message-State: AEkoouvi5uXVcJc7sg5grMuI1oNPkeb2Bti1PBMh5HGDE+7W8x2fhoUrbaBOHlz6Hup2mfxjmWTSoc68d2cAz4l0
X-Received: by 10.107.144.10 with SMTP id s10mr67057644iod.165.1470262288128;
 Wed, 03 Aug 2016 15:11:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 15:11:27 -0700 (PDT)
In-Reply-To: <f4ce27f389b64c9ae503152c66d183c4a4a970f1.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <f4ce27f389b64c9ae503152c66d183c4a4a970f1.1470259583.git.mhagger@alum.mit.edu>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 15:11:27 -0700
Message-ID: <CAGZ79kZk+XW+Bwcx_fvOLVBDse_iUSjEa_K=eJqm4PpTsTAcPA@mail.gmail.com>
Subject: Re: [PATCH 2/8] xdl_change_compact(): clarify code
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Write things out a bit longer but less cryptically. Add more comments.

By less cryptic you mean in Git coding style ;)
The original author (do we want to cc Davido?) may disagree.

> +
> +                       /*
> +                        * Are there any blank lines that could appear as the last
> +                        * line of this group?
> +                        */

IIRC this comment is not quite correct as this 'only' counts the number of
blank lines within the forward shifting section, i.e. in the movable space.

Later we use it as a boolean indicator (whether or not it is equal to 0)
to see if we can do better.

Any other change in code and comments looks good to me, but this stood out
like a sore thumb. (Probably the old heuristic as a whole stood out, but the
comment here specifically sounds /wrong/ to me in this place. How can
a question document a variable? I'd rather expect a question comment
to ease the understanding of a condition)

Thanks for reviving this topic!
Stefan
