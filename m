From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] t/t9001-send-email.sh: get rid of unnecessary backquotes
Date: Fri, 08 Jan 2016 14:37:59 -0800
Message-ID: <xmqq4men1yuw.fsf@gitster.mtv.corp.google.com>
References: <1452251188-12939-1-git-send-email-gitter.spiros@gmail.com>
	<1452251188-12939-11-git-send-email-gitter.spiros@gmail.com>
	<vpqa8ogdsyr.fsf@anie.imag.fr>
	<CA+EOSB=jVho9XCAG0Q3P6dvH6A99b5yB7FcyxkS3DtxupBeoFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 23:38:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHfg7-0001iW-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 23:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbcAHWiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 17:38:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751897AbcAHWiD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 17:38:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E99433B359;
	Fri,  8 Jan 2016 17:38:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iVQEbqg83y3YYips8LgNpTefzw0=; b=AJJxY9
	5MSorT0bGorBVxvsIm7uFzwiUsZm/lAS/N9kwbRxNA8Sq0Wp750yieax9tusiw5C
	406PacxzKWPuRFGlJK25mU1rlpG8pyYr4IDUDl6Kzw8EExv4i+v3n7q4Cwhe3o56
	mW1d/eyfzUp2SX7Q6tdkoFu8lkPjjGxlX7dFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q+zE3ZtLlNoWEIsUpbsbZIK+3fSf8PuN
	TWVdcTBeaDolpUKWaKsly3M5FsHd9xz/Aslab0QhCnaIknu8JWV+kh5nGI+06Efy
	Bw8O4db4gB6XxG4fYltKOLwT5Xhpv68gY+yy8UfxJ/bTAigXEUFoP1+nHc+KGxSU
	QOE1sGfUmJo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2C333B358;
	Fri,  8 Jan 2016 17:38:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2410C3B356;
	Fri,  8 Jan 2016 17:38:01 -0500 (EST)
In-Reply-To: <CA+EOSB=jVho9XCAG0Q3P6dvH6A99b5yB7FcyxkS3DtxupBeoFA@mail.gmail.com>
	(Elia Pinto's message of "Fri, 8 Jan 2016 23:29:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 794451BE-B658-11E5-A1C2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283587>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Thanks for the review. Junio you kindly remove this patch?
>
> Thank you all very much.

Done, and thanks for working on this.  I am guessing that we are
very close to done, seeing that you now reached the t9xxx series?
