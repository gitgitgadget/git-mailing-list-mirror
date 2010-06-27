From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Make the string_list API consistent
Date: Sun, 27 Jun 2010 10:22:14 -0700
Message-ID: <7v4ogoie61.fsf@alter.siamese.dyndns.org>
References: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Jun 27 19:27:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSvde-0007jV-6w
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 19:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab0F0RWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 13:22:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab0F0RWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 13:22:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33D16BF15C;
	Sun, 27 Jun 2010 13:22:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PSQerJU5S2/7GPYBSBp2b5lc3vo=; b=x8l4ap
	vX2PM7vNPELbsO8wzCDqxoOolR+w6tc+SZ9Y0ldwn24a6BRwbr9egKrx08ZkvGG3
	7E3POh7wSaSrs+lc3b2fqZPT7cp0+370r5h5hjPZif8WwoofZdZ0fcfp+V/XSzLZ
	hG5wH4FF7/RbdQ9KewH300ha/YqFKUF0NPxxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JqZPGWHcpXclI2lv0/8+QegEb4rEa3Dg
	KgYPluI7zJuNfkch+N5PVgpNqubF3lruc4VWhUIoSUqfSPaNbwDcAK8rOkUK6QJs
	X+e+kY4vwKX8rBiTVfwP/mAmff0rsu7zQ6qQj/Ny8d5dz7VL7Ybz/DImcbUFx216
	MkpWVn2/EU8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B0CBF15B;
	Sun, 27 Jun 2010 13:22:19 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76EDDBF159; Sun, 27 Jun
 2010 13:22:16 -0400 (EDT)
In-Reply-To: <20100625234110.18927.33169.julian@quantumfyre.co.uk> (Julian
 Phillips's message of "Sat\, 26 Jun 2010 00\:41\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 89FBA98A-8210-11DF-B211-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149795>

The way you split the patches, together with the timing you chose,
i.e. the topics in flight right now have much less interaction with the
string-list API than in April, made it very pleasant to apply the series.

Will queue to 'next' and also update 'jn/grep-open' with it.

Thanks.
