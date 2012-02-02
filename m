From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] respect binary attribute in grep
Date: Thu, 02 Feb 2012 10:39:24 -0800
Message-ID: <7vzkd1w04j.fsf@alter.siamese.dyndns.org>
References: <20120201221437.GA19044@sigill.intra.peff.net>
 <20120201232109.GA2652@sigill.intra.peff.net>
 <7vhaza12ol.fsf@alter.siamese.dyndns.org>
 <20120202005209.GA6883@sigill.intra.peff.net>
 <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:39:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1ZE-0004MC-7V
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099Ab2BBSj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:39:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309Ab2BBSj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 13:39:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB5155E2C;
	Thu,  2 Feb 2012 13:39:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aPg3nf7c3d8QHOm1t2Dc9er1Qes=; b=uEalkK
	Y9pMEjmL8MQ2TOeQM0EHt8xbocJsREmRGTtHrJTdQZNPHPCI3N7FXdOdHYFHxbbV
	OK4nCitnOWH4RtCA/dQQq/w+VEQkNluW02mqWRgYHkU4nC2q3kQ/QfNQxwRPnBIa
	4h+Vn0Zz5ku0jSH1mQl5F0c6qR/f3a5Mg09Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QV869JO3N0xL/KsPCxVHAyQzDST/Ecsy
	8/KLlUt1y7Ke0jFq8HKYUDyQeIgUrmlxo400ZIuTxeQy/7ie9OBQPAPdIJb/OHJ/
	C/KlJjBfAMUlh+aLMbLEfgJER1FqYWeftViTw+8XFr8/nafFMgYXgazcdih5gbim
	x0fEHJ9w8go=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B265C5E2B;
	Thu,  2 Feb 2012 13:39:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C3245E28; Thu,  2 Feb 2012
 13:39:26 -0500 (EST)
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 2 Feb 2012 03:17:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BB61D84-4DCD-11E1-8014-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189668>

Jeff King <peff@peff.net> writes:

> ... The result turned out much easier to read
> (and explain in the commit messages, as it was simple to break into
> smaller commits)....

Indeed the series is very nicely done ;-)

Thanks.
