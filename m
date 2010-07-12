From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add configuration variable for --autosquash option of
 interactive rebase
Date: Sun, 11 Jul 2010 22:55:55 -0700
Message-ID: <7vk4p1fdlg.fsf@alter.siamese.dyndns.org>
References: <20100709124659.GA17559@book.hvoigt.net>
 <m27hl4zg99.fsf@igel.home> <20100710091517.GA27323@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jul 12 07:56:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYBzz-0006fn-8r
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 07:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab0GLF4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 01:56:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab0GLF4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 01:56:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 518C4C3579;
	Mon, 12 Jul 2010 01:56:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ue2o7bP5nxNIq9zvouHxRs7oiSk=; b=qMPwLE
	fSevoYBazhGWqyHgj0ISYdTYNjQyhyZq60yGSMEs77dYJ0swkogM9ukPVNrbDpsn
	IhONN9gfyoywkhthnEVv6BbXa8+dSmgNrloOXuY3cX0SEHmhrDKO9rHjpm1q89DQ
	e4wbUJz3vz9IlQ6Y0eGO65CejaxP/RDSCh1Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PdMGslBQWa5xrPwBOA4cxYZjjNYrl2x4
	jYEczKS1rvC3/61P4qTUCX+oB79SY521Sf3iQzWzikk4uAuDdvu4VlQaEHpFeqO5
	/XurCBWLSCi40r6sRzsmOLw424IOya/gkIVJZ38nxblX0schcc8ZgqZFZL59E269
	OCte6M3Jkj0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DB51C3578;
	Mon, 12 Jul 2010 01:56:02 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D131C3577; Mon, 12 Jul
 2010 01:55:58 -0400 (EDT)
In-Reply-To: <20100710091517.GA27323@book.hvoigt.net> (Heiko Voigt's message
 of "Sat\, 10 Jul 2010 11\:15\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 26CD2706-8D7A-11DF-82AC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150793>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> If you use this feature regularly you can now enable it by default.

And if you use this often _but_ you sometimes need to countermand from the
command line, do you provide a way to do so (I didn't bother to check).
