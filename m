From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] add configuration variable for --autosquash option of
 interactive rebase
Date: Tue, 13 Jul 2010 09:08:49 -0700
Message-ID: <7vlj9f4b5a.fsf@alter.siamese.dyndns.org>
References: <20100709124659.GA17559@book.hvoigt.net>
 <m27hl4zg99.fsf@igel.home> <20100710091517.GA27323@book.hvoigt.net>
 <7vk4p1fdlg.fsf@alter.siamese.dyndns.org>
 <20100713112316.GA758@book.hvoigt.net>
 <AANLkTilFOOK1eXkzWJXlr3zf78xZ82nIK9Jrr1END3-Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jul 13 18:09:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYi35-0007Rb-5g
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 18:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756997Ab0GMQJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 12:09:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab0GMQJE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 12:09:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0E38C2418;
	Tue, 13 Jul 2010 12:09:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xvZf/y6skAPg
	yCuc+gh6E8baLr4=; b=e/tk8ChLhgxu+B/gLKRtIM4io8O+p4AL/Fx3omxO9n+U
	e0Y1766t7kQQ34yfjBO5bXhmW9sn+reUZbccPG7cX8BgOxPrWvo7wiLW7cQvJ1We
	mxMvQYc+rdAKyXB7zgZt6NRBbseTI9HQRcTbLOpowEPlMnkBkTftra4gxosQxLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N+6VA8
	z4JUDcqSR8yjxO3VjHnE5b/dDiLsmDgEOsxOzMHiPdlwIvR6ZvX5GF9vrc7XOCxt
	29/mSh9m9x8EU/sECJvYcVw/i0vT4TZJ4pZySiNdPrhxalJi2cnkVO+dmFvO5XMu
	leXYOOJusofEH0ZVncgMbUevbXMAmB7JtOkg0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67700C2417;
	Tue, 13 Jul 2010 12:08:56 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 848EEC2413; Tue, 13 Jul
 2010 12:08:51 -0400 (EDT)
In-Reply-To: <AANLkTilFOOK1eXkzWJXlr3zf78xZ82nIK9Jrr1END3-Y@mail.gmail.com>
 ("Santi =?utf-8?Q?B=C3=A9jar=22's?= message of "Tue\, 13 Jul 2010 14\:34\:54
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F06834E2-8E98-11DF-B502-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150904>

Santi B=C3=A9jar <santi@agolina.net> writes:

> You could also merge this entry with the --autosquash as with --squas=
h
> option in git-pull(1):
>
> --autosquash::
> --noautosquash::
> [original text]
> +
> If the '--autosquash' option is enabled by default using the
> configuration variable `rebase.autosquash` this option can be
> used to override and disable this setting.

Thanks for the suggestion; that probably reads better.
