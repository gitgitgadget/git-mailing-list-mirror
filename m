Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56ED211B3
	for <e@80x24.org>; Sun, 16 Dec 2018 14:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbeLPO2D (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 09:28:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45755 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbeLPO2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 09:28:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so4884182plm.12
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 06:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y0jNS5xhDnSN15efLpnSDegmBlBTwYZvvqKCiCsX8hk=;
        b=kNktOg0sxLezak8w64fMkJtRNw1Uovfb3a52TtmFHvEmZNF1PZ1AKsnTxV2j2OaOPi
         blEwVRhX+9L3Mhu7lBvJSDI7axLDgpWTPS9cnb8oVnhUnrehDW8RAHR3xnSKlsseHcUs
         swt8FgQmuBTtAOCypLCTHsA0pq/uHjIHIAz0SM+8Lu/UOqRjY1ZLS/F72uQHAt1hR0hU
         K+2cSFK5ZubQ1GB8Rn/VzuI5X8/d/fXPuStReiGBg5CskHuc1subfiBvkf8x3KCCm5hI
         DOnniP4e1IiO+4bpW5dgxiP2QwSz2PJIwK5dC0+DjGgS7Kra95EGF5ifBjz3rYOhvAUZ
         1pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y0jNS5xhDnSN15efLpnSDegmBlBTwYZvvqKCiCsX8hk=;
        b=r61UYNYZNv1pNViD0gVBFE5fpiaWiHOXpk2TjiJRYeFoQGXxJAt2Bn5npXUmutD34e
         yhNtpac9s01idxRzDJilXQsdWv1PNzYjNlB1Jy/CvZFr+To4VHmCBkDFLXhyOyarWeGW
         03IKGRmdSoQGZf9frXzw0+yT/KFaTn5A2QvkhJAGb8E0LhKPelubdtMiKPzcMf4Uv4Rz
         zGQeGznBuBKKJLxHYfpW/DDLCz/JOUVN7sKoq+pwG5+MEzjTGYxBNqV/wYPCdl94dOf3
         KzRnVu9Ut0eZoaabu2xRpHPU48ySydZicKX+mKb2Ww7ZyUiEppzlpQwJ4CJ7ANyzCWn5
         tMkQ==
X-Gm-Message-State: AA+aEWYxC9tYj8g7WV8EjtidNJkl66Wk6lUmCKrVDcFgZ/u74QQxzHIG
        ZiwnL73IQpcib8HejhAbKnAshZkvKnq+GjKakfM=
X-Google-Smtp-Source: AFSGD/WpzoYahMELPZxiF4/wEJ+b4tgGUvmSRE9UnZVwbJmMfbOAHSlYI6WEXq5MzzgGiRshxIaJwVkNDtKzwEZzMpk=
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr9474947plo.96.1544970481881;
 Sun, 16 Dec 2018 06:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20181215112742.1475882-1-martin.agren@gmail.com>
 <20181215112742.1475882-2-martin.agren@gmail.com> <20181216105123.GD13704@sigill.intra.peff.net>
In-Reply-To: <20181216105123.GD13704@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 16 Dec 2018 15:27:50 +0100
Message-ID: <CAN0heSrsZy-pKGu+x2KnNKCnhVtJm9eYJxYFVirxAe7JL6+39A@mail.gmail.com>
Subject: Re: [PATCH 1/4] git-column.txt: fix section header
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 16 Dec 2018 at 11:51, Jeff King <peff@peff.net> wrote:
>
> On Sat, Dec 15, 2018 at 12:27:39PM +0100, Martin =C3=85gren wrote:
>
> > We have too few dashes under "Examples", which causes Asciidoctor to no=
t
> > pick it up as a section header, but to instead just render the dashes
> > literally. This also seems to confuse Asciidoctor about dashes in
> > general around here. It misinterprets the listing blocks in this
> > section, again rendering the dashes literally.
> >
> > Make sure we have as many dashes as we have characters in "Examples".
> > This fixes the section-issue and, somehow, makes the listing blocks
> > render correctly.
>
> The "somehow" here is that the mismatched dashes appear to be the start
> of a code listing block, making the whole example section into one big
> listing (which isn't properly closed, generating a warning).

Of course. Thanks for pointing it out. I now realize that when I wrote
"render the dashes literally", I was wrong.

This should be improved in v2.

Martin
