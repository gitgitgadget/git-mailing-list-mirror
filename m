From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 4/5] branch: introduce --list option
Date: Sun, 28 Aug 2011 23:51:25 -0700
Message-ID: <7vippg7lsi.fsf@alter.siamese.dyndns.org>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
 <cover.1314543252.git.git@drmicha.warpmail.net>
 <05a1a73e0b942dd94dd091c233be964fa19dfc6a.1314543252.git.git@drmicha.warpmail.net> <7v8vqc92yp.fsf@alter.siamese.dyndns.org> <4E5B3317.7000207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 08:51:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxvh1-0000Vu-5I
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 08:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab1H2Gvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 02:51:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab1H2Gva (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 02:51:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22A6B2483;
	Mon, 29 Aug 2011 02:51:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FGDjTn4HFUohwR4MVwkeWDlsl1s=; b=LsJT7Y
	k2WjUXlZd6O+G/P5yjrApkK/ugrK1yvpzbN9pm4nOJvgJMcs1uaFws2UWRelHb59
	p3wz5oU1gMOCHQwde/TEDuIqrCl7LWSbhez5TzvQ9RmrEHxR2Fs6EJwDQIscqRbW
	h2Mm3zRDsqhG4PWF6+RMAhebZgjs5Tuqm4xEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ax4+VfU6iK5hPwvGUILKmt2zTCP4/Bna
	wf7SsqeIB6pbHCkwrhuZvMPchZSLPrtFRFFDCMccbJSREkQ+mEJ6hsg2jtnxM9sm
	tRfwKUlR39kMQSvu9ylu20c1CH5F9G4iQfaPjJiY/Qwvj9bkq7coZ+hYNHsPoZiF
	/aYgd1L489Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19AD32482;
	Mon, 29 Aug 2011 02:51:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A82922481; Mon, 29 Aug 2011
 02:51:26 -0400 (EDT)
In-Reply-To: <4E5B3317.7000207@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 29 Aug 2011 08:35:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5106F048-D20B-11E0-A514-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180304>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Sheesh, that rebasing mistake (flipping the order of 4 and 5) was
> present in v2 already. Only recently I learned about rebase-i's "exec"
> and have to make it a habit to use it for step-by-step series testing.

That's Ok. Locally moved the offending part of the test to 5 when
applying.

Thanks.
