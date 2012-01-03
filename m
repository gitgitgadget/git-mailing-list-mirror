From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.7.7.3 wishlist: add --verbose option to git-tag
Date: Tue, 03 Jan 2012 12:02:33 -0800
Message-ID: <7vk458tuzq.fsf@alter.siamese.dyndns.org>
References: <87d3b51vr0.fsf@cante.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:02:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAZF-0000ib-Q0
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab2ACUCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:02:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640Ab2ACUCg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:02:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CACF76099;
	Tue,  3 Jan 2012 15:02:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MDJ/KIqICzARsbW5NMX1z8b6j3k=; b=XJyD3H
	qRko+GRR9VL0gMzqwIzFTp1kWJ86Wb4fLBBvOd5i3Nzhrcuu7DwqcMFOGNjFeA6+
	3Q/9OW5jKpvxl4lBGp5c0KIhDOmmJkih2Y7SvIaruapuEVr2+hs51Z4MI+OUUwCT
	YPCr1pmnGl8/9rGNrG+17jQKSCRejB1H5jJ+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rijGc6JN2gnJqXB3NChSJMx8c+rA1xBO
	nzq78QwsEv7WrFE8jcQsujUILDdrrO126j8Lo5yPlwusN6/emj6a3CuxdANDDH9d
	Q/XgILSQTkXoD+zFMkkXiu6zUV5yw8HDJa2PsE7grdStuAMQLpUXK9McQGm6nvlU
	m5eaSPdELcU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1BB36098;
	Tue,  3 Jan 2012 15:02:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 754926097; Tue,  3 Jan 2012
 15:02:34 -0500 (EST)
In-Reply-To: <87d3b51vr0.fsf@cante.cante.net> (Jari Aalto's message of "Sat,
 31 Dec 2011 01:32:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E07F5726-3645-11E1-9764-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187885>

Jari Aalto <jari.aalto@cante.net> writes:

> In scripts it would be useful if "git tag" would provide option:
>
>     --verbose
>
> As in script:
>
>     git tag --verbose -m "Initial import" upstream/1.0

"In scripts", you are expected to be capable of doing anything fancy with
"git cat-file tag", but we add things that turn out to be commonly needed.

What does the proposed "--verbose" produce that makes scripts easier to
write (i.e. avoids repeated post-processing of "git cat-file tag" output),
and how commonly would what you propose apply to various people's needs
other than yours?
