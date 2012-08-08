From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] update "make check-docs"
Date: Wed, 08 Aug 2012 12:13:11 -0700
Message-ID: <7v1ujhtcxk.fsf@alter.siamese.dyndns.org>
References: <1344412707-22356-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vmx25tj5y.fsf@alter.siamese.dyndns.org>
 <20120808183132.GA24550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:13:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzBh1-0000hW-Vy
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 21:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895Ab2HHTNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 15:13:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758389Ab2HHTNO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 15:13:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E624793A1;
	Wed,  8 Aug 2012 15:13:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5k7BO8UZ0xDvrAJgVU0uGHLauQU=; b=IBKakF
	W+ePKyXUiGQqxwKOALH39/huugah6+9+dHFIrT+7PlYuswko0VtFEZjAC5/OYCuS
	9BQQ2Y4BJ9rFSDkvaAgys6uMHtRQday0P5vsmxX7ckvP1Vbe1q8sOYuSmSHL4RuH
	GbyNeo/1Ccw40DsrfsOiz0IRsCAImDM4yXaC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJBNowgoV5crOOtbGMkKD1F9p9ttVIBs
	9P1UCoH8PzBjCNq4LWXR0fhIC1ZyBiyIIdBq7NTsJKc3fl84w5slKU8xxDrfogcC
	KeHFBKvLKY2/F7UTyB3QlrCVsUZuT6yT0Mw6M4FV2amYsSKU2C+SvsGkmgv7fksh
	FPlJ2N6KvpQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D507393A0;
	Wed,  8 Aug 2012 15:13:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 525FF939F; Wed,  8 Aug 2012
 15:13:13 -0400 (EDT)
In-Reply-To: <20120808183132.GA24550@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 8 Aug 2012 14:31:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1991CD1C-E18D-11E1-9CE7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203115>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 08, 2012 at 09:58:33AM -0700, Junio C Hamano wrote:
>
>> There really should be an easier way for the maintainer to notice
>> this kind of glitch without being told (better yet, the submitter of
>> a new command to notice it).  Perhaps the check-docs target in the
>> Makefile needs some updating?
>
> Hmm. We have a check-docs command? :)

Yes, and there also is a check-builtins target.  Perhaps the default
build target should depend on them, as they are fairly lightweight?

> This patch series at least brings that up to date. It goes on top of
> Matthieu's patch.
>
>   [1/4]: check-docs: mention gitweb specially
>   [2/4]: check-docs: update non-command documentation list
>   [3/4]: command-list: add git-sh-i18n
>   [4/4]: command-list: mention git-credential-* helpers

Thanks.
