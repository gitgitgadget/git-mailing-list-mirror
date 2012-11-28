From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-helpers: general fixes
Date: Tue, 27 Nov 2012 18:02:43 -0800
Message-ID: <7vfw3ujxh8.fsf@alter.siamese.dyndns.org>
References: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:03:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWzN-0006Jl-HP
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961Ab2K1CCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:02:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab2K1CCq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:02:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC504A6D5;
	Tue, 27 Nov 2012 21:02:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sD5pZb6aRxEdW7/nhwz69zI3lfw=; b=n917XU
	LZ3R0cnGRDEgOhqvLIILv+z+Mf4j4hg+nkFUbTh149Rn1zPxhHJtsjLSI36VFh45
	RwB1bqXm92HO5QCcgYcZRWWSa+ELsIb2AojzLUFGY34MgPcZtns1NommMVypfgdE
	3OEXe/+yZewn/YRoXihVQ2ojokqPNbcezhESI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ot/Op2EXvi44xBS6ViYIUuU9kpe27ODi
	M5ttdDyBZVyxcIJznMeU6FhVuvYyzUZQGme5skG7FUpQ1eGurjF8PvR1QeHOVVXI
	n797ZtWXGRDE/cJeEZLIwA6SkoDZjBm1ldZW242kCpkcfUdMohpmOZMBVZoIkO+x
	sZNDVhkS5O0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F75A6D4;
	Tue, 27 Nov 2012 21:02:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CAC8A6D1; Tue, 27 Nov 2012
 21:02:45 -0500 (EST)
In-Reply-To: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Wed, 28 Nov 2012 02:01:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3622562-38FF-11E2-9CEC-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210667>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> These are general fixes, some for old versions of bazaar, mercurial, and
> python. Some of these have already been sent, but here they go alone so they
> are not missed.
>
> The bazaar fixes are on top of the series v3 which is still not in 'pu'.

Please stop then.  Its v2 has been cooking in 'next' and it won't be
replaced.
