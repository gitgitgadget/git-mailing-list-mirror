Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A906920281
	for <e@80x24.org>; Tue, 31 Oct 2017 05:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbdJaFXw (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 01:23:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63459 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753094AbdJaFXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 01:23:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 879D0AB0A8;
        Tue, 31 Oct 2017 01:23:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=a2xnf4ey628l65KI4XiLL8blT
        zs=; b=AsrFR5i1nqOnG9b4P1UYzlfOQg2zD2a9yG8IA2UsaLg9TYRgyscbPz1aK
        iSNSggNrCr2aYTnT3yl/xl+cj0Crv0ajjWplSA1N9a3EmoPBFNSJ4G8oI/FJ3p5r
        WEnAqaukai/8s9gfWZUPxSYdMWTiv2GqBg4AHsZrGL550Q6x00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=Nrw5lCyobcqTpKcZBHe
        9N9fXBO6QUxKcFCx8UAOLZmC/ax3ZN0e9fDdzGkvSPQJkP8W9hz8TjwcBhaVB0VY
        QJvNosNPa0VAsdhrLzOT61QH+ZoGESFHsLLTRbBLut2I8VniYQlWSH+L2bb234uZ
        QJRPL5ac9jmv0Qi5c30ShFjU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F730AB0A7;
        Tue, 31 Oct 2017 01:23:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC070AB0A6;
        Tue, 31 Oct 2017 01:23:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org
Subject: Re: future of the mediawiki extension?
References: <87vaix731f.fsf@curie.anarc.at>
        <q7h9o9opyllo.fsf@orange.lip.ens-lyon.fr>
        <87mv487rc6.fsf@curie.anarc.at>
Date:   Tue, 31 Oct 2017 14:23:49 +0900
Message-ID: <xmqqh8uf28m2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ADE25DBA-BDFB-11E7-BF52-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupr=C3=A9 <anarcat@debian.org> writes:

> On 2017-10-30 11:29:55, Matthieu Moy wrote:
>>> It should also be mentioned that this contrib isn't very active: I'm =
not
>>> part of the GitHub organization, yet I'm probably the one that's been
>>> the most active with patches in the last year (and I wasn't very acti=
ve
>>> at all).
>>
>> FYI, I'm no longer using Mediawiki as much as I did, and I don't reall=
y
>> use Git-Mediawiki anymore.
>>
>> The main blocking point to revive Git-Mediawiki is to find a new
>> maintainer (https://github.com/Git-Mediawiki/Git-Mediawiki/issues/33).=
 I
>> believe I just found one ;-).
>
> Eh. I assume you mean me here. As I hinted at in another thread, I am
> not sure I can commit to leading the project - just scratching an
> itch. But I may be able to review pull requests and make some releases
> from time to time... I probably won't work on code or features I don't
> need unless someone funds my work or something. ;)
>
> We'll see where the community takes us, I guess... Always better to hav=
e
> more than one maintainer, anyways, just for the bus factor... Worst
> case, I'll delegate to a worthy successor. :)

Heh, when you are talking about going from effectively 0 to 1 (or a
halftime), you are way too early to worry about the bus factor ;-)

