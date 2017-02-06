Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B651FC46
	for <e@80x24.org>; Mon,  6 Feb 2017 09:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdBFJBG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 04:01:06 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36783 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdBFI7m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 03:59:42 -0500
Received: by mail-wm0-f49.google.com with SMTP id c85so110281113wmi.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 00:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z9RaNQozhBjSr4lGbbbgrE6K3scQjAyTidBjrEa0uuI=;
        b=O++A5fA6xYgb0sM0rVdsZSPNaQ61dX8+DEFnnreUeEt6fWkEvgeEKTQmqc9oxmTi5G
         YpIc/qmgpys2US4lfm8k0roz85ZKyHOeFKgwfzy/RgekTJEj+U6ms7t+sa0ZZMQHaz8g
         gcM7ywe7KzK+3a2A+rSIyjiUMZhJhRPMIiW3cC+L9Bq9NO6zz+e7yj6lVMi3r+n3V4HN
         55j+1is3rPZrDCIn644WJmrJ7AHJSbKDXEB0PVhH80ZVjJmhGP7IJ1POoIFMggq7HMFg
         /wtNoGesfsUT+7T8tq/3CTm0xvIoGZ0VdQGIu10P2wQz/4nVl/V9zdlAydKZxanZfOjC
         wJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z9RaNQozhBjSr4lGbbbgrE6K3scQjAyTidBjrEa0uuI=;
        b=GvzYq5X8YeBfjxPcQbtTOxj692RsxXHzOHsvtdgxDwQGgpKyUrS4L7mKyIRW0hZ/d2
         Vh4kwBhw0HuK0uHA/Htky36A7vuNoElIUZzuJRdR90HLqmdrv4rij9/iey/Cq3Cg65pF
         udU0wr+QzkknZj01ttCSYCsMKbIrq1Ze7oq2LwkrnOgrRwz+jhuyPn7ksgFlWAPNRDVF
         f35tcdgFqitw7nAQjhR601Uy44SgTOof9rVjimcIIMyRXEMtzfTaBjMYPugwUmFiiX/U
         +tOOBT07lFs99L8p3IP96dIVBNS3K0eujsDIzIZ3dOpZf0z/Cc0B6AH3x1E8j0bu97oV
         FaRQ==
X-Gm-Message-State: AMke39lWCn8vEUIU0e93FdW9aGL5onWFz7r5U6BKXFW/PIheemt1pWQHLfV0aKNIZ93s4iGzWbUDx9BuhvEY8g==
X-Received: by 10.28.18.130 with SMTP id 124mr8237219wms.8.1486371581202; Mon,
 06 Feb 2017 00:59:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.137.1 with HTTP; Mon, 6 Feb 2017 00:59:40 -0800 (PST)
In-Reply-To: <CAJZjrdX_8tjMhRac9QQOW8m_S2DprFPV=uZp8mFT+g6bASVd-w@mail.gmail.com>
References: <CAJZjrdX_8tjMhRac9QQOW8m_S2DprFPV=uZp8mFT+g6bASVd-w@mail.gmail.com>
From:   Thomas Ferris Nicolaisen <tfnico@gmail.com>
Date:   Mon, 6 Feb 2017 09:59:40 +0100
Message-ID: <CAEcj5uWZSZ+ujSSoVzpAzmEks1v9eQ1c_Sc8Sc4fUM4cKzM_nA@mail.gmail.com>
Subject: Re: git/git-scm.com GH Issue Tracker
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding Peff to cc as he is the current maintainer of the git-scm.com site/repo.

On Mon, Feb 6, 2017 at 7:15 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
>
> I've taken the liberty of classifying them as shown below.
>

As a community member who cares a lot about that site, thank you! I
would love to contribute by reviewing your reviews, but personally
can't find the time (focusing free time on podcast production from
Git-Merge instead ;)).
