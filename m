From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitignore.txt: suggestions how to get literal # or !
 at the beginning
Date: Sat, 06 Oct 2012 11:25:16 -0700
Message-ID: <7vr4pbqwz7.fsf@alter.siamese.dyndns.org>
References: <20121006132127.GC11712@sigill.intra.peff.net>
 <1349531484-5938-1-git-send-email-pclouds@gmail.com>
 <20121006154036.GA14119@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 06 20:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZ45-00070O-Q8
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 20:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab2JFSZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 14:25:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab2JFSZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 14:25:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 087B29033;
	Sat,  6 Oct 2012 14:25:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=67jDyKqm+U3c28nKuwa/dQUpIvU=; b=lTvvqG
	flKPTq1X2IJJLnP2q6Sf4ucGopGXgFbEO8KSvm2B5lqdg907xi9ogWjC0xcsld5a
	6/bb6KsymLdg7gAXxhjNGv6XufZ9aB2uu7cH/Geapq7uXHWpHmVDIT+hEvaJZmUl
	YD4/82nKj5HdwmfZOd+jbK+ilXLbQnBM8inSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0tfe4X4EQAa5HFp4vB/dXcrwEF6vmy+
	zM+0zMMZJd/pYu3ufz+GR73NAxYrnu5VlM6IG3TUep2n3JoSy3nranXEenLicQmH
	YwDNSNuR6XJngs/6mx+p7O7ES4V2DoReZZjPZT07N02TZs42NgrBQtwBdaoxj5oN
	hosOKUB0pGA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EADCB9032;
	Sat,  6 Oct 2012 14:25:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 672D09031; Sat,  6 Oct 2012
 14:25:18 -0400 (EDT)
In-Reply-To: <20121006154036.GA14119@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 6 Oct 2012 11:40:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E5C0760-0FE3-11E2-925A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207160>

Jeff King <peff@peff.net> writes:

> I'd be slightly worried that we are hurting other people who do care and
> are on older versions of asciidoc. It would be nice if we actually knew
> the cause of the different behaviors we saw and if there was a way to
> work around it (it might not even be old asciidoc, but rather old
> docbook).
>
> Part of me wants to just take the change and see if anybody complains.
> But that is probably the wrong thing to do, and just my general
> frustration with our doc toolchain talking.

Yeah, I do not think we would want to introduce such a regression
especially when the proposed update is not the only (or best) way to
give us the intended benefit.  I think the "spell the character name
out" approach you showed in the other message was far more readable
anyway.

Thanks.
