From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] commit: reword --author error message
Date: Mon, 26 Jan 2015 18:43:46 -0800
Message-ID: <xmqqlhkplz8d.fsf@gitster.dls.corp.google.com>
References: <xmqqfvba1p07.fsf@gitster.dls.corp.google.com>
	<7e2e1d1e7f4a25d84a6f7a1c0cb035221529f189.1422286879.git.git@drmicha.warpmail.net>
	<20150126190711.GA13582@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 03:44:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFw93-0001Po-7u
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 03:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbbA0Coq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 21:44:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752548AbbA0Coo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 21:44:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F3BC32CDA;
	Mon, 26 Jan 2015 21:44:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ebH43i12WjVnbPtnbworJyaNjwk=; b=AlFnh2
	NKEKOXMIq31/uKvGeq3bsdmDV55fxjwd9YJdsVn8hE0WO2K2QbqGNoPhB8R114fd
	oUqSX1tu+M1DkaGqjhIjQP0+5afma9GGWfeoTttrDADbRvix8VsjrL4fjJP2Jod5
	4byvyGD6Di20eLRY6ks0XoGNpYIvcwJWu7wsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=voROci2sp6zygRGqlGHJrrvKOL//iF8M
	MPPsk/4RVn6+DN732dYFLe/VHmTzl0lDpj7DJ0I474qLkvyiq/g6zJBbV6A8N2U5
	5Yp7P6zz6BUQNN3LxKBhU/FucFFbc8dwvIeju1Kh3kieJZw49Pj49UtDcBY6S9F/
	rKLRkk/sBpQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94AAB32CD9;
	Mon, 26 Jan 2015 21:44:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52E4732CA6;
	Mon, 26 Jan 2015 21:43:47 -0500 (EST)
In-Reply-To: <20150126190711.GA13582@peff.net> (Jeff King's message of "Mon,
	26 Jan 2015 14:07:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 514896B6-A5CE-11E4-B27C-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263053>

Jeff King <peff@peff.net> writes:

> ... I somehow had trouble making
> sense of Z ("a match...") as a noun.

> I wonder if adding back in the missing verb, rather than a colon, would
> also make more sense:
>
>   --author '%s' is neither 'Name <email>' nor a match for an existing author

Then

>   --author '%s' is not 'Name <email>' and matches no existing author

would be the shortest, sweetest and hopefully grammatical, perhaps?
