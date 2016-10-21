Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F4520229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755337AbcJUMYT (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:19 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36631 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755249AbcJUMYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:16 -0400
Received: by mail-vk0-f46.google.com with SMTP id 2so114830077vkb.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=vv8PxuKzmpgqoeMYdbKnVH7qCqrJxuD/Hv4+yNyT8hA=;
        b=mVforxXVB2/7vf3IKXUU7foUqERvNKRTumAgw0T2t0c5BF3OsFVt8ldw6A5jslLUHq
         Z5P8zZvTOLnWPSJQraUoUC5AMQYiXVF+rah6tN3gkS/hXgXqJAFTFT4nCO/KdZGlHYUs
         t2X4B9OUPP/L2VonMdIQCMBfDtvxTx/7acifRUDM3qQ7yYfs5ecrNRdvSLRtfA81jbzC
         KJs/GiQJ1QJYej2zJiG/gIqUmjDxz+GUTslM+IjniwhShMhD5uCUjjKeZBwG7FHIrUJ/
         U1zVrl2AlFuU0/oYusrIfbC4vfxIiXknUIIMG6PlZd6n29xW2lWef0fhguLR2z/CbJMz
         uZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vv8PxuKzmpgqoeMYdbKnVH7qCqrJxuD/Hv4+yNyT8hA=;
        b=XzqF6+P5K5qtE2AISith5/sjXrgfq6WHhZpdXJM5UzPCBnPHSPc8RyvleMZg1h0Fy/
         QI5rQ4X5fE3/fqBzdpdWWfKAFEnptWyN11VW9HeI/FExAqFqATRX2aAUUSZvi0bADpGi
         NTOcGzM6pnDhq3AHwAzhKFUS7W6USvEnyRGCtV+f//SJohqWyJtEHVHXkDdolVjd2Z/u
         Xq8IAuf6z2Almazjl4F1OEdDvTMrBwXUcCF1xzfAVHoGPOnau0UCKdfRIjD+zriv/yhJ
         P3w9RLmKS4x5AVGDzLblCz/MPu/B8+qLHryXX11zbwQjFPHmmSfHW4jj0yV2bg4Ui9Z+
         H4UQ==
X-Gm-Message-State: ABUngvd+91PKV6pBPgwgj8MrahVgJSirkiV0WUW5HBrbwwEUeLMiGn+LzfSHAcKMgB45dV6ZDhzDTi84yUUeeA==
X-Received: by 10.31.108.133 with SMTP id j5mr498508vki.161.1477052654872;
 Fri, 21 Oct 2016 05:24:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.133 with HTTP; Fri, 21 Oct 2016 05:23:54 -0700 (PDT)
From:   Stefan Monov <logixoul@gmail.com>
Date:   Fri, 21 Oct 2016 15:23:54 +0300
Message-ID: <CAJtFkWur0NfvvV-QT2XmEW=MSJ7Ye=hX7HujEQhTFGiah2_yBQ@mail.gmail.com>
Subject: =?UTF-8?Q?Git_context_menu_in_Windows_Exporer_has_a_=E2=80=9Cgit_bas?=
        =?UTF-8?Q?h=E2=80=9D_option_but_it_doesn=27t_work?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

The default git distribution for windows contains, besides the CLI
tools, a shell integration, i.e. a context menu for Windows Explorer.
This context menu has a "Git bash" option which I suppose should open
a Git bash prompt cd'd to the current directory. But instead, the git
bash window opens and immediately closes, giving me no chance to even
see what it says inside it. Any fix?

Note: Opening Git Bash from the Windows Start Menu works fine, but if
I open it that way, then I need to manually cd to the needed dir.

TIA,
Stefan Monov
