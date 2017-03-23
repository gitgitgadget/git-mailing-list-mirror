Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5277B20958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbdCWTgR (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:36:17 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37537 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdCWTgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:36:16 -0400
Received: by mail-wm0-f41.google.com with SMTP id n11so5016332wma.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R9g8bXNnYtSK+ocrIfD14vhRusObMfjGxrE0zgSRjVM=;
        b=ZnMEnQgDSjHXH6q0sxYldn6JfvZj0HzEjpz6iEvFtclXSvCg1jtKLjzDvy0vgC0r5q
         Eihku9ZlTPRuvjXTX3ZgfDCCwsjji+DRzlSLAswv6c0hkFY/EsCL8Qt1prkpsSQCqsxd
         Z3ev+hM0NEOhrq+JYtsSmmTFI2fC82mOSn+ePxFrz5kn3qYwgUEKYYLvb4uYKlJx9luY
         xYa78aGGPCrta4EdWd4KTU/Fd9yCZx7P/JO4uz1GkeBLbiI55/iv1eXavl08ZLpqug03
         RxBy5XJn89KohSq3ibc6qKahrkyU1aKETJXSjobjTEsy7I8Op3kPIN9+Wa3WnSD7Pjja
         WHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R9g8bXNnYtSK+ocrIfD14vhRusObMfjGxrE0zgSRjVM=;
        b=dMBs7rhtykFoW+0g6WCPvrgeylH6dXMIDsyj3mhnN1wEqMax4H01aLeLzvUDnW5O6L
         mU+zxbnE8ucCRWFUZ8cmG6C7XOpojrbkJvMxZm4zEO06wnY6lgO7LqICqQm/4JvU4Jju
         KYzfy0RBshGgDFByBcO7z48/OcyFwiBnHZjXhACftqVfyMy6sUz1UFpFm3ARdjAItD/S
         UN85lUK0ugXz/L9XnWlWwpcBtWMI+HhdxLy+HzqcYYNY8llCt7C38qjBdiZAxZc2H/zv
         1PdFXxTgNpKVSnYqvgy52GcJcvt6yVgc9YUuzML4A2w3wCEyo+5YNiXBWJnjt5pdZAnf
         Lygw==
X-Gm-Message-State: AFeK/H0BXEaSN9UbmGSR6UJaES65P/oWM/qIizHvtS0hrm0QxwixohjZC4j/2sFILdaNPA==
X-Received: by 10.28.195.197 with SMTP id t188mr15468153wmf.61.1490297774052;
        Thu, 23 Mar 2017 12:36:14 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB47D6.dip0.t-ipconnect.de. [93.219.71.214])
        by smtp.gmail.com with ESMTPSA id b17sm5550767wma.33.2017.03.23.12.36.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 12:36:13 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzigbbxjq.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 23 Mar 2017 20:36:12 +0100
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <81C8DFC7-53DA-4533-8005-F6D8D643FDA2@gmail.com>
References: <20170322065612.18797-1-larsxschneider@gmail.com> <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703231716320.3767@virtualbox> <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net> <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com> <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net> <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com> <xmqqzigbbxjq.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Mar 2017, at 20:30, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> "[...] we do not provide these values to untrusted builds,=20
>> triggered by pull requests from another repository."
>>=20
>> See: =
https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-=
in-Repository-Settings
>=20
> OK, it is a releaf to see an indication that somebody over there is
> thinking.  Thanks.
>=20
> So we do _not_ have to turn it off; as soon as we define sekrit
> variables, they will turn it off for us ;-).
>=20
>>> Hrm, it does mean that people have no way to test on Windows until =
the
>>> branch hits pu. Which is not ideal.
>>=20
>> I agree it's not ideal. But I think it is an improvement to check
>> pu/next/master/maint continuously :-)
>=20
> I am not sure what you mean.  We are building each and every branch
> updates already, and I do not see any improvement over what we are
> doing now.  Care to elaborate?

We are building each and every branch on TravisCI right now - but=20
only on Linux and OSX. With this change we also build it on
Windows. That should help to spot Windows related issues more
quickly I think.

- Lars

