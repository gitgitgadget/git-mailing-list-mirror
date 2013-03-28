From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git subtree oddity
Date: Thu, 28 Mar 2013 09:03:56 -0700
Message-ID: <7v38vfwlxv.fsf@alter.siamese.dyndns.org>
References: <CAH0ocawbOX8C7_EaNFc2PiFT8cnpSJyPD+-8RLDL1S0SX-jQvw@mail.gmail.com>
 <A344B55C-0796-4739-8F44-F7BA26EA4B32@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Taranowski <tom@baringforge.com>, git <git@vger.kernel.org>,
	"David A. Greene" <greened@obbligato.org>
To: Stephen Smith <ishchis2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:04:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFJU-0004E6-QQ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479Ab3C1QEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:04:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268Ab3C1QD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:03:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C77AFA0E3;
	Thu, 28 Mar 2013 12:03:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mR0pq4cZkm2XRZtx1jvUxybWVno=; b=dWrjzz
	/5QSzrUAg34IZTlvkhZ5wQkiBla+gK0Gk3zgChu/AOpOqX43ABBqAxO5b3u6mInh
	cld79CTt3ycBjcQ/KT0IDG+pymwX19293Tcs9INQKJlxragoJjy3JCmb+V8njKF2
	4NOJI6oYTWDXUXLFyO2G1O+F0y7GQcRH0TU0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RnXoZiAX+DrgbsUcm5OPAC1Bpw1HsWWO
	Wi0pTnQGYwPIgcHiTTGHQLLzH3ZMTu9HZIxFkG39d0bdGuxDJoFT+0JAIzX4MiCA
	nkzM/PNz1F5XWv/bT3lrvF6kIb90ieIKDsf7Jq+BizcW7I0xhWRIU74u+YIMZCtA
	nNhJpV8u8gs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB79AA0E2;
	Thu, 28 Mar 2013 12:03:58 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 220E9A0E0; Thu, 28 Mar 2013
 12:03:58 -0400 (EDT)
In-Reply-To: <A344B55C-0796-4739-8F44-F7BA26EA4B32@gmail.com> (Stephen
 Smith's message of "Thu, 28 Mar 2013 06:34:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 192E36B8-97C1-11E2-AA6A-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219418>

Stephen Smith <ishchis2@gmail.com> writes:

> I built v1.8.2 last evening and found that the subtree command
> isn't supported.  What version of git are you using? And where did
> you get it?

We have been carrying a copy of it in contrib/ but I have to say
that it is in a sorry state.

After the original author stopped working on it, a new maintainer of
the subtree project picked it up.  Some vocal users wanted to have
it as a part of the git-core tarball, with a promise that it will be
supported and maintained, and that is how we ended up carrying a
copy of it in contrib/.  We see some discussions and patches sent to
the list from time to time, but I haven't been getting anything
definitive from the new subtree maintainer for whatever reason (if I
understand correctly, it is not his primary job; perhaps he is busy
with other things) and the part of that contrib/ tree hasn't seen
much activities.  Also I occasionally see end-user questions here
but I have a feeling that many go unanswered by area experts.

I am starting to regret that I caved in and started carrying a copy
of it in contrib/.  It probably is a good idea to drop it from my
tree and let it mature and eventually flourish outside.
