From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Mon, 06 Feb 2012 15:34:22 -0800
Message-ID: <7vr4y74jup.fsf@alter.siamese.dyndns.org>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
 <7vk4408ir6.fsf@alter.siamese.dyndns.org>
 <7vfweo8ikq.fsf@alter.siamese.dyndns.org>
 <20120206083832.GA9425@sigill.intra.peff.net>
 <7vty337rug.fsf@alter.siamese.dyndns.org>
 <20120206201245.GA30776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 00:34:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuY4s-0002Cb-50
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 00:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab2BFXeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 18:34:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab2BFXeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 18:34:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7448B7EE7;
	Mon,  6 Feb 2012 18:34:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0g5SKYmvETPUtOH3QhMZyAXDzT4=; b=Q+ShK6
	PL9bTKpawqnBGpwaws9ILoxLb9Ql2+y3U9r8oFgy+K3p8X7bKuGwT24Sdv1yNZRp
	9K9HcHnAGPbkUALyHtFkTR5INrHHcJQwK3FGFBfgyQ/8yx2eWp4ihkMOi+okm6gr
	TXwO8EVgIH9kN6qbyefcao6RIURmLBi1BvGe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BkOrOBlKvVRmN72PvoUVp3tkyaHfVSMj
	BC2jRjLg0KqetOJ4LMUcVvuYyyeNz/U3y2pwAzmoE4nYHN6/DZCTpiE/SSU7ndm7
	Lcqh753mNqsZQvAMiN69sMqfTZrCFIvKVEY9jk+GogDxK/Te+wbIjmTZmB/Qn8pp
	M5Z4HvoiRkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B7EF7EE6;
	Mon,  6 Feb 2012 18:34:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 001777EE5; Mon,  6 Feb 2012
 18:34:23 -0500 (EST)
In-Reply-To: <20120206201245.GA30776@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Feb 2012 15:12:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A01CD90-511B-11E1-977D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190122>

Jeff King <peff@peff.net> writes:

>> Subject: tag: do not show non-tag contents with "-n"
>
> Looks perfect. Thanks.
>
> -Peff

I was an idiot and you were being too polite to point it out X-<.

+	if (type != OBJ_COMMIT || type != OBJ_TAG)
+		goto free_return;

When will I ever get any output from this crap?  What kind of object
should I craft to pass through this stupid gate? ;-)

Fixed and requeued.
