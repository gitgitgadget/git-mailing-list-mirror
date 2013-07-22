From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] config: allow http.<url>.* any user matching
Date: Mon, 22 Jul 2013 15:34:15 -0700
Message-ID: <7vob9u9qc8.fsf@alter.siamese.dyndns.org>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
	<7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79>
	<7vehaqcw66.fsf@alter.siamese.dyndns.org>
	<DF5B20F8-33C2-4F72-A78B-97EE1FB4A522@gmail.com>
	<7v1u6qclfx.fsf@alter.siamese.dyndns.org>
	<14CC7E43-3588-4B36-A8E9-79C22D548D8D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 00:34:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1OgZ-0000vX-7r
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 00:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab3GVWe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 18:34:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645Ab3GVWe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 18:34:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F85227219;
	Mon, 22 Jul 2013 22:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f7/y8A3eglm69un8ACKQ8nqWcVY=; b=E+ew1x
	WFwQJQKYHQmWy25Xe/GDWhN9ACvtFTI4lRaive70patQ2iepLsvDaghg1hNI3Syh
	SZ/aAx+to6CQsLeAkssJjOzwBchP51iqpAgHkeIHHQWSH6vKPzsI5i3doNB0zwiT
	pf37ETaemTUkC5dtD1+8c3/FIFWHMP96fS8J8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gTmTYnmyfd5l+wcPiUGoB0Gi320NWZ49
	RuGdZeNh8cmvw41jyzjgvyBFmLEPUUPRwmZOsmUb61in3od0Ocd+a0t/xxlxQmcT
	xNXOLztFpW+sOQT/oVAEWszTCrREiCyAZvgFtSr9UEwmLoO6jaJ58jbaUqW0n4Na
	+9aQ31k6oBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FD9927218;
	Mon, 22 Jul 2013 22:34:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 873BA27212;
	Mon, 22 Jul 2013 22:34:25 +0000 (UTC)
In-Reply-To: <14CC7E43-3588-4B36-A8E9-79C22D548D8D@gmail.com> (Kyle J. McKay's
	message of "Mon, 22 Jul 2013 15:18:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCF90A1A-F31E-11E2-871E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231007>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> After replacing "take" with "takes" in the change I'm good with just
> squashing that diff in.

Thanks for proofreading.  Then let's omit an extra back-and-forth.
