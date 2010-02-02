From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 16:53:58 -0800
Message-ID: <7vk4uwmp95.fsf@alter.siamese.dyndns.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru>
 <ron1-6F8B85.14520801022010@news.gmane.org>
 <7vwrywplxz.fsf@alter.siamese.dyndns.org>
 <ron1-ABA66E.15563101022010@news.gmane.org>
 <20100202001530.GL9553@machine.or.cz>
 <ron1-9A9CEA.16452601022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 01:54:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc72I-00022n-GW
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 01:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab0BBAy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 19:54:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab0BBAy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 19:54:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D29196BD4;
	Mon,  1 Feb 2010 19:54:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RyVwBkI5XCuObF3iTuGFKAUZwr4=; b=W9WQEl
	m8On4SeY9H8RXycAYl5pChK5bFoV2GWBqwRNM79oUCS5/TEBGNYNpvZZuWHjDjzp
	KXl/FECq2Hage6c76yCDPWvB6n7LOc8IQ0G4svlrjLX/ipxJaQVpTaJHxZW7LiDU
	V0yWfwKAGbyqsUtxbFk5egjNv4kkL3GlVa504=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D4MYQkSqZ7V1wVfzQTTWzaY4jPSETwju
	sXTqbiDi0cnkNORLCHXZfkdibM0/q4pfZb+iDoVLWT0nZIAByZJkcmxPpw3zy6i+
	HF4G9dvtEMnPuak5N+n10huIrlVuzyRJLGpv4onz66SVR9+KRvwRrmdNan7fbKUq
	fLT5rXDRc5A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC68096BD2;
	Mon,  1 Feb 2010 19:54:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A908E96BBB; Mon,  1 Feb
 2010 19:54:10 -0500 (EST)
In-Reply-To: <ron1-9A9CEA.16452601022010@news.gmane.org> (Ron Garret's
 message of "Mon\, 01 Feb 2010 16\:45\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81F66204-0F95-11DF-8FD4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138668>

Ron Garret <ron1@flownet.com> writes:

> The manual specifically contradicts you, so either you are wrong or the 
> manual is wrong.

In case you haven't noticed, Pasky is one of the old timers and he knows a
thing or two about the git's world model.

And I do not see a contradiction in what the manual describes and "a
branch is a named pointer to a commit" (although "named" can probably be
omitted as "unnamed pointer" is not useful at the UI level).
