Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4736A2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 15:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbcF1PUC (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 11:20:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944AbcF1PUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 11:20:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 758C4237D5;
	Tue, 28 Jun 2016 11:19:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/iqFzgjoKJju3mA1xbHYRNZZmFc=; b=eu1fLK
	jh5i+CYrM3PIJGRmB9hnHDAlAc3040sdQ2QqAV7auMJKIomqbx1VE8NMzhcVR8WR
	oDqrJQV0F//xPGvh4UjBlScjgId8r2kAJDDo7YlStnMXMUpkxtmVUKdkyrZKn5+3
	8X/FIGqOZ99cD38swOCS5+Qi3hd/JccsRmB5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fI4/gZinK2vW+wVmnmjyVqVhcseDH3U6
	JrSmew3b3Hkh8Hq+ekpK+cfE3JvmjqgB+LgQidZiteN5s/5RaR6uMNaidYkkMf6p
	KBZoTpURhGi7cgjS+yYXxtOjiEBvOb940uy0nsk6PkjmXd+E5Hkz5SED211cS+H5
	5vARLnf5VVo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D66A237D4;
	Tue, 28 Jun 2016 11:19:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4501237D1;
	Tue, 28 Jun 2016 11:19:48 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/6] doc: typeset long command-line options as literal
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
	<20160627174623.11084-2-Matthieu.Moy@imag.fr>
	<20160627190422.GC9594@sigill.intra.peff.net>
	<vpqr3bhzqej.fsf@anie.imag.fr>
Date:	Tue, 28 Jun 2016 08:19:46 -0700
In-Reply-To: <vpqr3bhzqej.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	28 Jun 2016 10:08:52 +0200")
Message-ID: <xmqqmvm59w8d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0E0B036-3D43-11E6-915D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Sorry, I forgot to mention when sending the series: this is to be
> applied on top of tr/doc-tt (in next, marked "will merge to master").

Yup, I figured it out and these are queued there.  tr/doc-tt is part
of 'master' now.
