From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http_init: accept separate URL parameter
Date: Wed, 12 Oct 2011 15:38:27 -0700
Message-ID: <7vk4897s4c.fsf@alter.siamese.dyndns.org>
References: <4E95FDC8.5030009@drmicha.warpmail.net>
 <20111012214316.GA4393@sigill.intra.peff.net>
 <20111012214610.GA4578@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 00:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE7Rc-0000lW-O7
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 00:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab1JLWia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 18:38:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab1JLWi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 18:38:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64FF067E5;
	Wed, 12 Oct 2011 18:38:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1MEepplKio7VR5q6RhbWJI67C5E=; b=kdzaWG
	My0VTRwhEqwNrYckgrxFe+J4wecB8JKd9DUa9zyx83PsVN1vGQXJvLFvxY8/UdRp
	xT1tBYoBjjfwwwrT9OX3qvnewCP+1pWLahmQ0RaLlK3gl2jzsZ7fhviLUAqdqMHN
	dhvnStvOwXT7lCjDGPb0guiFfaEoKnnAm3jg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ph5gl6cmXxSxuyEzgM+QTkDT89zJyJL/
	rjbciteKItkvMeSVAjv+34VZ7j0FimJLIuF8vtpAKUVA4WVlMPflnxluO7IBaLDb
	lnhTJEWxzl/wJR2eWuesZ6lFOQ+KBYvLPJV5a9xXTStGls5F4q8M2yiejpPh/3EU
	5TNjVDiVubA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DED567E4;
	Wed, 12 Oct 2011 18:38:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E81F567E3; Wed, 12 Oct 2011
 18:38:28 -0400 (EDT)
In-Reply-To: <20111012214610.GA4578@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 12 Oct 2011 17:46:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7E8F1F2-F522-11E0-8A5E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183427>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 12, 2011 at 05:43:16PM -0400, Jeff King wrote:
> ...
>> Instead, let's just add a separate URL parameter to
>> http_init, and all three callsites can pass in the
>> appropriate information.
>> 
>> Signed-off-by: Jeff King <peff@peff.net>
>
> Sorry, I forgot to mention: this is meant to go on top of the
> http-auth-keyring topic.

Hmm, of course the patch was written to help http-auth-keyring topic, but
wouldn't this be an improvement that is general enough?  I.e. it could
even go to the bottom of the topic, no?
