Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5803D201B0
	for <e@80x24.org>; Sun, 19 Feb 2017 02:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdBSCI1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 21:08:27 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:54516 "EHLO
        homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750893AbdBSCI0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Feb 2017 21:08:26 -0500
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 3482A34806F;
        Sat, 18 Feb 2017 18:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=paLTaNByxfZE+65VXn/AampHyg4=; b=iw+SBnX6X8
        auDgA9k0Z6BgNxFckE0sSHzNd1YfhQ6xIQiM44CMzNJ8U7wOeqO3e0zWDFkZVlr+
        cTfUq3V23+1dBc3p0R+847cxkGEHckstYFzRnniLKxD6mjVcmFVkEF2SUaqj466K
        y3wytrGuVFzDnEybeWkPZzeH6QLuQ1cf4=
Received: from main (c-174-63-86-113.hsd1.ma.comcast.net [174.63.86.113])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id C2B6C348062;
        Sat, 18 Feb 2017 18:07:35 -0800 (PST)
Message-ID: <1487470052.3570.7.camel@mattmccutchen.net>
Subject: Re: [PATCH] fetch: print an error when declining to request an
 unadvertised object
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sat, 18 Feb 2017 21:07:32 -0500
In-Reply-To: <xmqq60kfezr9.fsf@gitster.mtv.corp.google.com>
References: <1486747828.17272.5.camel@mattmccutchen.net>
         <xmqqwpcxlwpv.fsf@gitster.mtv.corp.google.com>
         <1486934007.8517.10.camel@mattmccutchen.net>
         <xmqq60kfezr9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-02-12 at 15:49 -0800, Junio C Hamano wrote:
> The fact that we have the above two choices tells me that a two-step
> approach may be an appropriate approach. [...]

> Even if you did only the first step, as long as the second step can
> be done without reverting what the first step did [*4*] by somebody
> who cares the "specific error" deeply enough, I am OK with that.=C2=A0=C2=
=A0Of
> course if you did both steps, that is fine by me as well ;-)

I appreciate the flexibility, but now that I've spent the time to
understand all the code involved, it would be a pity not to go for the
complete solution.  New patch coming.

Matt
