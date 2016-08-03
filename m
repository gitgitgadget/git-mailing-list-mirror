Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D6B1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779AbcHCXW5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:22:57 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35642 "EHLO
	mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbcHCXW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:22:56 -0400
Received: by mail-it0-f50.google.com with SMTP id u186so310681375ita.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 16:22:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5AuukQ6A+xh5CHvKjn/hSjKA3FuSM0Dl5NnhTZi+6fU=;
        b=ClXoIAHm6L9N/uDGs4e8GFnTEavi2jU+F0py0SMY4UknFRQcGmMHskMnPachNM3jIX
         YXU9z3fWAPatBdpH07VPrjtQfDGfg+hFCW6sMMcZvyI1EQYUoCFuJI7iCDRlBtisJjJQ
         qbP4U2p3hOHCIKt/d6ETr0otcrJ7FC9+kxm1Vmokn2XlQ2UrZ+42Tvp1+tuKwXDl1i7Z
         L+nE0GwhGA+JXxjI/eFIJlxgG8XGWH8UPYaSyce/IbZLREj6g3npIq1e3jtQacagfxIv
         JUQnX8Lag1kl97RfS+7etdZdQkbovG/eKEaNIMmdNBV8ilsfrM3wVIdgblQSmZZQos49
         MaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5AuukQ6A+xh5CHvKjn/hSjKA3FuSM0Dl5NnhTZi+6fU=;
        b=iatu0gCC039QrTtMXyApnDv5qITOMZpgxyjoj9ZIkyqfo3F2OhHZo1Z8ss5eYqlZO5
         eaMn+YCyX4Rt95nArBtVfNyhzIfF7/ukkT7ec+7ljXndvgg/HA+lAhEPr98oUaGmWF8G
         Lv4D5cXojzu5Af0u41Dvavu3dW6cayLQcxHs5nDDO4VJnh9dru20SCy5aItLpekJyCca
         E0MwvqKmE/0nvm15vfkY5DkmbXoiQABHtOY8/HvJbkiYxybeBzU+oQUT1I90tw8/54ei
         VlRjz3XzdjknXHhFjbElAKj7qHr6qZA3i3StJkrGBPBu9uThdZ7CoOq+Zihtuk2O2c4S
         XDow==
X-Gm-Message-State: AEkoousFCYh79YYgiJ/y98wo6QpdjYhwtNe9l3FXRvBKWEPKedNSp9vIYtqC4kfdrwvrdrNYsjhqSfAIjdpnTjSA
X-Received: by 10.36.29.15 with SMTP id 15mr26784755itj.97.1470266562899; Wed,
 03 Aug 2016 16:22:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 16:22:42 -0700 (PDT)
In-Reply-To: <xmqq8twd78fm.fsf@gitster.mtv.corp.google.com>
References: <20160803204404.3356-1-sbeller@google.com> <20160803204404.3356-2-sbeller@google.com>
 <xmqq8twd78fm.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 16:22:42 -0700
Message-ID: <CAGZ79kaVB_aSuUK-jzAaq_ZHMh-P8hrjGjkkQwr0eH7u9xZj-Q@mail.gmail.com>
Subject: Re: [PATCHv4 6/7] submodule--helper: add remote-branch helper
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 4:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index fb90c64..9be2c75 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -899,6 +899,39 @@ static int resolve_relative_path(int argc, const char **argv, const char *prefix
>>       return 0;
>
> I wonder who lost the leading SP before the tab here.  Will manually
> fix, so this is not a reason to force resending, but you may want to
> make sure there is no systemic cause to corrupt your future patches.

It's not a systematic issue, it was user error.
(I started writing out a story, but it got long)

Thanks,
Stefan

>
> Thanks.
