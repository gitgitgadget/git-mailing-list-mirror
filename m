From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Allow using ':' in git:// hostname.
Date: Tue, 26 Jan 2010 11:59:21 -0800
Message-ID: <7vfx5szlgm.fsf@alter.siamese.dyndns.org>
References: <1264530282-4783-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 26 20:59:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZrZW-0004z6-Id
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 20:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab0AZT73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852Ab0AZT72
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 14:59:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab0AZT72 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 14:59:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE1E99182B;
	Tue, 26 Jan 2010 14:59:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RW2RRd3T3bkxieQ7DXRw0iBgNrc=; b=Mwz7z/
	V4ApiGFUvVO5s0JF1C7pzQPPuQp8h9auNFybrI+4dvJD1M3u2Aj1SgLLdLO6Ai4W
	9Bz3JcuWg6bY8ZrAVebCQSaMHntWLjC1Z7ue7Ta+55GCJB16xB4fq9Hn9gIPRg/Y
	FK61vgG9YcZWzKgjgA9PfB6NXDcHc71rBmPDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HH6Z7rFGhWdH0axK1Ml95xDhblP1TcFt
	gKT5I/ksj1HJ7LnJE3C/ZVF36n2JMh01az7cp5Z8q5XfcuhNAalCOHyzyVm6wSxC
	giG8cpz8Udmzn9K3kv0c8/Zsj2CjHFPfhM7JyJ/E783FAIix0ajqL3yPVS8bxmZP
	Jo/iD5PY1b0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97C4691828;
	Tue, 26 Jan 2010 14:59:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 003B691825; Tue, 26 Jan
 2010 14:59:22 -0500 (EST)
In-Reply-To: <1264530282-4783-1-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Tue\, 26 Jan 2010 20\:24\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DD9EBB0-0AB5-11DF-A864-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138071>

Seems like a maint material (together with your xmallocz() one).
Thanks.
