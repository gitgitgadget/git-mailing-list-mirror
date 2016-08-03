Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9EA1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 17:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356AbcHCR6o (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:58:44 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35481 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbcHCR6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:58:38 -0400
Received: by mail-qk0-f181.google.com with SMTP id x185so17202156qkc.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 10:58:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7iGd36jp/fCHI6SehUw3n47z9PeYNGQpelThoCint6E=;
        b=auBFdK81JhBmeSpTr0jAsk5HVliXo5RK7VQqMn7UMhQ9blTNbXGMB6iy0eySLpTgNn
         neuU8IefFam8HDS62ZexjGRt8ApyjNnOPCWDw88QcvfsY0GpBEo2KvlDMhUmWx60wgi8
         T4EmvHX7gxXUFZhW/YO5bk8J0ipnThD7gdBWaNJxSduhbGqWc64RPaE1V+ifrxkmZWnd
         GpwLxBSXYdVAa74KmmnoMdyF4ZhHAZCVhqnW5Fhhsjpbxos11M5vSmJefJPFPW7kBkgV
         liOVnOWvNljhtcZlS/Mo3oSNZ0EvabQfOlKj8OY+32r1pUY1K0R27KIIwKz3taygfeM5
         5/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7iGd36jp/fCHI6SehUw3n47z9PeYNGQpelThoCint6E=;
        b=Ye6YmmnTz+x/qPoBqmbfApVNmFpRnbC81Bemg1qXeWLrQE1vRx/g0g/JsoUdvDC0YX
         ddTVgNKjEMsDOZ6S/NP4Ze/zCgpRhvekWGTXQwdHD4T2+SbNcdjp2A2ccfb63iCaH4ai
         fhfItq9JOjnvxGfCX7GqgMtoGBtwNKObUqbm5Tg4zuAAmfZYgJGoCl58Of8/mM1nQUW8
         uZnfYrWXcpP88OaJ1Z7Hr2qxbtzITLRRyM+uE3NwhNbRYpL2HNVfDHRx/54ybTWr/aHW
         YELPHznfBD6xHekXStKodorwxUxg4B7wwxDSFeA4/gbZf/sfKgAUk/bsJWRnd6JfQRDT
         Fg3A==
X-Gm-Message-State: AEkoousqaWngXi7EPCQKW+sKMmQsxHN5xZQrSonhL5oraULq/NYvvdMOSJme7jHBSIS5LEkI
X-Received: by 10.55.27.106 with SMTP id b103mr1270469qkb.224.1470247117338;
        Wed, 03 Aug 2016 10:58:37 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-01.NATPOOL.NYU.EDU. [216.165.95.72])
        by smtp.gmail.com with ESMTPSA id l22sm4750327qtl.34.2016.08.03.10.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 10:58:37 -0700 (PDT)
Date:	Wed, 3 Aug 2016 13:58:36 -0400
From:	Santiago Torres <santiago@nyu.edu>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
Message-ID: <20160803175836.yrsnusbuhl2hvp3h@LykOS.localdomain>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
 <alpine.DEB.2.20.1608031721430.107993@virtualbox>
 <20160803152510.pgcd2edareqdxnmh@LykOS.localdomain>
 <CAGZ79kZPPvi2jpFgu1MZ97gZm=QqBBiZ-XcXUJphm3UzNRP-FQ@mail.gmail.com>
 <20160803172242.5jrd4saq7sga6iql@LykOS.localdomain>
 <xmqqy44d92md.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy44d92md.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 10:35:54AM -0700, Junio C Hamano wrote:
> Santiago Torres <santiago@nyu.edu> writes:
> 
> >> Submodules actually track commits, not tags or branches.
> >> 
> >> This is confusing for some users, e.g. the user intended to track a
> >> library at version 1.1, but it tracks 1234abcd instead (which is
> >> what 1.1 points at).
> >
> > I'm assuming that git submodule update does update where the ref
> > points to, does it not?
> 
> I think you may configure the command to do so, instead of the default
> "detach at the commit recorded in the superproject".
> 
> But then your tree immediately will be marked by "git status" as
> "modified" at such a submodule, meaning "what you have in the working
> tree is different from what the commit in the superproject wants you
> to have", I would think.
> 

Ah, I see where is my confusion. Thanks for the correction :)

-Santiago.
