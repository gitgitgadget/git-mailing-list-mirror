From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv12 01/23] Minor non-functional fixes to notes.c
Date: Wed, 27 Jan 2010 13:20:11 -0800
Message-ID: <7vwrz3nt2s.fsf@alter.siamese.dyndns.org>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
 <1264593120-4428-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 22:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaFJJ-0006ND-50
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 22:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab0A0VUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 16:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755996Ab0A0VUT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 16:20:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab0A0VUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 16:20:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7214B94879;
	Wed, 27 Jan 2010 16:20:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K96tr3BykhiE2u180ajW/wr+Dqo=; b=kjPKok
	bwYxUBql5SI4Q9EWUYPszSqcfmVVksFh96gV072kK0IM8S4M495c9RthcBJjt1jN
	VKcWyD9BV4GBe5TpEN8wtZPqzKgWLoDLKDkWmVuIo0HWLbpFUjem77wa+GpKFgUq
	cCmIHNEhRTSGlyutBiwHxBo3oplxyyU+7xu3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j8JeEz3gHt0pfLvBW0f2DkJeDJqS8FSl
	h4Mu/IqRR5O80/065zaMR/PQ0rRA67V33Xwgc/E4pPpWDB1AlGCfNgqkCxdDl8Wr
	g1xOVxbhB+UzrVld7o0WT0Ozm9DvwaLYXnXMqMwWGzInuaayILyfRbt4yIV20fkN
	cif7qS5RwQo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5026394877;
	Wed, 27 Jan 2010 16:20:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89BFB94870; Wed, 27 Jan
 2010 16:20:12 -0500 (EST)
In-Reply-To: <1264593120-4428-2-git-send-email-johan@herland.net> (Johan
 Herland's message of "Wed\, 27 Jan 2010 12\:51\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C38358A4-0B89-11DF-BF8E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138198>

Johan Herland <johan@herland.net> writes:

> Signed-off-by: Johan Herland <johan@herland.net>

Is it just me who goes "Huh?  Why is he sending a non-working fix?" when
seeing "non-functional fixes"?

I'd retitle it to "Cosmetic fixes" and apply.

Thanks.
