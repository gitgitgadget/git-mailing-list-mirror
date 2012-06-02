From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git ls-files and ignored directories
Date: Sat, 02 Jun 2012 15:56:58 -0700
Message-ID: <7vr4txz5j9.fsf@alter.siamese.dyndns.org>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com>
 <20120531101451.C35C5B4C00D@dd24126.kasserver.com>
 <20120601093757.GE32340@sigill.intra.peff.net>
 <7vr4tz3tpw.fsf@alter.siamese.dyndns.org>
 <CACsJy8CqMudg=uKuDmRHoYAXhUoYhOp3V2ZLuKM8W5wWWE460w@mail.gmail.com>
 <4FC9F24D.7000306@phononoia.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	git@vger.kernel.org
To: bilderbuchi@phononoia.at
X-From: git-owner@vger.kernel.org Sun Jun 03 00:57:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaxFr-0004SB-LJ
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 00:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010Ab2FBW5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 18:57:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932702Ab2FBW5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 18:57:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 269008D4F;
	Sat,  2 Jun 2012 18:57:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ADU/FPjFNiT98YkEm7d8CVfxY6k=; b=LqNB1e
	u150IKSC0t0oh/kJaB0shBuJFfGMXK9OrwOrqDtPyWMTiLawD5qEw7rOtJ6DlBGj
	X8Z441yhaxdLmtyrElniU07xTcnfC0N5iJD/piZI0jpzJWcq2mKYEVnSR6+4J5wV
	U+PtwzDR5KUWiG3zgLJe65Z+WXpw3Yvb+tqso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QpePEktvwAl7wIKJAq4JW5ca9PuExguc
	UZ3yMOBmhVuoo/Lht3bCzFgH3T0xXJ+WjZVgddnlB9N/IMw1tu76rEjFdGkvW/nt
	71E2TVa4uvmzJf9q29jxLc9ryGIj3DfgqF8MBFI6i4hjAJknDLHKx05zNNGwV2sJ
	MbIQhIGTA0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DED68D4E;
	Sat,  2 Jun 2012 18:57:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 927A38D4D; Sat,  2 Jun 2012
 18:57:00 -0400 (EDT)
In-Reply-To: <4FC9F24D.7000306@phononoia.at> (Christoph Buchner's message of
 "Sat, 02 Jun 2012 13:00:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 432B1806-AD06-11E1-9FDA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199062>

Christoph Buchner <bilderbuchi@phononoia.at> writes:

> @Jeff: Thank you for the clarification. I didn't want to appear pushy,
> I just wanted to make sure that I did everything right and that my
> mail won't get ignored/filtered because of some breach of protocol.
>
> @Junio, Duy: Thanks for starting/proposing work on this!

The patches are queued to 'pu'.  Do they fix your issue?
