From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/21] check-attr: there are only two possible line terminations
Date: Fri, 15 Jan 2016 13:29:53 -0800
Message-ID: <xmqqwprafs4u.fsf@gitster.mtv.corp.google.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-6-git-send-email-gitster@pobox.com>
	<20160115191611.GB11301@sigill.intra.peff.net>
	<20160115193640.GA19291@sigill.intra.peff.net>
	<xmqq60yuh74w.fsf@gitster.mtv.corp.google.com>
	<20160115212300.GB29698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 22:30:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKBwY-0005bd-CM
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 22:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbcAOV35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 16:29:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753019AbcAOV34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 16:29:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6D533BD5E;
	Fri, 15 Jan 2016 16:29:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v43eGTfx1GqosafNPLc4EyKgq+Q=; b=nXgWOn
	ae+1Si51EWS1nrH2zrvVm9RM5Sp4Ca6uitunyti+qM6wfERxH/P9J+TG951vtcaf
	1gMsqPrMHIjZZDsMkYTbgNsOYQZfoumKTdAfgW/dePSzwr3GVO7gUIstDdinoGGD
	ajs29d4yzdxXux82kPcX7eSeFnZn3qbya78iU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RyoKohw2Umsuoi4qkt3s6hNScn1/4iXL
	3QiB7SG0WjFRKQx95yF1vo5YOW+/tWg28SASqL3Z5Z5cIsBtXBKGOiNLMvCEePl+
	lEDOYL7l06XWYwrM/PoGvdhCFZ0Oa6JD08p4ml1T1gj27IOgVH6SJpgOCPCDRfDc
	DdymY8aLCW4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D9F63BD5D;
	Fri, 15 Jan 2016 16:29:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 215323BD5B;
	Fri, 15 Jan 2016 16:29:55 -0500 (EST)
In-Reply-To: <20160115212300.GB29698@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 15 Jan 2016 16:23:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1EA5FECA-BBCF-11E5-AB9E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284220>

Jeff King <peff@peff.net> writes:

>> Sounds good, but I'm in favor of leaving this as an unrelated
>> clean-up that happens to touch the same area.
>
> Would you prefer me to hold it and send it later, after your series is
> merged, or just rebase it on master, have it graduate separately, and
> let you deal with the conflicts?

If you give me a choice, then I'd take the one that leaves less for
me to keep track of ;-)

Thanks.
