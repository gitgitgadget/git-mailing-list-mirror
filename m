From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 16:14:19 -0700
Message-ID: <7vip3npet0.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 01:14:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URsbU-0003M5-4L
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328Ab3DOXOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 19:14:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541Ab3DOXOX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 19:14:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F97416896;
	Mon, 15 Apr 2013 23:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3aMACCGCkkUADkj2OMdtRxiww9w=; b=CdhUD8
	Hw6wjst/aKgz5U+EcJMerhB5Zzbd8q1QJjW4WyIZLLIr9OmsbbBLNCmWFZ3Ei6hj
	SO/O5IT3roI46/gLhowmfS5WfQmFoD96XfMcXr9+0sVPZGrwAWeQj4Ly0+a0vDqB
	mE+M8NRQR2/oPZZSaQCuI1/CVDw6Zs08K4ppw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dn0aBckfw4LbTXNwQZ10THaP+s0TucSP
	k874ASDOxxXnIuEEuahhqmuqLrFZ1CTT+6K66rgMPNHdh9koHGMSStcmHVNKWEmP
	+weT7tzXFksF2YVosotuESnKjMOYAx1Wdz4Nmq3CTZiZOrdDZ2QBknOUGZSSjEPO
	2OKei+6VLao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2794216895;
	Mon, 15 Apr 2013 23:14:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DC2516893; Mon, 15 Apr
 2013 23:14:21 +0000 (UTC)
In-Reply-To: <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 15 Apr 2013 17:24:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3463FD5E-A622-11E2-9010-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221329>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> And about this:
> http://mid.gmane.org/1365638832-9000-3-git-send-email-felipe.contreras@gmail.com

What about it?  Is that the one you said you are going to reroll?

I do not recall the details of Peff's complaints, but re-reading the
log message of the patch itself, seeing "correctly" twice is not
satisfactory.  As you very well know, a bug description that says
"This does not correctly work!" and stops there is not as useful as
a description that defines what "correct" behaviour is expected.

If one of them said "update correctly to record what was pushed" or
something like that, that should be sufficient.
