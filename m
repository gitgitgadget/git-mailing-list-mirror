Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BFBB202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 03:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdJ3DwS (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 23:52:18 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:48147 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdJ3DwR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 23:52:17 -0400
Received: by mail-qt0-f179.google.com with SMTP id f8so14797571qta.5
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YEbc33UslPixMTNz9wvKkCO9y+Zb1UcahovDTi+rhbw=;
        b=PuTXDb5d57N3IJoVpMlj7wtuFjeC18CNt9D/9XiTwfCW+2HIFqehfp4kvgalHjEErM
         vYl8+yPW3PZFy1xCF+NeDTY1Ta/36vSr3VM8FIliavR6KmndKCugIWqddrLkGEmDV8he
         3jdQA0Dfy8B8a04vVt5b3Z3siplVR/dbdhq4mOpdQxFwUZw9qVuuL1DhWxu7TNJM8mCb
         KvRfQ85GAS41qLZxN/a2nltQRTRbXRif/9HVV1IvQIRJlUL5zguk73zJcbkoovoGmGmr
         peF5rAzs2L21fnrdp3T9bIc1Xqvz8XBajr23wlkjF1KGV0TWxQVmx9wBV0ooQvJYgIPT
         lIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YEbc33UslPixMTNz9wvKkCO9y+Zb1UcahovDTi+rhbw=;
        b=YESJ1OKK5jNs1aRL+M+/9Jie0lMYWp+ja4cYZ6nifKnmmhU5tWIwdbwW4vuUaZJY1u
         LFfYCvLSOn9Dqy7zjLGgH9/KzSmUenePEAXIRDuVLXDDC3EW8sFZcDaaWRnolZ7xNuCV
         xNDF6gcuzZaC6H5Dcr7g4do1gb2qYwDxZyBg08zOyUdkjHJUYAsLXzHzcJKgIN9miwfj
         U1U0ic4tR84ve/BAjsCmmoPFxj02uDYRzbAAALuNmdGQ75YtIIIl4/pPCw7sTrwFNbkA
         kqsmBI8GdBjY+OTG8RCoCCoheA9jZfXJ+ax8s/x3fXRaBDuYH0r7lKE1j7d1xAoqXJkw
         MSVg==
X-Gm-Message-State: AMCzsaV2UOBrkBsvjdip80F8l6wWzTZkeYvI6BrtUR0OeJWvaqyiNsIF
        jIyMX5CHCcWwk/w19HFQhtNfLsdK/wYto8MwrkM=
X-Google-Smtp-Source: ABhQp+R7u5H2hi4WoYMqNdz+WfdOaCILIyi2ou4kr8PGYE+rhlr3/FqKCVncpRxtzfzn2uK5mUWlbBg7FUgj9CsutYY=
X-Received: by 10.200.23.82 with SMTP id u18mr12077650qtk.163.1509335537077;
 Sun, 29 Oct 2017 20:52:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sun, 29 Oct 2017 20:52:16 -0700 (PDT)
In-Reply-To: <87y3nt73uy.fsf@curie.anarc.at>
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-5-anarcat@debian.org>
 <CAPig+cSTp1Udo6xXk5-L6MpWBdiy4sPO__NcND03-89EvRgLHQ@mail.gmail.com> <87y3nt73uy.fsf@curie.anarc.at>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Oct 2017 23:52:16 -0400
X-Google-Sender-Auth: -ZjXi2GEib7EQvkRDdwFYPQDyjU
Message-ID: <CAPig+cSMRG0_kPpgFv5hco9Lk9jfYmJm-+rkQaw6vNQTdoEg7Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] remote-mediawiki: allow using (Main) as a namespace
 and skip special namespaces
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 10:43 PM, Antoine Beaupr=C3=A9 <anarcat@debian.org>=
 wrote:
> On 2017-10-29 15:49:28, Eric Sunshine wrote:
>> This may be problematic since get_mw_namespace_id() may return undef
>> rather than a number, in which case Perl will complain.
>
> Actually, get_mw_namespace_id() doesn't seem like it can return undef -
> did you mistake it with get_mw_namespace_id_for_page()?

Hmm, no. What I see in the function is this:

    my $id;
    ...
    if ($ns->{is_namespace}) {
        $id =3D $ns->{id};
    }
    ...
    return $id;

So, $id starts undefined and is assigned only conditionally before
being returned, but perhaps I'm missing some subtlety.
