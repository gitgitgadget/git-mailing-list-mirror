From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 15:41:00 -0800
Message-ID: <7vvdgyp3zn.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0911260032410.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:41:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRU7-0003uJ-9c
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbZKYXlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935209AbZKYXlG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:41:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935207AbZKYXlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:41:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBE36822CE;
	Wed, 25 Nov 2009 18:41:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CbgYx9VMVQzGVeavL+c2Vyj19Wg=; b=IcRigg
	NAIpBfPux/fCqWiZBX+PUoy2NyLb2xWOGK8pbqGgFXEq+jBiYBxk3SRowrBzrCc1
	SP0smWk5pCaG3gEk5LFo7cpoIqTzJ6vXtr0mWX/NHqMKnjBYLK/vDDRXGlZGE+u/
	x1rCvbD5jyHWm9GifZhD8bCT8prldr/x+PF7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d9Ca2ulNHeNcLE3kwY3lCmqONZLHIqmp
	bmT1+POb3BNwO7aOsRvNbfVZUgcVg7UbdhDvzJyE4A92Nck5aVliOm27occcFb2I
	mfS5dIXry7BKOzChvwmGsbpVW0HS3o4/76ANNocTSjre/cX0w4ytP+fYVha9dGcw
	/IZ/joVjOg0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BEE97822CB;
	Wed, 25 Nov 2009 18:41:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBEAC822C8; Wed, 25 Nov
 2009 18:41:01 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0911260032410.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu\, 26 Nov 2009 00\:34\:49 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0059D6A8-DA1C-11DE-8466-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133704>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This would break spectacularly in MSys.

How?  If that is the case wouldn't --full-tree break Msys the same way?
