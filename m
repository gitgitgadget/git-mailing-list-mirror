From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/15] Mark "init", "clone", and "add" output for
 translation
Date: Mon, 21 Feb 2011 23:36:38 -0800
Message-ID: <7v1v30frll.fsf@alter.siamese.dyndns.org>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie> <20110221101229.GA32137@elie>
 <AANLkTikDnfUb6oCP8q7XrAqKan5GcPhyRnag2vW2ZDXW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 08:36:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prmno-0003PG-3w
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 08:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab1BVHgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 02:36:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab1BVHgs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 02:36:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA0022B6F;
	Tue, 22 Feb 2011 02:37:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FsTjkrTLAEgP
	8X+veCzw4NB5jrM=; b=Q54Dhy4P2zvPaSJ2YRCKWMulCNdY/RfgwdkMghwFQKpz
	j1viALzGx5rllUC7WmBdxHKV3oizkSSE+N4SI/daiuE7CW7zz5WRMje+wHa7hopR
	HXSZLAuLr+soqRVPsOOykesItJGi+j/cL89hNs0t9nuP4Rpex5EWJpNdNXTJK1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wn206L
	a0U3FdRKgnHzcfiMVTXBiAX0F+nNQNdYBEgNV/Va0bDqEtmDy+dOWmNR7CX0j48U
	Gykxcy8dct+MmAYXwTiWLRKoa1iYhxnlbU48j1flwTkXjPXY9Gf9gkttPWHL2gQD
	bmI4fNvmG3TyUgnZ8M93lB2i6EYuVXUVwwmhQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B872F2B6E;
	Tue, 22 Feb 2011 02:37:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F0702B6D; Tue, 22 Feb 2011
 02:37:52 -0500 (EST)
In-Reply-To: <AANLkTikDnfUb6oCP8q7XrAqKan5GcPhyRnag2vW2ZDXW@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 21 Feb
 2011 13\:38\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA589CF8-3E56-11E0-AD62-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167531>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Feb 21, 2011 at 11:12, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> Please feel free to try it out, complain, ack, send patches, and so
>> on.
>
> Thanks a lot for taking this on.

I compared this miniseries with the early part of your original.  It se=
ems
to contain only sane refinements, adding missed markings etc.
