From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bash: Match lightweight tags in prompt
Date: Wed, 01 Dec 2010 11:53:58 -0800
Message-ID: <7vr5e1uv55.fsf@alter.siamese.dyndns.org>
References: <AANLkTinvAnGh6PU2bRrx_uGU81zjVHcFmZWwqpKpjO=1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 20:54:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNskq-0007r7-LA
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803Ab0LATyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:54:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756Ab0LATyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:54:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 923172D5E;
	Wed,  1 Dec 2010 14:54:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aQzaw5/GHmvkuEpV5ihdiT+DfPE=; b=fMR0HI
	E8Xdqgouba5zuyATZslGOhptgvFwtiC9dvsCTMh/fLak05yriMhlCcDao7RrTw8I
	tOAJuKtZVYmqhcG+jIUB9aqbjt0RugnOWjIA04vtJAVXZEXiwIWwSn5xO85MAwdF
	acNvrYgjUvwpe/hNGHJCyamnvnaCLOjiWwP84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TE4JfoyktV/z57id9AVXMe6wZ2D7SO2n
	tu5DHqFXngsV2PJDx79jJJk58xMLOmBAe46lvZ3lTSCSnxQ1uHtmPPwnZbrO/6Db
	RS8OOkYImpRWwrthMocaFEu7OcoxstJGxQhoaSyUWxZ8v9Mq0/PR6lgGibmhaYWI
	s5dUQztoA+Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59CA12D53;
	Wed,  1 Dec 2010 14:54:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4003E2D52; Wed,  1 Dec 2010
 14:54:18 -0500 (EST)
In-Reply-To: <AANLkTinvAnGh6PU2bRrx_uGU81zjVHcFmZWwqpKpjO=1@mail.gmail.com>
 (knittl's message of "Wed\, 1 Dec 2010 14\:17\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB55793E-FD84-11DF-AE7C-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162590>

knittl <knittl89@googlemail.com> writes:

> From 6be63c5bc1a411a13a012a6508a7301bed7faec6 Mon Sep 17 00:00:00 2001
> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> Date: Fri, 19 Nov 2010 16:40:02 +0100
> Subject: [PATCH] bash: Match lightweight tags in prompt

Please drop these lines next time, so that I do not have to remove them in
my editor before applying.

> the bash prompt would display a commit's SHA1 when having checked out a
> lightweight tag.  provide `--tags` to `git describe` in the completion
> script, so it will display lightweight tag names (as it already does for
> annotated tags)

Hmph.  Is your Shift-key broken (probably not, as you spelled SHA in
capital)?

> Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> ---
> version two of my patch, adding the missing s-o-b and extending commit message
>
> the diff is still the same as v1

Thanks; will apply (no need for resend).
