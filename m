From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] gitweb: Return plain booleans in validation methods
Date: Thu, 05 Dec 2013 12:01:55 -0800
Message-ID: <xmqqob4v3w3w.fsf@gitster.dls.corp.google.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	<1386164583-14109-4-git-send-email-krzesimir@endocode.com>
	<CANQwDweGgQpnqDqaekBWt-rczjHkJEmFyXW9qDh2En2r=ZXbMw@mail.gmail.com>
	<1386235422.2186.7.camel@localhost.localdomain>
	<xmqq61r3i2ol.fsf@gitster.dls.corp.google.com>
	<CANQwDwdw6MQW2wWvL=GmwYeDKF-gikNx55QdYH2oD50ZZUcPRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 21:02:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vof7a-0004HD-Ub
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 21:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab3LEUB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 15:01:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab3LEUB6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Dec 2013 15:01:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C2A4586F4;
	Thu,  5 Dec 2013 15:01:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HWdtN1lkI7o1
	ryAF284vW8741Ms=; b=fC5LmzF4GXgp7YZmTtEb6B6Tt2dID7oJGysG58Ayewd3
	r1UvkfwMA4bY/V/1gm1j6WGlbZAhgsvtzrAgS7YixnUOIWea4HyYCE6C5rLG/UQC
	5yd5+L2HPFCS7FKEnasWtgsQlyUOq30FufGAIAukO6V3xUu2jwgoKC1dcCm1Lao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nn+XKO
	oROClQePFqFyeeDzP5SVwawUAASPDLrC6UIPzfbrR2PK1jg+fcj0wCprvEZxK8t4
	sqiIpO4i729ik1q3jxzPg3f8Dx9wviaiFuKLT+bnt0j/x5Kdjf4z3wvlYz6HewWj
	IFfZ7WN3Mp7h6YmySs6+8IiPVhWpEfPqogyfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A554586F2;
	Thu,  5 Dec 2013 15:01:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D8E6586F0;
	Thu,  5 Dec 2013 15:01:57 -0500 (EST)
In-Reply-To: <CANQwDwdw6MQW2wWvL=GmwYeDKF-gikNx55QdYH2oD50ZZUcPRw@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Thu, 5 Dec 2013 20:11:23
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 185525BA-5DE8-11E3-9057-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238905>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> But I am not against "return 0;" on validation error (would putting
> it in separate patch make review easier, or just pointlessly prolifer=
ate
> patches?).

OK.
