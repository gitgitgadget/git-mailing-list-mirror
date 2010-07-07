From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/README: document more test helpers
Date: Tue, 06 Jul 2010 21:25:21 -0700
Message-ID: <7v630r5366.fsf@alter.siamese.dyndns.org>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
 <20100702192102.GA6585@burratino>
 <AANLkTilI0NZiDk3I850x28pr5I0sYRiPLW7HAST9sduU@mail.gmail.com>
 <m3wrtdm1y9.fsf@localhost.localdomain> <20100706200410.GA7606@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nazri Ramliy <ayiehere@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 06:25:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWMCl-0007XN-D3
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 06:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab0GGEZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 00:25:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab0GGEZq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 00:25:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98A29C2E39;
	Wed,  7 Jul 2010 00:25:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yN05PU8H5XC2FNQGMTfMAKsqimo=; b=c7ww25
	0OGFmwEVMAC7dfEZ2JBUoUpNzvGb4ZV+eLW1q5S4DUF+6GNlppkqlA5BTIT0jzSZ
	BkHfDAQoLwkPqtcX9OKHRbWsDFwVDYuVvfTOqeku5xhPJ6hiLXDr4DMZY+vM/fl2
	Ble+CDsHH2lK8d4YKsfNpEDu7lqyF3cy2Z6w4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YrYEpDpipSBgvpqKOwDsTkNZf/zsCaKD
	wy38dQ7RVaMf2bJPM0WlF5upbfug80oSvPLLzbWOH/hpqYoklSr1sUshzME7jPnx
	4GC/uzlt0AaJbtlZDMow1WTTzqLlowEwwUaKte2BeLJYt765xHNaIIZepL/DSi7S
	YQsx2GCiHOk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F09FEC2E38;
	Wed,  7 Jul 2010 00:25:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D104C2E34; Wed,  7 Jul
 2010 00:25:28 -0400 (EDT)
In-Reply-To: <20100706200410.GA7606@burratino> (Jonathan Nieder's message of
 "Tue\, 6 Jul 2010 15\:04\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B118BFF0-897F-11DF-B273-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150436>

Jonathan Nieder <jrnieder@gmail.com> writes:

> + - test_cmp <expected> <actual>
> +
> +   Check whether the content of the <actual> file matches the
> +   <expected> file.  This behaves like "cmp" but produces more
> +   helpful output.

I'd add '... when the test is run with "-v" option.' at the end.

Otherwise the explanation reads very well.  Thanks.
