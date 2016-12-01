Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A0B1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932165AbcLATxX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:53:23 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34178 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933968AbcLATxV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:53:21 -0500
Received: by mail-pf0-f172.google.com with SMTP id c4so47744160pfb.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 11:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TBYc10Iv5d0Hyexuv14eDWdIxX2R0CbU5lRPPm2+dTc=;
        b=GuZ0EGrR4SJFzTsF/+HNv41wtElfh6EPIDX4kMcSVnh3eekOZUTSZ+s8tgHzmHM6hW
         htlARuQVzAvl8BZ2DjBSDYOUcJn6Z5fpt6kMgOFZyuS0rretfts79XGwkbTcMLW/gHnh
         eaYoLa3DkshzZecAYhVVkrkhYHlQtAqnU+SXTvB+VN2MUAAjfXXl15SCdo05AheBns6d
         sy+jSQVyG/JvpzlFGegpQBrND2nbZ4DbsKRET252Yzrxyvxkr5VozXxWfpVDUGsXcL0J
         6fRqw7bMvtuiN59hCmtIPYeZB/GCEzvmqMQ1oVheEmedl5h4kokD3b/XOk78HcUdSp52
         TnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TBYc10Iv5d0Hyexuv14eDWdIxX2R0CbU5lRPPm2+dTc=;
        b=LwS/AcSb81Gxe1oFQOBrSnN1HSaD+2U3KlePv9B0KKnCN3ihdWvPGe2ZS0tCpv6Xov
         ok6NEqPFekicqn7kpLYZB+YyAH+Cj1IRr08//NawqOadsIp3JbqD0HKu2HwkhfP+ivg2
         sFKxXneY6hULbQerr/54dle7I03c8/S/7xXoQYjUhnqT4mDxRW9OQDQ8fZiHrbU+JSB9
         7UVHkqKkx8t/VCtzL4YI0TTd9dCO2cbmf8KPCVWx4ehxt5a0vuM5S7ybNSqJGgPtMfFk
         phCtcjppliGvtdn7p+IMAudSiDQ/ryXitvjx5dG5MLSGhd7UHcPMutmcFmN8xOOKYubJ
         WGJQ==
X-Gm-Message-State: AKaTC02rR7kSSNZD+W/A3bGNaO+KbtlwSEnLZaxlmclycoXjNP615fXgm+x87vurbDbNb5PD
X-Received: by 10.98.65.156 with SMTP id g28mr40826737pfd.110.1480622000943;
        Thu, 01 Dec 2016 11:53:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id w125sm2151491pfb.8.2016.12.01.11.53.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:53:19 -0800 (PST)
Date:   Thu, 1 Dec 2016 11:53:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: bw/transport-protocol-policy
Message-ID: <20161201195318.GE54082@google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161201083005.dui572o4jxsqacas@sigill.intra.peff.net>
 <20161201181415.GA54082@google.com>
 <20161201192055.44mtvtacyhpbqbqu@sigill.intra.peff.net>
 <20161201193524.GC54082@google.com>
 <20161201194621.dd3dbjv25ul6qgu5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201194621.dd3dbjv25ul6qgu5@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Jeff King wrote:
> On Thu, Dec 01, 2016 at 11:35:24AM -0800, Brandon Williams wrote:
> 
> > > I wouldn't expect anyone to ever set GIT_PROTOCOL_FROM_USER=1, but it
> > > does behave in a funny way here, overriding the "redirect" flag. I think
> > > we'd want something more like:
> > > 
> > >   if (redirect < 0)
> > > 	redirect = git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> > > 
> > > and then pass in "-1" from transport_check_allowed().
> > 
> > I don't think I quite follow your solution but I came up with this:
> > 
> >   case PROTOCOL_ALLOW_USER_ONLY:
> >     return redirect ? 0 : git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> > 
> > Which should address the same issue.
> 
> I think mine was confused a bit by using the word "redirect". It was
> really meant to be "from_user", and could take three values: definitely
> yes, definitely no, and unknown (-1). And in the unknown case, we pull
> the value from the environment.
> 
> Yours combines "definitely no" and "unknown" into a single value ("1" in
> your case, but that is because "redirect" and "from_user" have inverted
> logic from each other).
> 
> I think that is OK, as there isn't any case where a caller would want to
> say "definitely no". The most they would say is "_I_ am not doing
> anything to make you think this value is not from the user", but we
> would still want to check the environment to see that nobody _else_ had
> put in such a restriction.
> 
> -Peff

Oh ok, I see what you were going for now.  That may be a better
(clearer) solution then what I just sent out.  Mostly because we can
maintain the same logic polarity and use the same vocabulary.

-- 
Brandon Williams
