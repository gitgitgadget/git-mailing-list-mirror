From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Integrate version 3 ciabot scripts into contrib/.
Date: Fri, 02 Apr 2010 12:05:04 -0700
Message-ID: <7vy6h5ad5r.fsf@alter.siamese.dyndns.org>
References: <20100402101011.GA6806@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Apr 02 21:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxmBO-0006Hl-OY
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab0DBTFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 15:05:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab0DBTFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 15:05:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93107A77D1;
	Fri,  2 Apr 2010 15:05:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pAGgelbMyydrUKm40bGmNEMFaFU=; b=FTTxva
	Ia3tT22sugQizFzAmwgTei85svF4BvH0kNr1MAgNqRPE4S37F+EJ+6P+OMQW8mpg
	BEgTzAvkjq23lJ77pmwD9VmAg8Dkp6CPnr8lQfwhIkqo4i3Ngw1DTnUehzEMmiPC
	QBTDtluGUa33VjTnIDxmRix7w5Iora2D3Q4ME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hYwpqW+pOOin97Ptp5OT9uemOGd98CyY
	NTriXHVUZqF++XjZEw4TfDrEEj+WKdEgditYEjFk0zWpqksH5uf6eIJy2MzESz+g
	/+olDyVrSFmzOGhlD1Wzlw0h7kmS5AoeoLMXEcO+2qJAW7m8xPgWK076blTvZKK+
	fgyEwXcfMgQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70578A77CF;
	Fri,  2 Apr 2010 15:05:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDCF1A77CC; Fri,  2 Apr
 2010 15:05:05 -0400 (EDT)
In-Reply-To: <20100402101011.GA6806@thyrsus.com> (Eric Raymond's message of
 "Fri\, 2 Apr 2010 06\:10\:11 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A7B2A6B4-3E8A-11DF-B7F6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143837>

esr@thyrsus.com (Eric Raymond) writes:

> These have been extensively live-tested in the last week. The version 2
> ciabot.sh maintainer has passed the baton to me; ciabot.py is original.

Thanks, will apply.
