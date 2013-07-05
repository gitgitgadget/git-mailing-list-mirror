From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/5] t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
Date: Fri, 05 Jul 2013 01:56:23 -0700
Message-ID: <7vobah8jwo.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<cover.1372719264.git.Alex.Crezoff@gmail.com>
	<cover.1372939482.git.Alex.Crezoff@gmail.com>
	<38cdab6c314e858ec580b1d0fbf87098c2d92cb0.1372939482.git.Alex.Crezoff@gmail.com>
	<7vy59la4gn.fsf@alter.siamese.dyndns.org>
	<20130705080011.GB32072@ashu.dyn1.rarus.ru>
	<7vwqp58lyy.fsf@alter.siamese.dyndns.org>
	<20130705084241.GD32072@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 10:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv1od-00059Z-4d
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab3GEI41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:56:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718Ab3GEI40 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 04:56:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA5322AD32;
	Fri,  5 Jul 2013 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JeSPoMJfxU45l5E+ysxVi8uCIIk=; b=Z6n8Yw
	BracXonN4RhZkyjoBGcRR6f6+By24exbne0NIZPPvFzf5M0aOW3YvZfS6mAz1d9C
	toqVddfi2FRJTfQ8wOiF7KDop0xy9Hu3/ioTI7iALBnGsJFbULzr1GfJ9RyyWXUo
	Snw9UEHhHKyOS8pfNfC46i2Yq8J/rd+OgtIys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yVQRWhJxo3l4lhiSjrnWxIrkBeV1CMT5
	o0OILysW7OzuePJaZGNQoatl+GxV95CaKRHBUB4yJ7qzxzCPM+WQakrkDEWxHe4Q
	UVCbsVLZrnpTVdlJf3rPMr8s8ORxJC7iezlhmUG4wjUwvoZlYvxIwJsuU6gi302B
	Uk3QKx8TMxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F7A92AD31;
	Fri,  5 Jul 2013 08:56:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 254692AD30;
	Fri,  5 Jul 2013 08:56:25 +0000 (UTC)
In-Reply-To: <20130705084241.GD32072@ashu.dyn1.rarus.ru> (Alexey Shumkin's
	message of "Fri, 5 Jul 2013 12:42:41 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5B43540-E550-11E2-8ABB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229642>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

>> OK, then I'll queue this patch (but not 2-4/5 yet) with log message
>> amended.
> Excuse me, you've said "Ok" for 2/5 message, and then explained (as I
> understood) then "subtle difference" between EOF and \EOF.
> Should I change the message somehow?

I left it up to you.  If I queued without waiting, it wouldn't have
been up-to-you, so...
