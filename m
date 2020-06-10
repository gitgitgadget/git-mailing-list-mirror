Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A3FC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 00:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57401206C3
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 00:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fgcint.com header.i=@fgcint.com header.b="eXEtQPrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFJAJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 20:09:34 -0400
Received: from frontlinewindows.com.au ([139.218.255.53]:37376 "EHLO
        luigitp.frontlinewindows.com.au" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725797AbgFJAJd (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jun 2020 20:09:33 -0400
Received: by luigitp.frontlinewindows.com.au (Postfix, from userid 1001)
        id 191C52406C2; Wed, 10 Jun 2020 08:09:26 +0800 (AWST)
DKIM-Filter: OpenDKIM Filter v2.11.0 luigitp.frontlinewindows.com.au 191C52406C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fgcint.com;
        s=default; t=1591747766;
        bh=Yg4kg/53LFypIgsp+LcObsT9HOoWR28NYsPhpLVjOmA=;
        h=Subject:From:Reply-To:To:Date:In-Reply-To:References:From;
        b=eXEtQPrCmKxAtUUJ7H3UDURgUSqdoVxiPmSOoWBgmOd+E0hWpfKtVJu0S/PilBtsV
         liXaLDaVj7jwPDzf/DM6TgA2DCBdlpXXZA3JsqPjmNG8IpUOEl8q6qPPLL6fjIeHlo
         B9HLSUS4QBGHmrxeiVvuGcaw+gJfP+1xoWrGhQLo=
Message-ID: <36bd7dc26883017770c28da94a251be2d5019f75.camel@fgcint.com>
Subject: Auto Rescan - as plain text
From:   Luigi Cantoni <luigic@fgcint.com>
Reply-To: luigic@fgcint.com
To:     git@vger.kernel.org
Date:   Wed, 10 Jun 2020 08:09:26 +0800
In-Reply-To: <816ce248ab1708d41b5233abdb998ff2d4cb3400.camel@fgcint.com>
References: <37bd22ee8bcb9c91969d68cbc5e6852a8a70ab36.camel@fgcint.com>
         <bf895dc550881b35baea45cd269bf9b0518ade35.camel@fgcint.com>
         <816ce248ab1708d41b5233abdb998ff2d4cb3400.camel@fgcint.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,
I have been using git for several years now and using git-cola.
I just started up git gui and that is quite self explanatory and all
the functions I use with git-cola appear to be there.

One thing I liked in git-cola was that it very quickly reflected my
changes in its display window.
I have looked in the options and I cannot see either a flag to set it
to auto rescan or set a time for the auto rescan.

Have I missed it and there is a way turn this on or give it a shorter
time (if in fact it is does do it).
If it is not offered could it become an option.
I can see that some people may not feel the overhead for distributed
system is worth having this on so they would want if off.
It is not critical (just nice) as I know I can
1) rescan
or 2) go off the file and back on again.
It then displays the correct diff/updated contents.

Thanks for any advise or help.
--=20

Thanks
Luigi Cantoni
M: +61 421 624 804
T: +61 8 9418 3777
Email: luigic@fgcint.com
--=20
Thanks
Luigi Cantoni
M: +61 421 624 804
T: +61 8 9418 3777
Email: luigic@fgcint.com
