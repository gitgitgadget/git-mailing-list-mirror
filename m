Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6531F404
	for <e@80x24.org>; Sun, 16 Sep 2018 18:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeIPXlp (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 19:41:45 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21727 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeIPXlp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 19:41:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1537121878; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Tb3XIcIQBFV/t9vYUiekI1ZEaX06Ene5GYoWLKwZLuNibkq+1rOawK6Af6IQW8tQIPwKfBqa+/Pasy1Q165gTKDVDXNAyW8uKi0yL/klE8O4ZODopHBvx/n1GCOwXUSx8UEMO0wFwBYyf59CuAF4oGGTxraWTGK8PfIQOJA2kRY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1537121878; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=O3isPr+R1Ei5nzV40+/sHBEKzLxVYZ7CdPMqfi8FYfU=; 
        b=bDjXgs+4YaOTi/p5xkpt30ufLzE0WrAzZTiX6hk0eTdphHasNxWbfX3hy4QPAFADUyf3jJsbS6tgA8MIfs3eDcYOG4AnqnL3I3Z3CEPLbSPHbIGI4IQnM1Hstlgip2x4hIY0NuKC/yjp5No6m//MI2oJsUxzhek86r0a/BoyIys=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41]) by mx.zohomail.com
        with SMTPS id 1537121876811413.48771165057894; Sun, 16 Sep 2018 11:17:56 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id e11-v6so100484lfc.9
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 11:17:56 -0700 (PDT)
X-Gm-Message-State: APzg51CI6kUYOP7W6TzmIFrZpTTKe/uSV1uUI5wtTXLF/IveHE9aAPNq
        hkoOY4bWHACKbYbD9b0D+SKfnboHfSigM4gLAfw=
X-Google-Smtp-Source: ANB0VdZPlr9iee+QpEMi1WLsxY9/cgjYvltWEyZYTSLafKxSEcs+m7Z1+QiqPpgvBzqvd7Aj11osD5S9tJTlIoGm788=
X-Received: by 2002:a19:11a2:: with SMTP id 34-v6mr8607889lfr.25.1537121874937;
 Sun, 16 Sep 2018 11:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <87bm8zlqrh.fsf@evledraar.gmail.com> <CA+AhR6d4p2N06t-w62A2=wTH0x1ipt3x3hN2mQKK-Cwj0rMX1g@mail.gmail.com>
 <20180915164217.GB88932@syl>
In-Reply-To: <20180915164217.GB88932@syl>
From:   John Austin <john@astrangergravity.com>
Date:   Sun, 16 Sep 2018 11:17:27 -0700
X-Gmail-Original-Message-ID: <CA+AhR6fjtzWyRtcgRkedK=RWua8_rmiqkDR+my8u9BHLfjhRMA@mail.gmail.com>
Message-ID: <CA+AhR6fjtzWyRtcgRkedK=RWua8_rmiqkDR+my8u9BHLfjhRMA@mail.gmail.com>
Subject: Re: Git for games working group
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Right, though this still subjects the remote copy to all of the
> difficulty of packing large objects (though Christian's work to support
> other object database implementations would go a long way to help this).

Ah, interesting -- I didn't realize this step was part of the
bottleneck. I presumed git didn't do much more than perhaps gzip'ing
binary files when it packed them up. Or do you mean the growing cost
of storing the objects locally as you work? Perhaps that could be
solved by allowing the client more control (ie. delete the oldest
blobs that exist on the server).

