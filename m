From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] second try
Date: Mon, 17 Dec 2012 12:08:13 -0800
Message-ID: <7vehiol9w2.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
 <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de>
 <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org>
 <7vmwzzqwud.fsf@alter.siamese.dyndns.org> <509FD4F6.5050606@gym-oha.de>
 <50B11AF5.2090701@tu-clausthal.de> <7vtxsdvug3.fsf@alter.siamese.dyndns.org>
 <50CF4020.4090901@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:08:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkgzL-0008Qx-06
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 21:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab2LQUIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 15:08:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56969 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab2LQUIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 15:08:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15F8C9CB3;
	Mon, 17 Dec 2012 15:08:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z9wqK8jdLpPDryBZVrG2khdkL9Y=; b=RQU8RX
	D8xR95mbGp5VO5CkLliemaoaDHacL5ebNTvRwSUaCq5WK12c8XmH3qs3UOZjWqFw
	AkLaaoxtGEhoy0dGppB4Ds8BKjLIGP+trlRq1aMi5oKSMoLI/mQFEg7i2BC0K58O
	YnZeAmIgWp6rnG9WK/o/r9Vye6yYDYy6ZABFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=defADOL+hTNJrxdPxasDMScwQEcfouwV
	9F0nE9fJTiCB9fW8QQuUFbolYOsEeS2F6x0d+BW0ygH6CxMZAYUyumxsA//QFbKY
	/xH2/EoEfKCJEvM6va5HCn0FqPlOXD7eHGQqsVfTAwEL4HWkE0X6dB3fXYPjDebn
	sS9GvpoqaFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 012EA9CAC;
	Mon, 17 Dec 2012 15:08:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 596069CA8; Mon, 17 Dec 2012
 15:08:15 -0500 (EST)
In-Reply-To: <50CF4020.4090901@tu-clausthal.de> (Sven Strickroth's message of
 "Mon, 17 Dec 2012 16:54:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DD8DF2C-4885-11E2-A48D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211699>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Am 26.11.2012 05:50 schrieb Junio C Hamano:
>> I think between Peff and me it fell in the cracks during the
>> hand-off; I do not know about the others, probably people did not
>> find it interesting perhaps?
>> 
>> I'll add Eric Wong (git-svn submaintainer) to Cc.
>
> I received no feedback, so is there any progress on this issue?

I took a look at it, and from the code-cleanness point of view, I
think it loos more or less right, even though I'd prefer to see the
"fall back on SSH_ASKPASS" bit as a separate patch, either before or
after [1/2] that moves the logic to a separate helper function.
