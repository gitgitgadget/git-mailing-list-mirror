From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a corrupted repository
Date: Thu, 19 Mar 2015 14:49:37 -0700
Message-ID: <xmqqlhishd3i.fsf@gitster.dls.corp.google.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072844.GA25191@peff.net>
	<xmqqfv90iwjj.fsf@gitster.dls.corp.google.com>
	<20150319205147.GA7775@peff.net>
	<xmqqvbhwheb6.fsf@gitster.dls.corp.google.com>
	<20150319214707.GA8680@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:49:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYiK0-00071e-5W
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbbCSVtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:49:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750776AbbCSVtj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:49:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9DBE41337;
	Thu, 19 Mar 2015 17:49:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hezm1rtl1IxYxtW0lEhp2vP5Qlg=; b=MFaMbl
	11FDamwleGtpC8R6n/84RGKuFhtBaopM4as5XG9APpeGK0BdZmj6CJMszz2P/+Y1
	njQa1emQzdw643tnHj7+iDunlIGO2IU94fjxTRc3LdsoGTTItlFgy7EUi5Q54pez
	vwB01Q53Yj5H2SvoeDQTdS62DPxy2aet9ahv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SI+rDi5X0KSPKNEqUt4kLlRDa7eEp0LH
	d4vZFLkjoVfyWn/Z6lgOoExVECRQCKBU4qrEEheL1APleOH0wsvoHn1XP7PjI9Lv
	mVrKs7g0IZRK75R/F1xbo1R9cA7sH0+J/HrAFRBb57rbGCpzxEhdXo/FyDVonTZu
	McFP1SKON5o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D283041336;
	Thu, 19 Mar 2015 17:49:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E71F41334;
	Thu, 19 Mar 2015 17:49:38 -0400 (EDT)
In-Reply-To: <20150319214707.GA8680@peff.net> (Jeff King's message of "Thu, 19
	Mar 2015 17:47:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D72B3096-CE81-11E4-A52F-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265841>

Jeff King <peff@peff.net> writes:

> So I'm inclined to leave it (we do confirm with the rev-parse call at
> the end of the setup that our packed-refs file is working) unless you
> feel strongly. If you do, I'd rather go the route of sticking each
> corruption in its own separate sub-repo.

No, I don't feel strongly either way---otherwise I wouldn't be
wondering if it makes a difference, but explaining why hand-crafting
is a bad idea (or the other way around).

Thanks.
