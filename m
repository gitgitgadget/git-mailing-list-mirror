Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA3D20248
	for <e@80x24.org>; Mon, 11 Mar 2019 05:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCKFro (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 01:47:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33984 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfCKFro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 01:47:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id u9so2907821pfn.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jOZ43klF/k920pc/2y1RE2AsgHcN1YEf9iDIQqc3jzw=;
        b=Wn57D2vxvSXQ7JX5N3yqYRWi8BE+vv5i+Q8JfL133NzbjjspYkPK67tqFepJRKltJe
         fpuLythlTNWdKyf482pS/o2PdNkWd9fbMDTxlFSqR4PTR/rCSBTC0cNAv2/jpX0Y5uKd
         wYRqn9Kj4hAvzGsLkWo49zM54788gooRAcm3gqXV7MvRToDQTeuy69KzsBL7p+PxY847
         mug1GjSPlRJd0dyOCPEXy4h2tkcLSnHGd/fliQSMTuR0ihvZE3Ja0NSv/tcfRzIyJOl6
         Vj/yGopiCyml+gDV5dNksJelDVkXK1wYCKSukyjtYS80Qj5f01/uqI7wIgygWCiblK4Y
         dpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jOZ43klF/k920pc/2y1RE2AsgHcN1YEf9iDIQqc3jzw=;
        b=Qqa3yK8qoS5UwXy2z11Fpn1/xx6NO+tKj4lZqJvuF3MYMzLJKtfm5lMth9JXV/zKut
         Bh9c86o8sOYnXz12zzBklBoAxfBmLHV2q8a5LtlyTME7cbNSH2/rOqTb0/0uulRJYZqz
         RaWLj77r8Wxo2jxqlmFnetnzjWvhweNaLNvKx0vae6ePLOz4bfqn9WwVWE4eXmjf8Kui
         ejb3Z1qNDN52uhTGDuoZeIM8WY8At+fRvNlNE3BbA2cx2ATzdDS1iQi8tOdgLbh77rex
         x+caTdEPBZl7VUhRkPz+yfmOpKQ0lVl1KwTy3Nm9Cpgpho+/+vG0YohuqJOKH1egTese
         i/kg==
X-Gm-Message-State: APjAAAUz9n4y+4DPe2/Q18G6YvJ1QjjXnN10+1wNDAaVU4ZCngz+LRv1
        UTCXu/KYj811enIXd8yeZ4OYbqyQvQqabsiHpWQ=
X-Google-Smtp-Source: APXvYqyFhpGIS76mV7mGQmsUBXk8hLQQlwOy/OMxB4MFqgYanzFC6k6mtPVUfJMn4TqihjzERuU29t9GigYuic70wmI=
X-Received: by 2002:a63:1a12:: with SMTP id a18mr8353355pga.200.1552283263960;
 Sun, 10 Mar 2019 22:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com> <cover.1552230490.git.martin.agren@gmail.com>
 <20190311025952.GA6425@sigill.intra.peff.net>
In-Reply-To: <20190311025952.GA6425@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 11 Mar 2019 06:47:32 +0100
Message-ID: <CAN0heSqpZRaEjZpRAizy6wudf+fAAOwJWYdtf7OJP3SRoXf1Sw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix spurious space after linkgit, now in *.html
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Mar 2019 at 03:59, Jeff King <peff@peff.net> wrote:
>
> On Sun, Mar 10, 2019 at 04:14:22PM +0100, Martin =C3=85gren wrote:
>
> > [1] I could have sworn I checked the html docs and saw that they didn't
> > have this extra space. Looking at git-scm.com again reveals that it's
> > not there. Huh. Seems like the site's html-rendering doesn't go through=
 our
> > Makefile at all and handles "linkgit:" on its own:
> > https://github.com/git/git-scm.com/blob/master/script/doc_importer
>
> Correct. It significantly predates any support for asciidoctor in our
> Makefile, and needs to do some custom ruby-level tweaking (though
> possibly that could be cleaned up these days).
>
> The doc_importer script you found, though, is not part of that process.
> I _think_ it's just leftover cruft. The actual import and conversion
> happens as part of the rake task in:
>
>   https://github.com/git/git-scm.com/blob/master/lib/tasks/index.rake
>
> (Not that any of this matters for your series; just sprinkling some fun
> facts into the conversation).

Thanks for this background info, and for the correct link. :-)

Martin
