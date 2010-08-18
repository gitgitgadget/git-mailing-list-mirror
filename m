From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH re-roll] Do not display 'Switched to a new branch' when
 the branch existed
Date: Wed, 18 Aug 2010 13:59:03 -0700
Message-ID: <7voccz8wo8.fsf@alter.siamese.dyndns.org>
References: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
 <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
 <20100818091603.GA6263@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Knittl <knittl89@googlemail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 22:59:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlpjF-000693-6U
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 22:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab0HRU7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 16:59:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab0HRU7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 16:59:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76DF9CEE13;
	Wed, 18 Aug 2010 16:59:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IE7cgpNHUFrnkelbGerk2EfCgTA=; b=ha+gZ7
	oIq91jb/MavmK9h7tNka5iWyk5DTwWJtw9Tc5Nqr/ZgLaqODM8Cn8SmbC6gqKJZT
	ipYRL6nIrFJSsFnSOqkuuwv4iVKtGgPDRE/1FPsXbGCguqp2iQtnz4/jf9EiWjiT
	xKIAUuPfngHECnFZJpngj8Gp4WLzL5qSY4f9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KpGTATmo9bH65FH0yHr9qNTQWU+A7ktB
	8e2SbgS7W8vSU+8sEprMEr8EoH+GOqQ0LkN2Rk4UrH++YCyBwSDIrBHkWC2kp+6T
	vMnruU5HuTycNex9CYTvB36uh/eDS5yrqlrKIVcM2f+puxJ5bGuQZqyweHERFb9V
	MxG47uhrgSc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EE02CEE0F;
	Wed, 18 Aug 2010 16:59:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5690DCEE08; Wed, 18 Aug
 2010 16:59:05 -0400 (EDT)
In-Reply-To: <20100818091603.GA6263@burratino> (Jonathan Nieder's message of
 "Wed\, 18 Aug 2010 04\:16\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72B1C588-AB0B-11DF-ADC3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153885>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The functionality of your patch is obviously good.  Thanks.

In what way is it good?  I am especially worried about the word "reset"
being confusing.

You are switching to a new context to work on something else, so I don't
necessarily think it is confusing that the word "new branch" in this
message does not mean "a branch that did not exist before this operation
(i.e. a newly created branch)."
