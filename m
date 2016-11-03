Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB202021E
	for <e@80x24.org>; Thu,  3 Nov 2016 15:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbcKCPcW (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 11:32:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56252 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753179AbcKCPcV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 11:32:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A58FF4B841;
        Thu,  3 Nov 2016 11:32:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2zY7m1Mnx4LD
        9G/EvnPNTNW0v38=; b=elED3z01tHHhDgLzSSMPQqCEA+z7c+Z2yFSCjjBqpILJ
        ltXb7D5n1/Dy0AV5PBmcjq78ApNtnwgW+gYl+lMt+Hg7VUnUPWU907R9uZ7fLog2
        SLwd9YyPlUI2ltZ8jxa/u+OzBEowx1a3eFVB0ZzSTChoo175JDHtypfbjF/OJks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JrsGms
        jwmfxmk/Hbnw1ItPfEfW5S7dOFt14HDDr50iD8TrJzN4nfec2xiCHsLmTo6kpodE
        5a31I8KXsLNNEXS0FTtG8Yr7rXxKkvKNNq2Oo9iLi4JQCLZI9/QfIWMUWEhXAOMU
        QSMFG2YxygJiDPG4Cq+5px9Q7RcT73//0wrrI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C5AF4B83C;
        Thu,  3 Nov 2016 11:32:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17C2F4B83B;
        Thu,  3 Nov 2016 11:32:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Help with vger's rules, was Re: [ANNOUNCE] Git for Windows 2.10.2
References: <alpine.DEB.2.20.1611022158140.3108@virtualbox>
        <alpine.DEB.2.20.1611031554100.3108@virtualbox>
Date:   Thu, 03 Nov 2016 08:32:17 -0700
In-Reply-To: <alpine.DEB.2.20.1611031554100.3108@virtualbox> (Johannes
        Schindelin's message of "Thu, 3 Nov 2016 16:15:05 +0100 (CET)")
Message-ID: <xmqqpomcefzy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B4E3527E-A1DA-11E6-B3A0-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> thinking that I could turn out for the night with a well-deserved drink=
, I
> got this from vger.kernel.org:
>
> -- snip --
> SMTP error from remote server for TEXT command, host: vger.kernel.org (=
209.132.180.67) reason: 550 5.7.1 Content-Policy reject msg: Wrong MIME l=
abeling on 8-bit character texts.
> -- snap --
>
> Is there *anybody* who could give me a clue what this means?

Have you tried postmaster (at vger.kernel.org)?

>
> For the record, I tried to use `git send-email` to send out the
> announcement for the very first time, and the headers of the mbox file =
I
> fed to that command read thusly:
>
> -- snip --
> From 2.10.2.windows.1 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Wed, 02 Nov 2016 21:43:54 +0100
> To: git-for-windows@googlegroups.com, git@vger.kernel.org
> Subject: [ANNOUNCE] Git for Windows 2.10.2
> Content-Type: text/plain; charset=3DUTF-8
> Fcc: Sent
> -- snap --
>
> The only problem I could *possibly* imagine is this UTF-8 bullet charac=
ter
> used in the enumerations in the mail body:
>
> 	 =E2=80=A2 [...]

The above header you showed says "Content-type: text/plain;
charset=3DUTF-8" and I am hoping that this response to you will go out
with that labelling back to vger, so we will hopefully see if that
bullet is the culprit (I doubt it, though).  I have no specific
suspect at this point yet, other than "somebody that gets your
message from send-email and passes to vger may be mangling it".

