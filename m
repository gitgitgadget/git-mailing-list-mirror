From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] perf-lib: add test_perf_cleanup target
Date: Thu, 19 Sep 2013 13:11:51 -0700
Message-ID: <xmqqpps4sha0.fsf@gitster.dls.corp.google.com>
References: <1379419842-32627-1-git-send-email-t.gummerer@gmail.com>
	<1379419842-32627-2-git-send-email-t.gummerer@gmail.com>
	<xmqq7gefz6m0.fsf@gitster.dls.corp.google.com>
	<87fvt1ghr4.fsf@gmail.com>
	<xmqqk3icu3u8.fsf@gitster.dls.corp.google.com>
	<xmqqtxhgsi5p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@inf.ethz.ch
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 22:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMkZy-0000vH-8d
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 22:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab3ISULy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 16:11:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774Ab3ISULx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 16:11:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6300D431C7;
	Thu, 19 Sep 2013 20:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=whlUNeyNLbPFhhgAZIRs/XC9vVU=; b=L3wPxS
	DDfif1Hw2CMW8XoaTiNfpgBpCf4/OSQiOU/WYXNeA+DEJ/v03wpg3manc0WKd1Cq
	98IeCzABpseEbxStyg4vV8O5tLmY5aG+GIiTsr1fuNH2YC+ZIhQcvdxf1nWXUtmh
	KBJIplA/4l6TxuISNMOyby/JrRRs23EahHVXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fqBH50Vfsprvn84KrwHKr15Ek5Gk4Zl/
	nO17beadv3CWsyOCPPwW5K3W062BBIcQoBfsXL4CeSgNmA8sczstjUmxnLi6Infd
	QwRHwPK6dZUhA0cp8ux/wizFW5AU3FapFvx7nHgWMnulcPWLZ4qAJ2OUm3cjQo+h
	BJokuXmv1rM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5914F431C6;
	Thu, 19 Sep 2013 20:11:53 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE116431C2;
	Thu, 19 Sep 2013 20:11:52 +0000 (UTC)
In-Reply-To: <xmqqtxhgsi5p.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 19 Sep 2013 12:52:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B9684B52-2167-11E3-A79F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235029>

Junio C Hamano <gitster@pobox.com> writes:

> I wondered why this clean-up section cannot be an optional parameter
> to test_perf, but that would not fly well because we won't know if
> 3-arg form is with one prerequisite and no clean-up, or no prereq
> with a clean-up, so perhaps adding a new function may be the best
> you could do.
>
> But in the longer term, I think we would be better off ...

In any case, will queue your version as-is, at least for now.

Thanks.
