Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1896207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 07:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbcI1Hhg (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 03:37:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59964 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750997AbcI1Hhe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Sep 2016 03:37:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CF3B8207F0;
        Wed, 28 Sep 2016 03:37:33 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute5.internal (MEProxy); Wed, 28 Sep 2016 03:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=cX2T1ydeyyi0ClY/JqPzlJIP99g=; b=R2L1ld
        vTmoEp+lgmsfjyomgCOxzc9kMCRBpEAhkQgiLpJWM4yloMSoiBPJXyMdhCZOOsbB
        TCrdDkFQPm56yQUP0p7OXnO3gNhModZpi/zC2n4khoIK7aZiLutqh3AvR0V+H4/B
        9bRYX4Q10B7ZJAJhvmEDxBnkvneCYoXK8cNHU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=cX2T1ydeyyi0ClY
        /JqPzlJIP99g=; b=QNhl/j8ExvheJsbuIXEbQR1GZI4sJ94QVQ/Dl1wTjzT2UdV
        aqpZqa8wt/gMwDIjpcxcCp7xNhT2kVIkGpNf5z24hn7DA850E1Cz0FbfLFz09IJ1
        v3yiMCaRUZ/bWuXwB+CVCMto+D84bZ2cw5tWkYpygKx9Mu2gezQpWGEU68as=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 9CF702E6CC; Wed, 28 Sep 2016 03:37:33 -0400 (EDT)
Message-Id: <1475048253.906881.739334657.11813C91@webmail.messagingengine.com>
X-Sasl-Enc: hviEXmk7pMvHHUFlptRzJMKF7j5kLw/1c2g9+Nw3O1ru 1475048253
From:   Ian Kelling <ian@iankelling.org>
To:     =?utf-8?Q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-3ce3fca2
Subject: Re: [PATCH v4 2/2] gitweb: use highlight's shebang detection
Date:   Wed, 28 Sep 2016 00:37:33 -0700
In-Reply-To: <c35fc760-ae64-5df3-5985-7eecd06d937f@gmail.com>
References: <20160923090846.3086-2-ian@iankelling.org>
 <20160924223258.9449-1-ian@iankelling.org>
 <20160924223258.9449-2-ian@iankelling.org>
 <c35fc760-ae64-5df3-5985-7eecd06d937f@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 25, 2016, at 11:04 AM, Jakub Nar=C4=99bski wrote:
>=20
> For what it is worth it:
>=20
> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>=20
> (but unfortunately *not* tested by).

Thank you for all your help.
--
Ian Kelling
