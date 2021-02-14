Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C14C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 10:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3C564D9D
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 10:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhBNKGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 05:06:07 -0500
Received: from mout.web.de ([212.227.15.3]:54101 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhBNKGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 05:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1613297047;
        bh=fLreOfkZ3QWL6C7XbDyVURKwSWh+rhgoU+z7N20V5dM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZaCDAvHf/o2LPb73conQV34iIUlPXpZIHn1KAMU33gQze+mgnZ/hqGKp4ewy64U5k
         c4jN0pJzV3iaXF31mdpbxspJuaO6dscaaTtHP33l9HrpZZu3LANTrvn7Ok2vs4tG3+
         9nOTdg8+eGqsp5Oz34vppTblslpIL6QWKv7AA6q8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LbOuI-1lZoeD2X98-00kzw8; Sun, 14 Feb 2021 11:04:07 +0100
Subject: Re: gitattributes export-subst and software versioning
To:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <ac1288b8-5cdf-8e1e-702a-815c5fbc2da3@web.de>
 <4f65f02c-1d16-aa2c-3e7b-28d807b9ebe9@archlinux.org>
 <xmqqpn190y8a.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a8171389-4296-8edb-5294-6a77dc1e5fa2@web.de>
Date:   Sun, 14 Feb 2021 11:04:06 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqpn190y8a.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z6vbG/VqnATPtNDcGSUs6zKeAIQbtoi549jz18LC3tN8EdjtL8Y
 OWzBlFw467d//AJ6OXf3sP+Yiwd+eUvY89E+uVQdjhd9QWct7gxldJPiVxQyN+xBpAMrxZu
 UuCZTnv3eQR5ze6zf6UieTxaG8TYKELhtTro+IUiRSGTVDi4ivv7MVgwyhMnBKeTDkDfdBY
 8Gx6KVZ/CTi+Wjg3Y3MTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j8vTPGVKp4E=:8nWCm+EuSvVuPkL96fzOFQ
 tGZ4Ok57p5L9rSv67OF+0fkUR4z5k7k1EalWNN1onML0RIFw8jwQXqPhX96U0DusSdi8KV+Vi
 AfIQ6mfg/9ni9isi8CI4r+RR8tYoJ/BHrJRghSPYjwmXCDJ1TthSRiGUAjebpm3mywcmi1C/a
 xwiPk5BjJMBUpM2M5QszkdkzzQ+JhjN3t/bxeSdznkxJPy+i6Fwm1RV1E9F07bhbwWLUpCcN9
 248AqOOrUMLA2dP3PCcxNZ8uVqoMQk0Z4nSa3dKS3XSHz1ghFSH5CAJR4kMOyDI0hAM+ZOtBh
 1uH6/n0T+L8m7HRjaUXjh4W7GaKr3HlbTV70pHQFohk87WrkRaIoFBZzkHsYcpy5pyfWJnhNG
 RWlWecyQjAwREPFbpX9IYxD5pkW1hgd5BrNglogvbyB3CwBEJFTqUCUulgN6RfMwvAoHS1iq1
 eblxORopA/GU2YFzrE0aZXOg930tOput8f2Jp2pJjeiIL4yNhcP8MM79IaHwtHk7BhmKQiflR
 SMsH5OVa6z6iGdXXkwgh7c7b5GEu+IsZ5ktdgNmazl5rQUZKFHvfoy6ra3hv2RFqHut9q8Wt7
 TwvZ9BDN2mhoytnjb6F+3NJEJ6iXARjHrsB+UHIZsLNYV5LIrWMQbSzkhcPnD8fSNxXRrFSy1
 TeEzptXqhKJ7hb1LISzkmhJgAQ6ZIelp4u8B6hKmK1zor/W9vopUCo56WmYjByNiQ3Bn1/dJZ
 hoZD3JxMscpraoe6lcJUWsGk98KQ56uQx8I816X6sBq6vfzruCKiSkA6JCuvMT57ruIWmOpA5
 rDDotgRygKZp8M69bVrCnYZyLF288ApyC48hsVwavLP6M4CytJi2/wX0vnYVRiEEk/Tu/U4Br
 NGHP+UywFX+6qxqzWnOA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.21 um 21:42 schrieb Junio C Hamano:
> Eli Schwartz <eschwartz@archlinux.org> writes:
>
>>> And replacing the flags with a commit slab doesn't seem to be enough,
>>> either -- I get good results lots of commits, but for some git log wit=
h
>>> the new placeholder would just show some nonsensical output, as it
>>> seems to get the depth calculation wrong for them somehow.
>>
>> You mean git describe <commit> produces wrong results for those?
>
> Running "describe" as an external command, like the patch you are
> responding to does, would not produce any wrong result, but R=C3=A9ne's
> point is that it would be very involved to turn "describe" into a
> function that can be called as if it is a library function without
> disrupting the operation of "log" that is running in the same
> address space, and the change he tried had some weird bugs to get
> the computation wrong.

Yes, indeed.  Let's go with the forking version for now -- it may be
slow, but it's fast enough, and it's better than nothing.

Ren=C3=A9
