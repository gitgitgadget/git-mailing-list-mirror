Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF51D1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 15:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbcHLPsG (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 11:48:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752371AbcHLPsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 11:48:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B453F335D9;
	Fri, 12 Aug 2016 11:48:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kPy62GNDQPHX61c8RClemcmjbmA=; b=DUA+b/
	y47Dm/ePNIVivYJBZyYoGsD7iDe/W/ek2pMxB4OU0t9ier2nhA2eM+9SNQXiTt8h
	bmxe19NOygYAbK7kNEw/7kNiQ3AaKtzKfHoUrAC3bCMNxIiBq3MSPyDqFrGP+HKv
	uA+bZS5fWNU5GPbeNA7W7DPCUvpJ66IkBVKfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TqGX5abJsbkre2YHGXyiibYPVsXw4SOE
	4skHNFKwSm3FlrOY0Jocp0H5phSVVHBMvpD2rtIloJ+rB9+XfW3vEUP4Ju9ZqqVH
	NExrzm/HxgabtFSytSRfghSgM/D/TX4IMPN6ni1fVrbRQj0NvW/vaOs8MG87mgOp
	aNBWR27RTiw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABE95335D8;
	Fri, 12 Aug 2016 11:48:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21F42335D7;
	Fri, 12 Aug 2016 11:48:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joseph Musser <me@jnm2.com>
Cc:	git@vger.kernel.org
Subject: Re: `git stash --help` tries to pull up nonexistent file gitstack.html
References: <CAKRjdd4WdVTgbT0gcR=a267+aEwD2Exztrc9gNau1nOXroC=ng@mail.gmail.com>
Date:	Fri, 12 Aug 2016 08:48:00 -0700
In-Reply-To: <CAKRjdd4WdVTgbT0gcR=a267+aEwD2Exztrc9gNau1nOXroC=ng@mail.gmail.com>
	(Joseph Musser's message of "Thu, 11 Aug 2016 22:00:56 -0400")
Message-ID: <xmqqr39uxa33.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 274B033E-60A4-11E6-8962-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joseph Musser <me@jnm2.com> writes:

> Looks like a simple typo.

Unfortunately this does not reproduce to me (built from source on
Ubuntu Linux).
