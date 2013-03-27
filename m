From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Wed, 27 Mar 2013 13:50:29 -0700
Message-ID: <7vd2uklg8a.fsf@alter.siamese.dyndns.org>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
 <20130327203535.GA5220@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:51:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKxJF-0005fP-DP
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab3C0Uud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:50:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab3C0Uuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:50:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D753BAF95;
	Wed, 27 Mar 2013 16:50:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0sgZzfu8u6ZFuAch9HGCUyOkHFU=; b=r6mlfF
	jlhlSdLSi1ouohUPjC4nnXAYC0u+aza1PJdBG/bzFSmDBP9w+cRwT2LG812vNiF3
	DGCyk/32k864UV6ZtOvbxz9PiwNfmM1l+bMWE4vSCdBDELIHV1oSvAGSVujVpwu3
	hiQ1tyNEBITuncJrcUVfF+L71JgyWQ2UhmC3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bWM+gYQoEVVw0B/wZBQYB03xsqC6wTkb
	18jndEsOeQBozT6R2kLFTy4dNQMZzbGHWO0wh1t+pXTHkqG4BmJ9D6qD9YRMrtcJ
	zwgGm7bXmGjvh0qjxH4CDvC6iBYjodn/+RcExmnSWbQhNgC7n0tN8S3jO+bfNCJs
	ZLLvTaIh3BQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC4EFAF94;
	Wed, 27 Mar 2013 16:50:31 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53579AF91; Wed, 27 Mar 2013
 16:50:31 -0400 (EDT)
In-Reply-To: <20130327203535.GA5220@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 27 Mar 2013 16:35:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6B6AE72-971F-11E2-94D2-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219329>

Jeff King <peff@peff.net> writes:

> I was kind of surprised to see this still in pu, too. I thought it was
> supposed to cook in next for a while to shake out any interoperability
> bugs (and it was in next previously). Did it get ejected after the
> release and then never put back?

Yes, I've been trying to concentrate on flushing safer and older
ones first to 'master', and I _think_ I am more or less finished
with that as of last night.  Many will come back to 'next' in
today's integration run.

>
> -Peff
>
> PS I notice John Keeping has become quite active these days, and has
>    stolen my initials. It makes searching for my topics in "What's
>    Cooking" much harder (I read it linearly, but I take special notice
>    of the "jk" topics).
