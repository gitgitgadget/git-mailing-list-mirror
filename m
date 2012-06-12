From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Tue, 12 Jun 2012 09:08:10 -0700
Message-ID: <7vsje0jyxh.fsf@alter.siamese.dyndns.org>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
 <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
 <CABPQNSY=X8HG__vcEncdcgjT4fvqaC1gX_5_QH4n0+bX0tNT6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vfr@lyx.org, git@vger.kernel.org, Jeff King <peff@peff.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 12 18:08:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeTdh-0004ZB-M5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 18:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab2FLQIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 12:08:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab2FLQIM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 12:08:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0D288945;
	Tue, 12 Jun 2012 12:08:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8fOm6xAQXKT9eWXQiu7ItVld/JA=; b=vLl0aO
	NWuyRqm4pa2lg1Cv+fJAe2nZjv+Mhs6Kpnjc9nTAGsiZYAhVzKtN/yvB7uR50nQx
	gSNQPf9WjQxzv93gm+imXzj9gGQoDGSll4eajXKtNPaIPB6FxxN02mI4/GmM9bMR
	8ePgmmSlHw2Erxw4MmWPb2+BYiKoTuvA844to=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g1ntQuilledgUv4v/9OriilC1yTP4a+p
	feoIm77W9zex9J6opR4GxmrTaagf/qkngQ68ELDGgbZVebAi14pTRnL5d5Klz59/
	wKtLBewSprFZSAN8C1v3Yu++G4gVwKjGRrmLsFIDv4AGxRhRczdJNakvrhKWlCF9
	4yll603CF7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D53D68944;
	Tue, 12 Jun 2012 12:08:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63B7F893F; Tue, 12 Jun 2012
 12:08:11 -0400 (EDT)
In-Reply-To: <CABPQNSY=X8HG__vcEncdcgjT4fvqaC1gX_5_QH4n0+bX0tNT6g@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 12 Jun 2012 17:36:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEC2E462-B4A8-11E1-A735-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199807>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Having an MSYS version of Perl in PATH is "broken" in the Windows
> world, so it's THIS Perl that people might want to keep out of their
> PATH.

Fair enough.  After all, that is why we have $PERL_PATH that can be
used (and is used) in our Porcelain scripts.
