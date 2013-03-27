From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Composing git repositories
Date: Wed, 27 Mar 2013 10:16:53 -0700
Message-ID: <7vobe4n4oq.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:17:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtyV-0003tl-Le
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab3C0RQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:16:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab3C0RQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:16:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BE71909E;
	Wed, 27 Mar 2013 13:16:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fAnhptx7PMKi1QuSNOCr6WfhWvI=; b=tjsd/C
	VXAkKSdVnSFpmnKX7gNuAGTpPJiqq2sAknIQO0o6WHXe5l5T/ICIsffdLDg7lZ4d
	2L6i+FsmPQUe+RVOTVZQkNiZUsEjt6V6cz42iIe+u4eJvTvZt+iFEEnJkyK5HGVA
	h2X/zWqGlNg/UVsPNKavZL5LtmQSvOIN715RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lFgH6RPCaqPjMhbApSHIvtXnCiqcVeZq
	cScWPELp3AM9wF2vV8Se0pgAMLnCwwUNxBS+6BvfW4nTnVyNhAGtk4YSOJtfVwpl
	GVPV3Ez7dPE/21fUhVrWzaSoxzMKWyUXGxtDfFkKr5ye6sznffVa/99llHq1bhPU
	+PEvYKUvcyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E1F8909D;
	Wed, 27 Mar 2013 13:16:55 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 866C39099; Wed, 27 Mar 2013
 13:16:54 -0400 (EDT)
In-Reply-To: <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 27 Mar 2013 22:32:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F4FC5C6-9702-11E2-A6EF-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219282>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Sorry, I'm deviating.  I learnt why you think the hack is necessary
> and not "too wrong".

OK.

> As I explained above, the entire design is
> asymmetric and inelegant; I think we can do much better than this.

I personally find the "explained above" part making not much sense.
Maybe others can comment on it.
