Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976B51F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeFUVoE (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:44:04 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39231 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeFUVoD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:44:03 -0400
Received: by mail-yw0-f195.google.com with SMTP id 81-v6so1699518ywb.6
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWQpaie0TibK6+1X6D5HwlWbiqof1ZRR0SuoNo1QVCg=;
        b=LqPvWEUrhRuZJ9gYKPFLwlOy/25d8rbkIjCvXeInCFrMOBCAn+kM08onX89P6lvY3v
         BzVWRQD7ZaZOt4QOovo9Z/hrvP3xhmqRpNFIhSNPFPGwcSYCWgB9B4koCwrNFSu74clQ
         +mxcsvgbtOmRjhxBq7vxU7uy/EENe9iHO9bA2SZ3cbabV6AH6GcE76GsxGLNr1dYOhWn
         RokErynWG/x+MiGZVH77/9/teT05ZF5aXlp4Maqemy4i6VedJPDlCm7FziYcG/4htSMJ
         vbqx16t3Wa4JfYGhHkgYg0lHIzR/tgNxaI/IS6ciVivTvpf9jXE0WGDYQVvwQIzcmdFP
         0juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWQpaie0TibK6+1X6D5HwlWbiqof1ZRR0SuoNo1QVCg=;
        b=HsJddvszB3OwUm/9TLM7V4ZWCdkQKvR1mEmta8DBrZm9Q7fMcu/ZjylvyOzgVLloQq
         cL9GTRrIWdoMcM5jGvYBUboWldGR/xTGruMWcwxCNilxj4+BeEa1+8q8l+iXBGRUE3Xe
         QRrCUho9234vpGYsKqmQseSBraxFRYymjkRd9Muov2XbBrUVL1Vyf4Uafz4LggHMqdne
         4nFz/vZ3DwYKilT8zwojnWI5JOQN6wkrDK6lP4zq/awlB3rWT7xmSl3mY+/XE/xuvH0p
         veigVl477SM+jTQJsb5mCjiVgLGwwddDK8GwCc5HVDwJWSzmllMLE6I+Q3d6c14cnJcD
         o4uQ==
X-Gm-Message-State: APt69E2/adG12zA8Ay/xJgVlP3Bkuz2ZpTX7WPa8GTBLp0xa3SWyhslw
        dtw5V9u9Oiv7rKuPbvBJsySh2BHLYUXZPjqkhqFldQ==
X-Google-Smtp-Source: ADUXVKKZOl+zAMhPqRtt/ZdLi+bhWse+Dn5IhMGCUQYffQvBwBohKORxom+QwF4Mn78QY7UUmxiVtrqA6eK2ZFwZFTI=
X-Received: by 2002:a0d:d304:: with SMTP id v4-v6mr13117842ywd.500.1529617442932;
 Thu, 21 Jun 2018 14:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529616356.git.jonathantanmy@google.com> <82c9edb9108f49468031bfd7c65a9eb8db2cb671.1529616356.git.jonathantanmy@google.com>
In-Reply-To: <82c9edb9108f49468031bfd7c65a9eb8db2cb671.1529616356.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Jun 2018 14:43:52 -0700
Message-ID: <CAGZ79kbC0e1ujAebTUexDXH4+cFOpek3a0VTrdRUfx6Z=cpBVw@mail.gmail.com>
Subject: Re: [PATCH 2/5] commit-graph: add missing forward declaration
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,
On Thu, Jun 21, 2018 at 2:29 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

Both this and the previous patch look good to me;
you seem to have better (stricter) checking for
missing includes/forward declarations, am I missing
a compile option? (I have DEVELOPER=1 in config.mak)
