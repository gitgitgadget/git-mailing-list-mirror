From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch 3/5] Create html documents for all files in
 Documentation/RelNotes
Date: Sun, 07 Oct 2012 13:53:32 -0700
Message-ID: <7vmwzyovg3.fsf@alter.siamese.dyndns.org>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
 <343092834.269729.1349538958985.JavaMail.ngmail@webmail08.arcor-online.net>
 <20121006192105.GA17895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker66@arcor.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 22:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKxr7-0007wa-CJ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 22:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab2JGUxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 16:53:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab2JGUxf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 16:53:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D187195E8;
	Sun,  7 Oct 2012 16:53:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AVtibajoCP94hIzfrdc2p/nlYBg=; b=c0mXeZ
	a1WZDZCuLUWmC5sZ0uXy8MbxOysdi3Ppba707KdBIGXAKX9C3kM5xd6kVGp6rBxQ
	333KhYIkBZqUJMwpY1ajRbR5b0yjDRylcxlMRVGgnZYzlv4E8fhZmv1GxkGmu64I
	SAU5TpKF1QA2lZa5JAP0bxlT5DHt847BcswKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k/zmTPHac5RS81QqNmXMBqasBWk+KvGy
	eESnqh/63Ak6cZgp87E/w1F+iwBLm2F8G5SPGt6GJ3nRnPXtQLTHw4KQ4csxp1+T
	PimlXOq3F9zL+qxtZ7331HgVNF1HEFQlIvkLEWiL/1X9lm17HAlTsuKQVYLkmOyQ
	52Mwfn7NNVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFD2695E7;
	Sun,  7 Oct 2012 16:53:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3511B95E5; Sun,  7 Oct 2012
 16:53:34 -0400 (EDT)
In-Reply-To: <20121006192105.GA17895@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 6 Oct 2012 15:21:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F143BFA-10C1-11E2-951A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207196>

Jeff King <peff@peff.net> writes:

> [1] I would not be surprised if they do not actually format all that
>     well. Though they are written in an asciidoc-ish style, they have
>     not traditionally been formatted, and I suspect there are many small
>     errors (like improper quoting of metacharacters) in them.

They aren't even "errors". As far as I (who writes the release
notes) am concerned, they are straight text without any asciidoc
or markdown mark-up.
