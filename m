From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Working directory managment
Date: Wed, 28 Mar 2012 08:13:19 -0700
Message-ID: <7v7gy4yd0w.fsf@alter.siamese.dyndns.org>
References: <BLU0-SMTP1958653CC391F120060F8B6B14A0@phx.gbl>
 <7vd37yj7h2.fsf@alter.siamese.dyndns.org>
 <BLU0-SMTP479C08A291DA7BEA81F1875B14B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anjib Mulepati <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:13:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCuYw-0000hD-6i
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758201Ab2C1PNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 11:13:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755707Ab2C1PNV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:13:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DE3B5AB0;
	Wed, 28 Mar 2012 11:13:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OHuoSpvBBVG8w7oihFLKpaMiUc4=; b=p0k7mK
	TeVScew7znn09pUtmEz/lqcaONY0zGwrcNRTi1fSppsmaIc/wjnZnwKfK116TqOy
	0xforzgKaK0yqRfOjz5HwhxphrDQs61PFP2SRGLY1soVxJxFF+b2ITJ4RSObv8UU
	OsZKzzUdxeCXyTcyxkDrT4g3XdXfU02KyXlAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wbTsWFbVA+iDnX3DEGwu1iiMjlKdZmam
	jd6z5Ojcpf9Hh+BF01hUL1V4FM1hvOf5hVE4Kct8ToYqsbPOYFNKcLmyMiE7cS4C
	03uQxOm51lCfFD/Q4E4RKs2BrFUbIgklwQH7+ucp6q6gODEqdem0UB2Iduvj6Eri
	CUXu1ECfPqU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 249B05AAF;
	Wed, 28 Mar 2012 11:13:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B08415AAE; Wed, 28 Mar 2012
 11:13:20 -0400 (EDT)
In-Reply-To: <BLU0-SMTP479C08A291DA7BEA81F1875B14B0@phx.gbl> (Anjib
 Mulepati's message of "Wed, 28 Mar 2012 10:10:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DF6E8C6-78E8-11E1-9F0D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194128>

Anjib Mulepati <anjibcs@hotmail.com> writes:

> What does it mean by this " Files in this directory are often removed
> or replaced by Git as you switch branches"?

Don't you already have an answer from me in the message you are responding
to, which you quoted but perhaps you didn't read?
