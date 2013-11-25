From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filter log based on paths NOT touched
Date: Mon, 25 Nov 2013 12:35:51 -0800
Message-ID: <xmqqeh64xlqw.fsf@gitster.dls.corp.google.com>
References: <5293B0F9.1050200@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2sx-0008TS-2d
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab3KYUfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:35:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab3KYUfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:35:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D0A3534DF;
	Mon, 25 Nov 2013 15:35:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BoQSaTHh/zyH4qZIA955O5LCZRY=; b=Dya/fJ
	+VbHgH/vytuhCa5YXD6i4uFyo1Nem0IKi59Z81V+lE8qJvIopHm1Hq1YEa0ohzca
	z5Vmeq8t6CBoUzeoJmq3VCBweNllhdyf04gzNBVQJbeiIfgCL9JzY3wxRXkPWL6n
	8ZgZgDeIve1kPR1avyI9ZIoSR7tFv2Zuz+E98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHBs6ObIHO6m1RJ1OMWDZi5cYMQieMU0
	tRMdPGGPi+ztcQeeOO/huaM+n5GJDM53WXunwaIYRWbv8vwwwRZtxFAvMe/Pdxug
	CvU9Ayo11+80eKOPNjNDqLPq3xeJHL9NLalT84DhQ0qmN4i9tCw3x9CNvh5EjLZ0
	AuaA+ke3THE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58EA9534DD;
	Mon, 25 Nov 2013 15:35:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C7BF534DC;
	Mon, 25 Nov 2013 15:35:53 -0500 (EST)
In-Reply-To: <5293B0F9.1050200@ubuntu.com> (Phillip Susi's message of "Mon, 25
	Nov 2013 15:20:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2DD39BBC-5611-11E3-9257-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238344>

Phillip Susi <psusi@ubuntu.com> writes:

> I can't seem to find a way to invert the meaning of a pathspec given
> to git log in order to find commits touching anything BUT a given
> path.  Does such a thing exist?

Not yet (look for "negative pathspec").
