From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] pickaxe: honor -i when used with -S and --pickaxe-regex; cleanups
Date: Mon, 24 Mar 2014 11:19:28 -0700
Message-ID: <xmqqlhvzqx1r.fsf@gitster.dls.corp.google.com>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:19:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS9TE-0001sR-G2
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 19:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbaCXSTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 14:19:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43042 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbaCXSTb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 14:19:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B0D0744C0;
	Mon, 24 Mar 2014 14:19:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lYMdaeGN2RwZ
	GQH5V5T+KF4BSlo=; b=B5MoC63PeMxAYqfG4eddVEHkwGl87Ujts32dpM6F2o5t
	VVWfqZ+NZT7Zd6ZuhmL28/lUEW9jioHCqfGHy1qRw3O9xWfDq/J5VGhMtkoaLXiS
	h5hzf7jCSUafQbY0RIhjra/oX7cFKCHUXZCo3iVKEWCEAC7qTMv+oGQiEcDh6bU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FXQa7d
	4F2NVDE4r9tQQxNiGjccA/5bDCsuCnZ2SvUoxo9bDDlOWTRDW5MOzYMkUSYqCaJ8
	DnfJRodHH2YKH5VnbhzgT4MrSJs1g10qEk7Zlw80bOXVqJ6RlQlCRekR5tDh4Jmr
	n7y6S9Fw3XMzkVNa4tr3ruZmUH+ZNvSGiN8X8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0256B744BF;
	Mon, 24 Mar 2014 14:19:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41026744BC;
	Mon, 24 Mar 2014 14:19:30 -0400 (EDT)
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
 (=?utf-8?Q?=22Ren=C3=A9?=
	Scharfe"'s message of "Sat, 22 Mar 2014 18:15:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D76E2A62-B380-11E3-9583-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244858>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> This series allows the options -i/--regexp-ignore-case, --pickaxe-reg=
ex,
> and -S to be used together and work as expected to perform a pickaxe
> search using case-insensitive regular expression matching.  Its first
> half refactors the test script and extends test coverage a bit while
> we're at it.  The actual change is in the sixth patch.  It enables th=
e
> two following cleanups.  The last two patches are independent simple
> cleanups.

Very nice.  Thanks.
