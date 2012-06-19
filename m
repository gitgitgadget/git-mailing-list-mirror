From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Tue, 19 Jun 2012 13:38:35 -0700
Message-ID: <7vvcinyr3o.fsf@alter.siamese.dyndns.org>
References: <20120619195229.GA14692@sigill.intra.peff.net>
 <20120619195255.GA14714@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:38:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh5CG-00067e-9P
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 22:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab2FSUij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 16:38:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964Ab2FSUij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 16:38:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B06D48FFB;
	Tue, 19 Jun 2012 16:38:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jGOl8KgNI6KTiSu/xWFdEnBbrIE=; b=dBMov9
	pLhKIW0hM1J3E94F2f3fQwmRoIAHGWxnhhBWCl1t5dCBFb3E9vYSUtImxcpLmMXv
	nd9JxkjIImApQTCwiUIvj9RT74b5HPnSlOijKGETmdRNyPoHUCTglFDE+82rgF8f
	lJYEltV9YNuC20lznxel/WfjNBJgBe4fIHhxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ykWUXcauU3NdAimyqMkIDrem6rXifhCP
	VSr+y0kODvvyqWlDj6JgvdvXNoLBlpJgA//qCh6Nv4/XL3BS5O9i0HqjQaVwqVTe
	3Q5BG7xNHCXuAQw9wHBjHYUdLg7/1LmMHB+NVLLlU6A0FVjmJuSPFkOPDi7uYpNT
	tHzNCFXEyTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A79748FFA;
	Tue, 19 Jun 2012 16:38:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18B368FF9; Tue, 19 Jun 2012
 16:38:37 -0400 (EDT)
In-Reply-To: <20120619195255.GA14714@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jun 2012 15:52:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEEB5E60-BA4E-11E1-8340-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200240>

Makes sense.  Thanks.
