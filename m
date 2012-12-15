From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: don't link to example mail addresses
Date: Sat, 15 Dec 2012 10:00:38 -0800
Message-ID: <7vy5gztcu1.fsf@alter.siamese.dyndns.org>
References: <20121215150314.GC2725@river.lan>
 <20121215172018.GA18696@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw4i-0006Wy-00
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab2LOSAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:00:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2LOSAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:00:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62A4A9F99;
	Sat, 15 Dec 2012 13:00:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YMIa9k1Oj2YZ/M6n5f8eOV/JUqw=; b=psYBti
	FpgmUfi9jP5BaTh7idLf/Lt3jtBjMtc9P29Gqx9LBLXTzhOYMsKjee4pwQriV4qm
	3JwrklHqpg0fsTrQpwdKAc2RiIWCBDbkjDUdQzS3he1UQtEQLShGM3WO0L6/xSlT
	XE8qEEHhPcuJVqP9lLoL/xMtp/ZTCRw3T+Ys0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S1c2cs+KpoBK73ZqtHRZXGjGjQTde6j9
	6/c62X7jtlvaIhov7rxGc5mpiH1/48DCIoY6TH2zPUDwE2v5pkc1lijrikDeWlZg
	ywGOUBZ6G2PXwsBy7JX0thUi2QgILdRxdleNPOANctmpzr1SJsXdYimamHpGrosA
	txuAeRXlrok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F9119F98;
	Sat, 15 Dec 2012 13:00:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C442D9F96; Sat, 15 Dec 2012
 13:00:39 -0500 (EST)
In-Reply-To: <20121215172018.GA18696@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 15 Dec 2012 12:20:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55F31CF2-46E1-11E2-9409-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211542>

Jeff King <peff@peff.net> writes:

> I think I'd just render them monospace everywhere. We are very
> inconsistent about which form of quotes we use in the documentation (I
> think because most of the developers read the source directly and not
> the rendered asciidoc). And then we don't have to worry about the "$$"
> construct (and IMHO it makes the source much more readable, and marking
> the address as a literal looks good in the output, too).

Agreed---thanks for spotting, John, and thanks for showing the
overall direction, Peff.
