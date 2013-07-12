From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: Map email addresses to names
Date: Fri, 12 Jul 2013 13:00:35 -0700
Message-ID: <7vppunk0po.fsf@alter.siamese.dyndns.org>
References: <1373656881-5187-1-git-send-email-stefanbeller@googlemail.com>
	<1373656881-5187-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:00:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxjWG-0002or-0v
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757816Ab3GLUAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 16:00:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757812Ab3GLUAi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jul 2013 16:00:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0341C30ECE;
	Fri, 12 Jul 2013 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BKLq+57nWKvZ
	lw+vCr3tYNG6haE=; b=Tt4Cky0cvpBA3IpF+3qoLj7F0uSqu3NWrpOfDFoMP8mN
	CQkIxkAE/4SsPyYHQ7JC0jj6QYH7bjhALDP6ZFt0HevmL34YWkQrxCcTR5HjgoGW
	86V525PUCTyNT9AfAgMRg9gv3zY8XJvNIRkZ4x0v0fG7RcwmJiuXBGCB9ip62Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sDPtSy
	NgbHnQgjS5PGzixAUfDBX29BMIY98CRc4ip04OpYBE7dUUlj2ioin7rj4Cb6f4zm
	o+1NH6HEz3OowV3P2qjaAWdTnWr2fgynvQwrSN0MhPDxy2AiwL+Bz3ZjyXQrmvNm
	GN/48yhpWTlgMcs6BKVq5G0BVlXc0DrdukYGw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE9930ECD;
	Fri, 12 Jul 2013 20:00:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA68230ECA;
	Fri, 12 Jul 2013 20:00:36 +0000 (UTC)
In-Reply-To: <1373656881-5187-2-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Fri, 12 Jul 2013 21:21:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B816322A-EB2D-11E2-95F5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230247>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Additionally to adding (name, email) mappings to the
> .mailmap file, it has also been sorted alphabetically.
> (which explains the removals, which are added
> 3 lines later on again).

What is this "3 lines later on again" about?  Is it a remnant from
the previous iteration?  If so, I can remove this "(which ...)"
locally.

> While the most changes happen at the email addresses,
> we also have a name change in here. Karl Hasselstr=C3=B6m
> is now known as Karl Wiberg due to marriage. Congratulations!

Indeed.  I like this part of the log message ;-)
