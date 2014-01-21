From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work -> relnotes
Date: Tue, 21 Jan 2014 15:28:09 -0800
Message-ID: <xmqqob34synq.fsf@gitster.dls.corp.google.com>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
	<xmqqppo090m7.fsf@gitster.dls.corp.google.com>
	<52CFACBB.7000805@atlas-elektronik.com>
	<F11CD558C63947F9B4AA75501D2F9F62@PhilipOakley>
	<52D91B0E.6080000@atlas-elektronik.com>
	<BA4E87FA92ED4E8FB2C00F013BD7B3FF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	"GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 00:28:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kk0-0005H1-43
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaAUX2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:28:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56373 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaAUX2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:28:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 054FE660FD;
	Tue, 21 Jan 2014 18:28:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TwQoyy03pZPrxv/+dkR2bv4q3HQ=; b=o81wB+
	PwBYNsCj1c8V1MySIIBiKlH6G9Qtc2uc3mZYXv+UcjcyxcfCQPze1s8hqrO/6D/7
	niKR3aBAHn1YxXD30sC09sSg1+3a68JSTsxMphACDcQWlyXY8nal9NKmAyEqOOXX
	MXhl9Ng6eswQk1/Ks53QzRgD03eaCjbCMG40c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RKJrJhRNMPdqzSl5vja7QwIpTZqfDT63
	zPmCax2ZjaO5iiQkYRGAvVnKhK+F36+n1wiYH1BO3YpEP1X9rTNfHY8rxOEIUiNO
	22LLvjGDLxax/8gs8U7OFpttomS4IchodoGtjHBdAW4te7dD4q/moa9aYz9Hvwsm
	wn3iAHu8xW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD7AA660FC;
	Tue, 21 Jan 2014 18:28:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AB87660FA;
	Tue, 21 Jan 2014 18:28:13 -0500 (EST)
In-Reply-To: <BA4E87FA92ED4E8FB2C00F013BD7B3FF@PhilipOakley> (Philip Oakley's
	message of "Tue, 21 Jan 2014 22:25:26 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B2875114-82F3-11E3-8D3E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240803>

"Philip Oakley" <philipoakley@iee.org> writes:

> Determining which is the current release note is possibly more 
> problematic, which should be when making the documentation.

Hmmm.... Why?

You are already aware of the stale-notes section, no?  Isn't the top
one the latest?
