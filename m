From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list docs: clarify --topo-order description
Date: Tue, 14 Aug 2012 07:30:25 -0700
Message-ID: <7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <877gt16ewe.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 14 16:30:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1I8i-0008Fn-0y
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 16:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab2HNOa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 10:30:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086Ab2HNOa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 10:30:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 469F26E1C;
	Tue, 14 Aug 2012 10:30:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qSPE5NRFitehQg4uBP63GlxFjsA=; b=Kn/uuj
	ysm98lK3SwxkyILUyyFzUTzgfFlw6ZNFK8dniW0Qj0CxiroczQaDMco2tttx2moT
	MMrQWyMOmLdfQxRoiidI4/8nK9Vp74F+RjI+2VPUWJfMiFwX+Wa06gvTLjLy/UFc
	Tvc+zVeKUw0gZ2i9OvNszGTpYedwTPhNnASq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fU2n6OtzZ0sMkgDps9LICEW2u2UTnkwy
	CpgnagPWYNA9jU3jJzLTfI8UmFGBzPeJnw7qtg0YV+yE9xasELGtne2ucnASHDNK
	dxynKFPzD5w0j28FzwHX1z9iYXLoZh+p5wOBv99xCHX3yQpg2dJxrn33MkoWttHT
	EQ1ik9INvHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3425F6E1A;
	Tue, 14 Aug 2012 10:30:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA7796E19; Tue, 14 Aug 2012
 10:30:26 -0400 (EDT)
In-Reply-To: <877gt16ewe.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 14 Aug 2012 10:45:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9724ADD8-E61C-11E1-BE7F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203400>

Thomas Rast <trast@student.ethz.ch> writes:

> So the --topo-order switch *ensures* that we process commits in
> topological order even in the face of skewed clocks.

Yes, I *think* that I attempted to show with the illustration.

> I suspect that
>
>> +	their parents, but this tries to avoid showing commits on
>> +	multiple lines of history intermixed.
>
> is just a fortunate side effect of the topological sort.

I am not sure if it is "side effect"; I *think* it was the "primary
objective" we added topo-order in the first place.
