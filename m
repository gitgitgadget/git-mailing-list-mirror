Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D2C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F5F64E60
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhBWTdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:33:10 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:44278 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhBWTdI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:33:08 -0500
Received: by mail-ed1-f48.google.com with SMTP id g3so27091484edb.11
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 11:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lJNg8MdlNhgp+c+dCdGb49LeJPcMyGcl4GH/EW4uxg=;
        b=aaPbFv3mQTFc044uN4uj9NSMiJbYnWVGqhoqfGBu9Cw19Ly/w7saTU7hMJDAPR8Jrl
         qQn6Owca3Tin8qIJspv0ZFRDEZRRHCa9OyMnxrG5liz7sWGIoZQPSkzFdLt31n9JBN3g
         msDqGCGgfNlzoGMvTOW9SFW7BHkb+R4yxnxkWENeT2yD84aTQgYaltYH7If/DDHuA1Cb
         57t8EA1j8fbuBJxbloF0FEViy+S7X5OFGouL+6frctdyLWy0ttgudfDTwGg+nqxhfBwb
         R8mjYl4jyWFljIdtygzRxCKWwljp6M4dDmV0wQzHxeZ0d703Se7Q7U3inpYVvyr1CNg1
         YlOg==
X-Gm-Message-State: AOAM530Qwpgv1tCHFJCNZZsk2piVYROjFNNmC4fGOqE/DZqlN8v4cn5O
        xSrGI++I7xy/LI1MOQppdLeP+XImVmyfflbGp2I=
X-Google-Smtp-Source: ABdhPJzKo82hf7AIyFZeZsE+0wJ3MAMYCfAA7pEDgm97Ez77tMx6oXoSEBiIvt5oGiuDaJZtOL7Mx0R26d0NFtj+nAk=
X-Received: by 2002:aa7:ccd4:: with SMTP id y20mr29958474edt.94.1614108746948;
 Tue, 23 Feb 2021 11:32:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614062288.git.liu.denton@gmail.com> <cc48b125166a241ef5f24138fd161223ab35e361.1614062288.git.liu.denton@gmail.com>
 <xmqqy2fe1t6o.fsf_-_@gitster.g>
In-Reply-To: <xmqqy2fe1t6o.fsf_-_@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Feb 2021 14:32:16 -0500
Message-ID: <CAPig+cSSnx3y1Uh6uLvdiMn_xg2--w2-_4VDLqXYJ+WARhc6Gg@mail.gmail.com>
Subject: Re: [PATCH v2] i18n.txt: camel case and monospace "i18n.commitEncoding"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 2:28 PM Junio C Hamano <gitster@pobox.com> wrote:
> In 95791be750 (doc: camelCase the i18n config variables to improve
> readability, 2017-07-17), the other i18n config variables were
> camel cased. However, this one instance was missed.
>
> Camel case and monospace "i18n.commitEncoding" so that it matches the
> surrounding text.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> [jc: fixed 3 other mistakes that are exactly the same]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * So, while I still remember, I amended your commit and queued
>    this.

Denton's authorship seems to have been lost (no From: header). Was
that intentional?
