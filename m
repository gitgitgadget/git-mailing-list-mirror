From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 06 Apr 2012 13:24:39 -0700
Message-ID: <7v7gxs1ud4.fsf@alter.siamese.dyndns.org>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
 <20120406201926.GA1677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 22:24:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGFiA-0003mP-DE
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 22:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab2DFUYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 16:24:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38706 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757903Ab2DFUYl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 16:24:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5DB27B93;
	Fri,  6 Apr 2012 16:24:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yIM/b9Ri5BkANBv2qPGwHLQQmX8=; b=DN+MNJ
	mvFkMqgQlGTfFZZvYInPxqGiXmi36JjoFjSRz2fby8DW2fzhGKQaMneGomjSNxBm
	ZXd8FkMGVG8z5ilbWhQOO9kYaf1T30jArzsths+1S9ezafzyLF52+4wQce/nkLX2
	3IUtQOe8qrXq8ItHF8GZHWHZlCnyRpztJS1oE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BM27EvIs/o4sncyk2ryEynVJvDpjclMO
	sdymEy1PXnBkEqSsfrLRllW3HV8jZ5AwgwqVWre2V34TvNhP57O0CDmB9r8hnhxm
	/8ELd7s+tUWIKIguUDsTHpeQK7KEOurfyGmXsHZyaKPZ70smHwfOWpv5Qbobnr/j
	HUPWDt6CNuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE05F7B91;
	Fri,  6 Apr 2012 16:24:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66C187B90; Fri,  6 Apr 2012
 16:24:40 -0400 (EDT)
In-Reply-To: <20120406201926.GA1677@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 Apr 2012 16:19:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89A63520-8026-11E1-85C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194904>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 06, 2012 at 10:28:39PM +0300, Felipe Contreras wrote:
>
>> Something is better than nothing.
>
> Yes, but...

;-)

This is a good example that sometimes something is worse than nothing,
unless watched carefully by a competent reviewer.

Your suggestion makes sense to me.
