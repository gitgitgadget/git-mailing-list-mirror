From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git alias and --help
Date: Thu, 27 Oct 2011 21:05:57 -0700
Message-ID: <7vvcr9wyje.fsf@alter.siamese.dyndns.org>
References: <j8clg9$ldh$1@dough.gmane.org>
 <7vfwiexe6m.fsf@alter.siamese.dyndns.org>
 <7v8vo6xd4u.fsf@alter.siamese.dyndns.org>
 <buoty6t9937.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gelonida N <gelonida@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 28 06:06:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJdiP-0005Ur-6t
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 06:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740Ab1J1EGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 00:06:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715Ab1J1EGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 00:06:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FB1F5994;
	Fri, 28 Oct 2011 00:05:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W3fUVQkbTjJpbAB+yh1cZEL/VGY=; b=mSRfPy
	Bt0ednRKMHl50UbG7PnxZjigUNy751cKOc15t4dQ+T9R1wwMf+4XyyesnivWINDB
	J9/VWkvXLhDvTFCIWfjTHMCMUrFaAdQdCRkrEoum7Jt7qgNYM+w0cWV7EaxEEFMM
	A/cXEI01oLLEPk2km6MmV535FKGtxTpr5SWps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qk28t+H4ZuJyRlgE28SICyXEQdBX+O/G
	Uur8G1HjGlSx3lUQz/uXeDE7og5UDeH6Hv1QeGsBurQzPbj3wI6ZvDI9JBrn48vF
	cLqwgOVYH3RBeeWO2yj9wCY8fb7BmZ6uX0i5r0ZRHuH+UghyIyh0xgL4TV1UBqv/
	Jbmp/tHVo2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76B195993;
	Fri, 28 Oct 2011 00:05:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C2F75992; Fri, 28 Oct 2011
 00:05:58 -0400 (EDT)
In-Reply-To: <buoty6t9937.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Fri, 28 Oct 2011 10:51:56 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 247A7444-011A-11E1-91C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184337>

Miles Bader <miles@gnu.org> writes:

> Of course, that would be the wrong thing for somebody that just wants
> to be reminded what an alias expands too, but my intuition is that
> this is a very tiny minority compared to people that want to examine
> the options for the underlying command...

And it is doubly wrong if help backend is configured to be anything but
manpages, no?

As I said, you should be able to come up with a patch that detects and
special cases the no frills case (replacement to single token) to get what
you want.
