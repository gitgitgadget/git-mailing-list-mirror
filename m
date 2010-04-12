From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 08:47:06 -0700
Message-ID: <7v1vekn05h.fsf@alter.siamese.dyndns.org>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
 <4BC2D61B.7050902@drmicha.warpmail.net>
 <n2ifbd9d3991004120123p7b08a8a2wee380454e9fe9a1d@mail.gmail.com>
 <4BC2D9B5.6070400@drmicha.warpmail.net>
 <m3pr25f3ye.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Hajnoczi <stefanha@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 17:47:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1LrL-0000KV-1u
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 17:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab0DLPrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 11:47:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab0DLPrV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 11:47:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0137BAA9B6;
	Mon, 12 Apr 2010 11:47:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xt2E2wS8VACuAc4fQaEVL6TEIV0=; b=baZoY4
	8+8f8P7tQyAglBwYkui71/sa3bA1HjJC/IaZFxsN6cLGT+NMHmI7JR5PzX+fYVGu
	J36sGkZDf79SFm234jyERAhxI/nnwnTHFQ80+aFjqjPxXfYhGrKHqMyg6yrMK17C
	AavHKBRYHfVKVC74oTyJEB5tsqacnSN6X9emw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UlSk/XozkbwcWu4LK5x7QisMRQO9eBRE
	c7SriqEMjMpuxN55ToRmPxNfA9JSQvoG9Dgx4hEM+arxpyM2eryU64ckjCssHTT4
	GDFflF0bECaakRIL7SJaY2WX/79StTUlx5upjOQpZhbNx2yyu7gftnxKvgMQWQ5+
	tT1L96cBU68=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F4C7AA9B2;
	Mon, 12 Apr 2010 11:47:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCDB8AA9A6; Mon, 12 Apr
 2010 11:47:07 -0400 (EDT)
In-Reply-To: <m3pr25f3ye.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon\, 12 Apr 2010 01\:53\:01 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AADBC0BA-464A-11DF-BA12-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144744>

Jakub Narebski <jnareb@gmail.com> writes:

> How does special case of no value, i.e.
>
>    [sendemail]
>         smtpuser

That is not a special case; that is "boolean true".
