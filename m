From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A question about the tree associated with a git notes commit
Date: Tue, 09 Feb 2010 23:01:46 -0800
Message-ID: <7vmxzhfuat.fsf@alter.siamese.dyndns.org>
References: <2cfc40321002092216p5cbf432bs3766d40858f9bf3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 08:02:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf6aM-0008Tx-Du
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 08:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab0BJHB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 02:01:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab0BJHB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 02:01:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 033E898164;
	Wed, 10 Feb 2010 02:01:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K9W7IImNNNI71o7IRFHXJ3SFk6E=; b=T+1EfN
	/76XC+RiLrfZ2jXeu4b0722dhl7t6FWIxaqKptYYGrog8sqYiUVCbFZ5d1PA9HH6
	xMaRC5x4KwRSHCoGobA0DqEdUbjTnVmzGYPfCSkkIVHS9KhWeRPyYwlnRyWq4lrC
	bVudfC3WijLIegbQII7EiaT7LTLUwNsCgsTKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qza31b5qIlx5cyb+vQgvJn2XFsVkCxwR
	3j4cPG3hyu4BsIxgIpLWpHlyIcA0pN8upLRVlRnabaRWmN4duyCiFq8jdOkSklTM
	YmM12eQgyudq/8GerMF0vo14cQo2cMWptQBajXsfWxGUqRXfJklUrOIuBKD9tOnJ
	s1AyDAdgXIU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B867F98162;
	Wed, 10 Feb 2010 02:01:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5D1298161; Wed, 10 Feb
 2010 02:01:47 -0500 (EST)
In-Reply-To: <2cfc40321002092216p5cbf432bs3766d40858f9bf3a@mail.gmail.com>
 (Jon Seymour's message of "Wed\, 10 Feb 2010 17\:16\:55 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2AC5A4BC-1612-11DF-AE00-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139495>

Jon Seymour <jon.seymour@gmail.com> writes:

> Apologies if this question is answered with trivial analysis of the
> code, I admittedly haven't done that.

Output from "git log master..0ce25c4b" and especially and c07d5eb (t3305:
Verify that adding many notes with git-notes triggers increased fanout,
2010-01-27) and 71942f4 (t3305: Verify that removing notes triggers
automatic fanout consolidation, 2010-01-27) would be of interest.
