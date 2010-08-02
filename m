From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/tag-contains
Date: Mon, 02 Aug 2010 15:38:41 -0700
Message-ID: <7vbp9kk5ce.fsf@alter.siamese.dyndns.org>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
 <20100730183709.GC18544@coredump.intra.peff.net>
 <20100731060703.GA21207@burratino>
 <20100731123328.GA5273@coredump.intra.peff.net>
 <7vocdlpsmw.fsf@alter.siamese.dyndns.org> <20100802200209.GD2180@burratino>
 <vpqk4o8bwwd.fsf@bauges.imag.fr> <20100802201920.GE2180@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:39:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3eu-00042X-JB
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab0HBWi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 18:38:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab0HBWiz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 18:38:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF210C981C;
	Mon,  2 Aug 2010 18:38:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=shIMWyR+xGzNwl2i8XEPW0wD+pQ=; b=O3JYTT
	RmFZUAXnjROUJqy4jBAhgOBHmUoUEGN4mDqoe4xH0Z89WPGMneCP9UiOBpQ6R4Kf
	guG/xzyVBq5qfuLk+vpNyuT5ZjG5OVS3atYnuR4eTGHQTQ/JuxaXzUQRG701S1sM
	54Ko5GiXU+O6QmZjx4u0sthNiGVjL43tu3YNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XAwSDGSrsJ4uadbSYYwOXIfhQ/+7b9Ln
	vEkVyYKWHMncdBUC80m/QKBekcTy0gldLKpqpwuRAsV/C4GEp7x+ZC+5BWDdsnp6
	kDDSvIqc6fwXdVadz/MglIccM1WWrZEsf9BvKOTHv6NUCE2mRxITF4oPFryDX0QU
	kHeLiH29tnc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83DC4C9816;
	Mon,  2 Aug 2010 18:38:48 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BAE3C9808; Mon,  2 Aug
 2010 18:38:43 -0400 (EDT)
In-Reply-To: <20100802201920.GE2180@burratino> (Jonathan Nieder's message of
 "Mon\, 2 Aug 2010 15\:19\:20 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B77382B0-9E86-11DF-8D4B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152477>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I would like it to still be possible to publically acknowledge a
> mistake, make people rewrite their history to remove it, and move on.

While I wish the world were that simple, I do not think that is viable.
You may not have any control over your upstream (not to mention the
possibility that the upstream might even be a foreign SCM).

So I'd prefer to see us prepared to be lenient with what we accept from
outside world.
