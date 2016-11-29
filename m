Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DCE1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755949AbcK2TyF (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 14:54:05 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33683 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753677AbcK2TyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 14:54:02 -0500
Received: by mail-yw0-f179.google.com with SMTP id r204so144538088ywb.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 11:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tAtBzHKQHqZYuQUegxZgKVT9nPR9/x/xoH9oaQJqTLs=;
        b=sF76ogtmBrDpJ7h45p7nID8loMkikl0zpjfZx1raO1aaATANZscsKCl+XNvATvXdMu
         DDYR+QLoXdNfWF7BaXF4FC9L1EbaboKAuyMls0a74klgtlgnk7CxybI9j1ETD3UJGM1Y
         F99aXKe/aibOoW/p03sO6pVTeOOXbemiBL4qeCWoNIshtMizoiKqD867KlUkU4Q90CKu
         tCQvNEJuKrfu3vouLtbQWbnncZbokp9OyU/Mp9NNCpajUkpMD+hOqI54asQuu8q4TH6Y
         oAW9q3i65Z8q2mUh1csUxA1iaL10dXZDtgSABl/H59DT/1rVYG/RfblXISdvurX5ZMKN
         iaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tAtBzHKQHqZYuQUegxZgKVT9nPR9/x/xoH9oaQJqTLs=;
        b=KG5WPUvKxKh4BebaH43Im/TZ10xXKabsPDsI+oZ5ZHqoWDXMh5Mly3h10SG0Fq4vMp
         7KNPqcNx5wnmTvJESmHRLy3+tjniVJsBg/6FyQzxxxh1/7e0QlfRx9NyzfqQGRUbJpEM
         VFrfxYMVpUrogR2LcsTjXkn7XDm2UINUdKnquvTRHw47IMUFrMkxTfna0zyQn1j4lhEN
         zLzGY+sW2YJ+bGykRl5Az56RkxY38yvA75i90V0z89Hib5Mc8YppU+aWKCY6fDT2Ttzj
         b0Agny/cXTepIdhluNNeyeW9Xp5r+GWwcFzmmyYqWCINOZwN+mBTlZKxtFpV9XMoBIJl
         v4/A==
X-Gm-Message-State: AKaTC01w2NGBRkugi1r8ihMhezr3qNGm4LYYV7aOjf12ftMosKPywF3O+EZ9OrIKv94HjmjJkKpUxidzNwX6OQ==
X-Received: by 10.129.108.216 with SMTP id h207mr33467429ywc.52.1480449188878;
 Tue, 29 Nov 2016 11:53:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.98.77 with HTTP; Tue, 29 Nov 2016 11:53:08 -0800 (PST)
In-Reply-To: <xmqq7f7mf4rs.fsf@gitster.mtv.corp.google.com>
References: <CALO-gutW80d6RLdXAtYA2m2GWOchAjNNPy3YCsr31_fCss512g@mail.gmail.com>
 <xmqq7f7mf4rs.fsf@gitster.mtv.corp.google.com>
From:   Eli Barzilay <eli@barzilay.org>
Date:   Tue, 29 Nov 2016 14:53:08 -0500
Message-ID: <CALO-gutJbM=LA3q8vdmbQJLoeCFAJWfPHFo8f1vz-5KJHVxJ6g@mail.gmail.com>
Subject: Re: gitconfig includes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 2:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eli Barzilay <eli@barzilay.org> writes:
>
>> So this is at least a documentation issue,...
>
> This already is documented, and I think it is clear enough.
>
>        --[no-]includes
>                   Respect include.* directives in config files when
>                   looking up values.  Defaults to off when a specific
>                   file is given (e.g., using --file, --global, etc)
>                   and on when searching all config files.

Yeah, that's clear, sorry for not checking the latest.

[I'd expect/wish it to be on by default though...  Any reason for the
default being off in these cases?]

-- 
                   ((x=>x(x))(x=>x(x)))                  Eli Barzilay:
                   http://barzilay.org/                  Maze is Life!
