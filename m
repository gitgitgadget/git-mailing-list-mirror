From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] send-email: avoid questions when user has an ident
Date: Mon, 26 Nov 2012 11:35:31 -0800
Message-ID: <7vboekrwcc.fsf@alter.siamese.dyndns.org>
References: <1353755779-32548-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:35:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td4T8-0006ae-PT
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 20:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab2KZTff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 14:35:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521Ab2KZTfe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 14:35:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DB7F90CD;
	Mon, 26 Nov 2012 14:35:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xthrfn3Yk1WzvgcuuzrvuaqpyaM=; b=LrHr+k
	7Wr5Mfpb/mxhXd9z7za7PpjLWDIda16CKTQ6THgRQZuWkDwigYvyDZ5D3ya0+aDy
	Nbr3md0+gdj7vUtxrn6lsKvweE7iglQdKQCVRTM7ILcWzBPoeoBCleyH2sZkbeI+
	hQR5D3MY1biAM4JmssYl5YSTRz5UqRqQivD4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CUQCZrtAp6ltRBM4S/2zirOv2CCbXBHC
	1uPP8xptqtm7Ke1pSCgnGtfL+BtnixzRYznvMoA/e1JDkDIgKRy5wocYRgWs4xua
	b/c0z+Z3HsHTP1j3v6Y/sSJe5y5TBSbpsERY2dcTPluIKXPQfjUrgSO1uLTld0+6
	23/7ls0VdR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A60990CC;
	Mon, 26 Nov 2012 14:35:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73B4190CA; Mon, 26 Nov 2012
 14:35:33 -0500 (EST)
In-Reply-To: <1353755779-32548-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat, 24 Nov 2012 12:16:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71CEF986-3800-11E2-AE79-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210474>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> 3) Full name + fqdm
>
>   Who should the emails appear to be from?
>   [Felipe Contreras <felipec@nysa.felipec.org>]
> ...
> This is bad, because we will try with an address such as
> 'felipec@nysa.felipec.org', which is most likely not what the user
> wants, but the user will get warned by default (confirm=auto), and
> if not, most likely the sending won't work, which the user would
> readily note and fix.

OK, sounds sensible.

> Changes since v2:
>
>  * Merge the relevant tests by Jeff King (the rest of the tests might be
>    useful, but they belong in a separate patch series)

Thanks. Queued.
