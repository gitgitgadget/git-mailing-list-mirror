From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Mon, 15 Mar 2010 14:34:32 -0700
Message-ID: <7vhbohi80n.fsf@alter.siamese.dyndns.org>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
 <20100315213221.GA12941@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:34:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHw2-0004vg-2d
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab0COVeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:34:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab0COVen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:34:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED6CA21FA;
	Mon, 15 Mar 2010 17:34:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5e/RmaCCK0HPmjBObYrnCmDQ4mA=; b=yLpfEQ
	vOtuB79HSEpfuiPOQAOrR8/e3PijckveG1qaUTekZ6trS63K/NabcGSkhE86R3+I
	p2kYtIRm67EVS9yFDDISA7jvdVEr/a6O7Lsl3uAL33HQFl6lDSwXe50Djk0zAwhk
	cHZH5pwx++pUEZGaZCNXA7qIQ+mspjGOqfuCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nPggYb5hddVfaEmIQVFMuPVaxGW56Htm
	033HNpNs2gU/RqHYTF7bQfFFpw6AIigRsyxKfYy9u1M2AYU8IxoZmK8NPNYJ6zsV
	h0RHbj/ZVDY0ux8PdVcAuNDJUH+0KGQk4aZ6g1JA2j82RQVhgEhPtrsZXySulfzb
	0ytBPHWyJq0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76B2CA21F8;
	Mon, 15 Mar 2010 17:34:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 815F7A21F7; Mon, 15 Mar
 2010 17:34:33 -0400 (EDT)
In-Reply-To: <20100315213221.GA12941@vidovic> (Nicolas Sebrecht's message of
 "Mon\, 15 Mar 2010 22\:32\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F564B34-307A-11DF-A7B1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142257>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> The 15/03/10, Maxim Treskin wrote:
>
>> Is it possible to add comments assignment to branches?
>> Something like:
>
> Aren't you looking for 'git notes'?

I don't think so.  Notes are fundamentally per-commit.

My understanding is that it is more like:

    [branch "frotz"]
    	comment = "This is to add frotz command to the system"

I do not have a fundamental objection to such a feature, but the
presentation needs to be well thought out.
