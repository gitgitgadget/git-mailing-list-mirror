Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A531FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbcHJVTt (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:19:49 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38161 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbcHJSFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:05:37 -0400
Received: by mail-it0-f47.google.com with SMTP id x130so52155625ite.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:05:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d/UmxsYVJI85sgy6E41XtoBiX5ZAA+K33yy258EuT8Q=;
        b=XzpFFx9U1DnuZd9A8RPOe4gfw8LNqycJ1xJm8yHGNlOKzZ5txZiYE5uuCIIQhWH0ZW
         qqv0UzWpyoLRSTCyY1g8OfRy9mm+fommQGwNEOaOKgdEfoB1VEF4TM11eA7ACvHtFvp9
         6t7JcKl4VdKYuv6PRdckq4EqULQX69dWpIbXv/IHX4Br3fsq/jA/8U7hXjmP6fiYAYHu
         R45J5QQLAxRnPH7/4I+c9Q8lzUWjZEwy5BBj/bsjgM9QCryr46YLHTgZtyN9lLPeoV4N
         brhyaBIOTg2KSDO35EXsvWNLM5XfPgY8m+R8ylhGbgibkZBPBNPjaLJ3cM8+gblBE/99
         yQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d/UmxsYVJI85sgy6E41XtoBiX5ZAA+K33yy258EuT8Q=;
        b=gdCIZKs6aO7TxA62xhSNQRLawm9vciZIYbxkfngytMPWqCC1ZRrIq2odJ2LzutzXlC
         z6IE0eFTR36qDD9E2qaSMgmL+QWc4KDwoJPH03fFnjVUBRhAR+NMAFv9rW45dtMaUznC
         NUtqPXUNV9jPkWdVCjAQGjC3C+kBQT9hc+o6U1m6MIti1b3xGLbaYlakf5ogbtbTpQa3
         fL1At9aIitwfJaO5AcwnxgUc1dXjVSKSgPwLjV3DXQsnrw36E1voUww1V3eZg/EcITuT
         8fDdcg94Am2EQtbAT6X5zv8NtDyVcgsXQI+16OuY415HUGjHwImmHFdsNpWWnSKNGjaG
         B19w==
X-Gm-Message-State: AEkoouvb/bXbZ2KMiKl/QwDTYymC6PYADadmn5xP4noMaB2XfuFcz2ntsyChRBnvsTgv+Vyw/mcAdz9ZyFhb/1XZ
X-Received: by 10.36.92.206 with SMTP id q197mr4734514itb.46.1470848288509;
 Wed, 10 Aug 2016 09:58:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 10 Aug 2016 09:58:08 -0700 (PDT)
In-Reply-To: <48ca79e2-418b-3c73-e075-808d39a4da9a@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <f4ce27f389b64c9ae503152c66d183c4a4a970f1.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kZk+XW+Bwcx_fvOLVBDse_iUSjEa_K=eJqm4PpTsTAcPA@mail.gmail.com>
 <57715dee-ca73-c1bb-ee79-2813d7873649@alum.mit.edu> <CAGZ79kbyCRDTt4u+Fje819mNZZf3GkZtYVurwOMPXRfXqO-YEw@mail.gmail.com>
 <48ca79e2-418b-3c73-e075-808d39a4da9a@alum.mit.edu>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 10 Aug 2016 09:58:08 -0700
Message-ID: <CAGZ79kaSnm-MoWf254UpzY4XS=AO57fChqOntBzGF3wW6TxUag@mail.gmail.com>
Subject: Re: [PATCH 2/8] xdl_change_compact(): clarify code
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 9:39 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

>
> I realized that the main thing that took me a while to grok when I was
> reading this code was that blank_lines was really only used as a boolean
> value, even though it was updated with "+=". That's the main information
> that I'd like to convey to the reader.

Oh :(

I think there was some discussion when we added the blank line counting
whether we would want to have it boolean or counting. And we settled
for counting as "future algorithms can make use of this additional information"
IIRC.

>
> So I decided to change the comment to emphasize this fact (and change it
> from a question to a statement), and also changed the place that
> blank_lines is updated to treat it more like a boolean. The latter
> change also has the advantage of not calling is_blank_line()
> unnecessarily when blank_lines is already true.
>
> If you have no objections, that is what I will put in v2 of this patch
> series:

No objections from my side,
sorry for this lengthy discussion about a comment,

Thanks,
Stefan
