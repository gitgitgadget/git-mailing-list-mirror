From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv20 00/12] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 12:50:07 -0800
Message-ID: <xmqq60x79r7k.fsf@gitster.mtv.corp.google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
	<20160229193222.GX28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, pclouds@gmail.com,
	git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 21:50:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaUmF-0000AF-Qs
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 21:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbcB2Uum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 15:50:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752610AbcB2Uul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 15:50:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D162047B44;
	Mon, 29 Feb 2016 15:50:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DtrgXg9XiED580Hja9Y/lPBowRM=; b=DCz7YA
	tRqORUgvu1rBRQ3nL5D4kaACpc1TtM+VdNIYcpqt/+6G2rXzhjmf9T5KS7mSZTsV
	5RAHIEzMCmerq5KCE64w2zk4OoXs7Zerj3ezRQj02sl0x+v70SECL3+DlnfSnZY4
	GI2B7hCMlyS8ihb31sj2JCw7kkaI5lRLfBdYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iRK8pxG7yNIMIXNzNDguwkhUZlISkq2x
	a9uHxaYz5vAtRcxLZv/GHUvSQTzo9hoRd/7NC7WzvRWaxXsZ8dasiUKNzOOZlkFK
	S4XrhhAfR0M5FdFUvcV8IS261+QC4+7O7UgWhyPFuGkAm8qDLiZyrEqoTkoI7LKP
	cWOMBRbXkJU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF8ED47B43;
	Mon, 29 Feb 2016 15:50:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1CB1247B11;
	Mon, 29 Feb 2016 15:50:09 -0500 (EST)
In-Reply-To: <20160229193222.GX28749@google.com> (Jonathan Nieder's message of
	"Mon, 29 Feb 2016 11:32:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 051BCC12-DF26-11E5-917A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287898>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> I added your suggestions as amending and as a new patch.
>
> I think we're at the point where patches on top would work better.  I
> admit I was a little scared to see another reroll.

Yup, let's stop rerolling this during pre-release period, and
instead concentrate on fixing what's already in 'master' ;-)
