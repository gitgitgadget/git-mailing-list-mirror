From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Specify UK English for the documentation source files.
Date: Tue, 30 Jul 2013 09:40:57 -0700
Message-ID: <7vppu0vw4m.fsf@alter.siamese.dyndns.org>
References: <51F7D2FA.7020208@xiplink.com>
	<1375197114-10742-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 18:41:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Cyx-0003hC-2k
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 18:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab3G3QlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 12:41:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38135 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220Ab3G3QlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 12:41:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4AB5349AB;
	Tue, 30 Jul 2013 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sVgAJ6Eue/NWqe/MNqHg/A/LqOY=; b=mnnk+U
	SbCsbvqzOxGjrWCRbMez2B2NIcWDV0Q+Ct67OUDQPk7PqYUcZn0N3I/qq/dTwpaU
	XMb1J4A4yGDAjYgNU2ECpkXEabvTwjOkkeNBSCNP+/jEEomTZYCfapYVoidNo27m
	J5PY9fmDtgf17q1KSato5tRPqhKBXKjHTHfZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z3l3du1PLs4CmBRnTYt8IgcY+bTYB6/K
	kF+3TGljDQYmeqYmZ3WbC/48eYGN8MkMerHpv2GM658h6sX+DVMF7/nab2+6YOMN
	6V/TckZVDMBqLRHFMYF8Lpw9QpExKCGy8qV0vnDnsMoFn3RAaMjIVpbU3aGoKo5T
	q2h6brYi/+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99857349AA;
	Tue, 30 Jul 2013 16:40:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBABC349A5;
	Tue, 30 Jul 2013 16:40:58 +0000 (UTC)
In-Reply-To: <1375197114-10742-1-git-send-email-marcnarc@xiplink.com> (Marc
	Branchaud's message of "Tue, 30 Jul 2013 11:11:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0149436-F936-11E2-9500-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231372>

Marc Branchaud <marcnarc@xiplink.com> writes:

> This will hopefully avoid questions over which spelling and grammar should
> be used.  Translators are of course free to create localizations for other
> English dialects.
>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>
> Although I'm Canadian I figured en_CA would be a little too parochial.  I
> don't have a strong preference for en_UK over en_US though.

If we were to specify one, I would have to say we should standardise
on en_US.  Like it or not, that is the lingua franca in the CS world
(I'd also admit that most of the extra 'u' in words like "behaviour"
are my typoes, not even coming from a conscious decision to choose
en_UK).

I'd appreciate "typofix" patches to address genuine typoes like
"s/filesytem/filesystem/" done separately, so that we do not even
have to get into language bikeshedding.  Even if we did decide to
stick to en_US, the typofix patches and en_US patches should be
separate to ease reviews.
