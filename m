From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/11] several notes refs, post-rewrite, notes
 rewriting
Date: Sun, 21 Feb 2010 16:25:02 -0800
Message-ID: <7vr5oeazhd.fsf@alter.siamese.dyndns.org>
References: <cover.1266703765.git.trast@student.ethz.ch>
 <cover.1266797028.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 22 02:12:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjM73-000151-Sm
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 01:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab0BVAZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 19:25:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab0BVAZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 19:25:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F2669CBD2;
	Sun, 21 Feb 2010 19:25:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J8RpX3VFCW0viTWKad1rCJMcTwY=; b=I5q06R
	0+Eai9+mWP00tWcpN69j+3rnn7L9m48lIC8mo4vzSCsycvmkDpwPZEkxzeiiRHY6
	aeE4Kbtmx0DdLKp/dgbsu7vD6iVt5pKZl5Inx79y8VwvDK3sZo8u6lMYz2tgPM+2
	2rfW0rbOTR0N9UFhYaZ381Sc04D5Y7Z+23xIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qhsmUrclE7NrVDtb1waFuvi8xPlxBnmC
	CFr4pMpPyRWeqqnG7twd0axstddIwskJxlfX2rA+SuWOc6rlhKxP3IlDhtwrYSNb
	yohFN6uMym3zeuyctuis4m9gRT8fCyurRD/SROmaNPLhiO0zSK1hqpjtb5D23Wh9
	IY0+kPR0+9E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA55E9CBC7;
	Sun, 21 Feb 2010 19:25:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C8449CBB9; Sun, 21 Feb
 2010 19:25:03 -0500 (EST)
In-Reply-To: <cover.1266797028.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon\, 22 Feb 2010 01\:10\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BE475322-1F48-11DF-8D97-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140634>

Thomas Rast <trast@student.ethz.ch> writes:

> core.notesRef should be in that list
> implicitly, and I think the natural position if it is unsorted would
> be: first.

I think that is a sane thing to do, and then any additional ones can come
after that first one, in the order specified by displayRef.  Isn't that
what you are doing, no?
