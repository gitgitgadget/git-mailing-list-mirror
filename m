Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48122029F
	for <e@80x24.org>; Tue, 18 Jul 2017 14:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdGRO3N (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 10:29:13 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36542 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbdGRO3L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 10:29:11 -0400
Received: by mail-pg0-f51.google.com with SMTP id u5so13652052pgq.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=2vQS7eFODD4CPki13gB2rnr7BydNUofD4otxZlpgbqE=;
        b=g6CQDenTP0xDxNMv0umSE8nK6jTDitqmvSokg/Lgsu796Kz9lKyv14AU7D316Tgpne
         e1wAoajFYYqWktEWhuj8goaOdi0ugAZITAqMOffyMM44LVpM7CPNUmBLkAhmAUVHNTA0
         /gNBsbvWtj7iye/NvprOwPASooYV/2Lyy1DY1d2KXHt/OL2EyHNmFL5VIKGNuiLxgzgM
         AAPzIxp36mDZY4SuuIqcRBPYROHXl1dhgiIDuT06HFamKreAd1UdbcR/c+p6hiTskJfz
         xbEoea7iCuVdbGtb0zy8efNx12yVbfssAwtzjwKOf62mQjWurJrZeI27jOGEcgLX2npp
         +mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=2vQS7eFODD4CPki13gB2rnr7BydNUofD4otxZlpgbqE=;
        b=GDcEtr3xrpyQxdt+tXxLWp8kxdOQ4X5FFe5s4M0aFzNzUx5HEGYYATcatvpnJ1ZBmN
         XHkSkzAln3omYIKTQNxx2L9Y1QkHBYDuKEd8TIuhcJ3evg9rMXNEcxtbz7Y98Mefo6SN
         wyaYFANYeg/q8yF28ioabYDiBadlRdaN4cnSNBmWUdAN6yffnXxVosg75jjyUUHtsH4x
         ROsKg/fSWs6gsTUhkOf2N4zj3v6tLf9ShKmRwAnppIBhtIkgMiHs24cDieEbL4zV6OB3
         rbNMUm0hTdZgrqI7nvO/ijBe/Gr8/GRkOE34ohfoYo/JKbxlUFxmKxzRi0cdu3W2Gpzx
         V5Og==
X-Gm-Message-State: AIVw113jkCc6Et351s6CNTvg3hrG/20kxSPkM2PqGxy1oIxSlSea0voF
        5VSgQRw2UT7wvveTJgI=
X-Received: by 10.98.81.1 with SMTP id f1mr2009676pfb.94.1500388151181;
        Tue, 18 Jul 2017 07:29:11 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id p78sm7684458pfl.84.2017.07.18.07.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 07:29:10 -0700 (PDT)
Message-ID: <1500388168.2065.2.camel@gmail.com>
Subject: Re: [PATCH] doc: reformat the paragraph containing the 'cut-line'
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqefteg155.fsf@gitster.mtv.corp.google.com>
References: <20170717153839.16586-1-kaarticsivaraam91196@gmail.com>
         <xmqqefteg155.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 18 Jul 2017 19:59:28 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-07-17 at 15:16 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> > +	Same as `whitespace` except that everything from (and including)
> > +    the line found below is truncated, if the message is to be edited.
> > +    "`#`" can be customized with core.commentChar.
> 
> Is there some funny indentation setting involved?  Why aren't these
> lines aligning? 
> 
Yep, there was an indentation issue that I have fixed now.

> > +
> > +        # ------------------------ >8 ------------------------
> > +
> 
> 
> Does an empty line before this one screw up the asciidoc formatting?
> 
I think *no*. I build the docs with the change and didn't find anything
odd. 

> If the long line is problematic, I think it is safer to perhaps
> spell it out, perhaps something like
> 
> 	... except that everything is ignored down from the
> 	"scissors" line that begins with a core.commentChar (`#` by
> 	default) followed by many dashes `-`, followed by the
> 	scissors mark ` >8 `, followed by many dashes `-`.
> 
> ???
> 
I think it's better to keep the line as it is, considering the famous
cliché, "a picture is worth a thousand words" and combining it with the
fact that "humans looks for patterns in everything".

Spelling the line out would make it hard to get a *picture* of what's
trying to be described.

-- 
Kaartic
