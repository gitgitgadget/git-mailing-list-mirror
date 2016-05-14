From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Empty config sections are neither deleted nor reused
Date: Sat, 14 May 2016 10:33:25 -0700
Message-ID: <xmqqfutk8ryy.fsf@gitster.mtv.corp.google.com>
References: <87r3d6knwo.fsf@bernoul.li>
	<xmqqeg95aor6.fsf@gitster.mtv.corp.google.com>
	<877fewzseg.fsf@bernoul.li> <vpq37pk7k08.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonas Bernoulli <jonas@bernoul.li>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat May 14 19:33:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1dRW-0001FV-DL
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 19:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbcENRda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 13:33:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751955AbcENRd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 13:33:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 441EF17F0A;
	Sat, 14 May 2016 13:33:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cHggrNq/mQ9z8j6YxcroZh0UwGQ=; b=vgSAFy
	eBjXVP6YDgmleWxESklUnVHGdM46422n5VqUHVMhnMYW/aDhSbudc5MlJfwUe3eS
	ItygA3HxA6kPtGA7NUdpBIEKUHyyTxjoEhWLVeAEKP5pC6EUbw44zBFdzSYtzDFO
	bwxtg0HsPLAjfckVfDLUgOWq1ecLW7JvwH8NM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f7y6l6cC7jZPSzBFv2l8qs2xU7SOQM7H
	hsn1eVnHsNhbOBZ5wlS5OeOQUmRS/Q798D0XslXwUgHV93axOQsVfT+OkADYNz0K
	Y6LN9DdKxp4IMlcoe89II8fTD+H2+gPVDKhNkRNUb9hRf9DLbCsI24iXacOjlhUZ
	1hcLwXLGnS8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C29417F09;
	Sat, 14 May 2016 13:33:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A23B617F08;
	Sat, 14 May 2016 13:33:27 -0400 (EDT)
In-Reply-To: <vpq37pk7k08.fsf@anie.imag.fr> (Matthieu Moy's message of "Sat,
	14 May 2016 17:10:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7D3F7AA-19F9-11E6-84B2-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294617>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio's explanation must not necessarily be read as "it has to be the
> way it is", but more as "getting it right is harder than you think", and
> that in turn explains why no one changed the behavior.

Thanks for clarification.  s/must not necessarily/must not/;
