From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Sun, 24 Feb 2013 01:03:44 -0800
Message-ID: <7vfw0m5bin.fsf@alter.siamese.dyndns.org>
References: <1357885869-20815-1-git-send-email-cyliu@suse.com>
 <50EFD066.60501@redhat.com> <50F0402A.1000108@redhat.com>
 <20130111164730.GA7921@sigill.intra.peff.net>
 <CAE1pOi0zc+d6d9Y4KViX24qHgc1WL9atmRuyygorX_DQMj69Hg@mail.gmail.com>
 <20130111185417.GA12852@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 10:04:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9XVH-0001az-OQ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 10:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab3BXJDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 04:03:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab3BXJDr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 04:03:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0FFF9BEE;
	Sun, 24 Feb 2013 04:03:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=j9WvHtS3c58G+PD0t+rqW8aemZc=; b=e7LrMGVBbD9RSrfXuDrs
	0g2pe816Xsjib/5filqfP4fpLlC2kx/35k85dCmX0cKVL2W6E6tn3C8LhYksk6PU
	iYZysyoUr5XW4I6NxqZAPOFQd0jfoJh09LUCZ+uPbZA+a7WG6aKRifK4cLChEX4w
	RM4rZFoQLdqQl1uVPaJgJUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=K2slrVI3891igk36+gGudXsCV5cIHup5TdNanSpUqTDc1j
	3Ii7q6LdZZuwJ36Ki51kJrNeLuOVQ3I+0HV8qVueDcV7TB6m9Vacb5tctAdDtIiw
	1GBO3LAJ8MefZWpg7DADDRtOPzKntgqF0vjHu0oY6jZNBpQXneDm2KLteWfyE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A64FA9BED;
	Sun, 24 Feb 2013 04:03:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C9819BE9; Sun, 24 Feb 2013
 04:03:46 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18770282-7E61-11E2-8F56-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216983>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 11, 2013 at 10:43:39AM -0800, Hilco Wijbenga wrote:
> ...
> More seriously, I agree that re-wording the question is a reasonable
> thing to do. I do not use send-email, either, so I don't have a strong
> opinion on it. The suggestions you made:
>
>> How about "What Message-ID to use as In-Reply-To for the first email?"
>> or "Provide the Message-ID to use as In-Reply-To for the first
>> email:".
>
> seem fine to me. Maybe somebody who has been confused by it can offer
> more. At any rate, patches welcome.

Has anything come out of this discussion?  Is the current phrasing
fine as-is?
