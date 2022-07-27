Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF3C19F28
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 13:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiG0N7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiG0N7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 09:59:09 -0400
X-Greylist: delayed 1387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Jul 2022 06:59:09 PDT
Received: from qproxy1-pub.mail.unifiedlayer.com (qproxy1-pub.mail.unifiedlayer.com [173.254.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148B239BA5
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 06:59:08 -0700 (PDT)
Received: from gproxy3-pub.mail.unifiedlayer.com (unknown [69.89.30.42])
        by qproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id B17B38032F9A
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 13:36:00 +0000 (UTC)
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by progateway5.mail.pro1.eigbox.com (Postfix) with ESMTP id 8FEF410073841
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 13:35:41 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id GhCPoJMmiWg0EGhCPoIeJ7; Wed, 27 Jul 2022 13:35:41 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Y4w9DjSN c=1 sm=1 tr=0 ts=62e13f2d
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=RgO8CyIxsXoA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=iTzkl6VgH4E_Jhm7GEEA:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MGki/4cL+gslSah40HSeuxLTSdpo46V5UkxcQwMobxo=; b=vCXxSup/EPJu3iKb3a0PcIrQmC
        1lt1G8tlgJ/+1rCWx02a08sJgO9TAI7o9QABvg3trOsTWcROT9eYuk38cyLdQHgow9ms8erUc7dAs
        x1oSVEzJMCfY8tooGLwA3ukMh;
Received: from [160.231.0.90] (port=42105 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1oGhCO-0022UA-O0;
        Wed, 27 Jul 2022 07:35:40 -0600
Message-ID: <18f324b9934982d577c0d9b0631d33818574df00.camel@mad-scientist.net>
Subject: Re: [PATCH] Use 'Everything up to date.' instead of 'Everything
 up-to-date'
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org, Jay Berry <jb2170@selfadjointoperator.com>
Date:   Wed, 27 Jul 2022 09:35:39 -0400
In-Reply-To: <220727.86r126lxt0.gmgdl@evledraar.gmail.com>
References: <pull.1298.git.1658908927714.gitgitgadget@gmail.com>
         <220727.86r126lxt0.gmgdl@evledraar.gmail.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (by Flathub.org) 
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.0.90
X-Source-L: No
X-Exim-ID: 1oGhCO-0022UA-O0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:42105
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 2
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2022-07-27 at 11:15 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason w=
rote:
> That "don't" is up for discussion, but a subsequent re-roll should
> argue it based on the points raised there.
>=20
> If we *are* going to change this then:
>=20
> =C2=A0* We should mark this for translation with _()
> =C2=A0* Don't have the translation include the \n

If no change to the text is wanted, then maybe a patch should be
applied that adds a comment to the code saying that these strings are
left as-is and not localized intentionally, to avoid similar issues in
the future.
