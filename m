Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20316200B9
	for <e@80x24.org>; Mon,  7 May 2018 04:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeEGELp (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 00:11:45 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:42121 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGELo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 00:11:44 -0400
Received: by mail-pg0-f48.google.com with SMTP id p9-v6so16383470pgc.9
        for <git@vger.kernel.org>; Sun, 06 May 2018 21:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xZra1U0YbHEooSYzE4UzuB8mM1UbO5Wm37X8IVQOKXI=;
        b=WccRWoLWAK+BQDEOdYlXZTuG4Vc79zo/fmA2no3v0uZzOJt/CnRuswDnBWgiUFCR72
         cnYTbUb3SGyakqK1yOHuds+hxI9n5K/acAhE2oPHwKJ1AsLWM+f5D3XqR799IhblRIVk
         kdeeeYBw0CYQ2SaPHaTeXROPy0MrjUuS6jrGqkkke0SdrDYCRt1c7CAVNC7VacJPD5QG
         ieGHHMVh7F3GwhzvO+uxpI+rPIX0KYy4nd+LgaxNmG0HE8iKgx1ZY1G/DkIbrudWrQLq
         WHVl9KhT/RvKnB10wJFxU/p2V1VlOMlSwSPJVu1e7dTMdX1eLmGNNnGGntCDTwSUcHO5
         lebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xZra1U0YbHEooSYzE4UzuB8mM1UbO5Wm37X8IVQOKXI=;
        b=PpPG5iF2HrlPFoaOF3iWcUJkf8Sbtk+V7mBJNMwLvfAQLvzbUcwyoyxWcNCIY6x/0f
         Jghqx7LPbV4e8z+yfqqD8i9OvPSmkGQ+8ApdWk3yaZTpW6v1TNyGfUTvL9rg7igTRiEN
         MBOoQznPxOzqDYZlpT9/v6DLIxzcKWKF9cxVd6C5PeemohswL5pNOW7mcKeF6+TMzROm
         xL/x5Rn48/QIhVvx9kp5jfedqPTCBflvlQmofVths8oVKngOtNwxEZ4I8wvcgcoaEWqa
         oJaQ+fluwtUff10u0C+hMfg/83UgE9WmWwA99OdDXUIpOB9+0AcgxaDV+uf/qYS7rHJv
         Zmfg==
X-Gm-Message-State: ALQs6tAeXPE/Zr0tuujWGGe+Ag3qlbExHCbCTeUPeFnIprLKAVuzrn7D
        ASVhH95ic4Ea51xsppY1RseGwRJ+GZ6BSxJhRpEJGFRJqcw=
X-Google-Smtp-Source: AB8JxZq+ASnm5Gd0cZKk7fS/6bHyN3X6vKkKQyqP3uziK7HgA/ezDR8ejuVWgkA/n2X5cvVF2oO4bYFDN2um67kOnA8=
X-Received: by 2002:a63:7b53:: with SMTP id k19-v6mr29159879pgn.146.1525666303791;
 Sun, 06 May 2018 21:11:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sun, 6 May 2018 21:11:43 -0700 (PDT)
In-Reply-To: <20180506204226.955739-2-sandals@crustytoothpaste.net>
References: <20180504015202.GP13217@genre.crustytoothpaste.net>
 <20180506204226.955739-1-sandals@crustytoothpaste.net> <20180506204226.955739-2-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 May 2018 06:11:43 +0200
Message-ID: <CAN0heSrth+ZheEsHuVdyUv9fcnP07O=YvK6y+=rmaGqZf7X3_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: render revisions correctly under Asciidoctor
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 May 2018 at 22:42, brian m. carlson <sandals@crustytoothpaste.net> wrote:
> When creating a literal block from an indented block without any sort of
> delimiters, Asciidoctor strips off all leading whitespace, resulting in
> a misrendered chart.  Use an explicit literal block to indicate to
> Asciidoctor that we want to keep the leading whitespace.

Excellent. These two patches fix my original problem and seem like the
obviously correct approach (in hindsight ;-) ). I wonder if the diagrams
earlier in the file should be tackled also. Right now, one has a huge
number of dots instead of the four you added; the other has none. They
do render fine though, so that'd only be about consistency in the
original .txt-file.
