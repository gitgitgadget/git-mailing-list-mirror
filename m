From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Sun, 08 May 2016 11:48:31 -0700
Message-ID: <xmqqy47kxu68.fsf@gitster.mtv.corp.google.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQO3W4WthHstrVFWziU2RAuNyEzeQwBEyDXG8dghRjECQ@mail.gmail.com>
	<20160506162058.Horde.toAFyoD2uVNcv2x2Ssx_9zt@webmail.informatik.kit.edu>
	<xmqqshxv5hhg.fsf@gitster.mtv.corp.google.com>
	<20160507053209.GA1704@sigill.intra.peff.net>
	<CACBZZX5FHBG8xXc4wKUyW90FianJB1PT2FyByqYVqccb2ef2eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 20:48:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azTkt-00026k-1w
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 20:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbcEHSsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 14:48:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750880AbcEHSse convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2016 14:48:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6374182B8;
	Sun,  8 May 2016 14:48:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=F8pfRA3sInsq
	7R0j7FkmVuLP4Vk=; b=WsjiHUpu5HB9q8D7AakCTpEYZAdSMAvRo+DKRCyd51se
	AvBewQfaLtTKS6QE38azOSzc41ninQw/TwzNB+FEyPsi4r3u7jLsCmsxo4QEOngE
	ChUlBCnrXMkyNENyDyDX0n0w6dhhpYV6UyzAShUJc68B/BghMNIEEaNykHjOwLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dH+tdE
	pSUT0PQmrzBLlcHE1TWMa91T7uRNOW/O2ffCCjxx2to4d2EOc7kC2no0PKrnRwAN
	Up6XaFQ11ICT2G06ar2uxifa3Fq2u8L1EcGdIn53RqJ1Jsikpnmsjyt+Al384bI9
	egYP+YZJAWyzl0CirEpSkEu4MPM9IDGDc49wQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CCAF182B6;
	Sun,  8 May 2016 14:48:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FE4A182B5;
	Sun,  8 May 2016 14:48:33 -0400 (EDT)
In-Reply-To: <CACBZZX5FHBG8xXc4wKUyW90FianJB1PT2FyByqYVqccb2ef2eg@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 7 May
 2016 21:28:53
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76D07904-154D-11E6-B477-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293976>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I.e. I really expect --verbose to be a more verbose version of the
> primary thing a command is doing, which in the case of "commit
> --amend" is giving me info I need to modify the commit.

That summarises what I wanted to say very well.  Thanks.
