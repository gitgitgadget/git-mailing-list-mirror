From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] grep: add a perlRegexp configuration option
Date: Tue, 31 Jul 2012 13:30:05 -0700
Message-ID: <7vboivishe.fsf@alter.siamese.dyndns.org>
References: <1343753854-66765-1-git-send-email-dark.panda@gmail.com>
 <7vehnrkdrq.fsf@alter.siamese.dyndns.org>
 <CADFUPgfHQCzdnXfby5b+z-pRkt5o6MAVEf_1waWER3iVtM1TZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: J Smith <dark.panda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 22:30:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwJ55-0004gM-PX
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 22:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab2GaUaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 16:30:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab2GaUaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 16:30:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96EEA9B7A;
	Tue, 31 Jul 2012 16:30:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Xl8EsurtFNTamU2thxJOj3AxI8=; b=grHCCy
	XC3fK5b2UYU7XADnRgq2vWmp8V6kgoFT01E56NcaxV5C6WFAMUO6Gbg0IBitAZRg
	STy9y2anMsRX1j+S/kI/MBQwgDXsOcp7oFE7q0ywnKhcH8FDQzcc0KOtKdoivsyI
	Iij8Rj1YIsSGuq/4ICQtwoVrdf40O/1ZbRpzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F2KQRxq6UWJ+Q6NinlZ1PcrdRdP9sWAm
	Lud5l8GxQf/jgQ2gsQ0rVL+0PciSb3ryY9VLfj9V3yxbnjjHvI/tYSNrTJu4bgKc
	TeT6qREB/9BLOCYwBEIQj7jXkJMBAUKtCq2W5Cfjmh4BvYd3ZbAoj5RWyiZGECVe
	bOqT3trvoIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83FD39B79;
	Tue, 31 Jul 2012 16:30:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 051E99B77; Tue, 31 Jul 2012
 16:30:06 -0400 (EDT)
In-Reply-To: <CADFUPgfHQCzdnXfby5b+z-pRkt5o6MAVEf_1waWER3iVtM1TZA@mail.gmail.com> (J.
 Smith's message of "Tue, 31 Jul 2012 16:20:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 843C1F18-DB4E-11E1-A08A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202684>

J Smith <dark.panda@gmail.com> writes:

> ... For the sake of completeness (verbosity? pedantry?) I also
> included a setting for "extended" which is equivalent to true.

Good thinking.

> With this sort of change, would a more generic "grep.regexpMode",
> "grep.patternType" or something similar perhaps be more descriptive,
> with "grep.extendedRegexp" being aliased for backwards compatibility
> purposes? I could also add that functionality if desired.

A variable called "extendedRegexp" already reads quite naturally if
it can have value to say what kind of extendedness is desired, at
least to me.  So I do not care too deeply either way.
