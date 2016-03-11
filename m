From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/10] config: drop git_config_early
Date: Fri, 11 Mar 2016 15:33:03 -0800
Message-ID: <xmqqegbga8uo.fsf@gitster.mtv.corp.google.com>
References: <20160311223620.GA7963@sigill.intra.peff.net>
	<20160311223703.GE449@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 12 00:33:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeWYT-0003gu-Gg
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 00:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbcCKXdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 18:33:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751562AbcCKXdH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 18:33:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D3384C72A;
	Fri, 11 Mar 2016 18:33:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3hMoXGAxFg2roNRV1/XDdKzmWQU=; b=C5LmeH
	ec/LTNwn1mIcMkoK2N9+PtoiHrgYs88mDISnELwYP7A52p4/rjwVc6DyOCu/LMfW
	82/u5RtmqevbVRzfr1oHDJkRAsJAZe9Ke2clkDUkqB5rcATjFxYGDw/vH3E1RTuj
	lx+hP+ByIIoIkAB13lJaM88VvDnEacS4ZGZnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HGG0BpUa52n4KdDOpDd0LpePi1B1HTNY
	VHRFmmHsjW7Y00JWFmuNgVx5QxjzGlpUMGoKuGNuXaCVzVo7orRd5d+VbvyyoDzx
	1limtq4nQETAGd+ltiTjA7Bp9q/WWV+3eRYwHXyteCmdLYduFoMFUorwrPFUYtzX
	bASJmh4s9QI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 162324C729;
	Fri, 11 Mar 2016 18:33:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 877684C724;
	Fri, 11 Mar 2016 18:33:04 -0500 (EST)
In-Reply-To: <20160311223703.GE449@sigill.intra.peff.net> (Jeff King's message
	of "Fri, 11 Mar 2016 17:37:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A380A9A-E7E1-11E5-8761-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288719>

Jeff King <peff@peff.net> writes:

> There are no more callers, and it's a rather confusing
> interface. This could just be folded into
> git_config_with_options(), but for the sake of readability,
> we'll leave it as a separate (static) helper function.

Yay!

;-)
