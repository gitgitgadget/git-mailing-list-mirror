From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow passing of configuration parameters in the command
  line
Date: Sat, 20 Mar 2010 09:20:02 -0700
Message-ID: <7v634rj77x.fsf@alter.siamese.dyndns.org>
References: <81b0412b1003190742v6e5577c9wb121d5e3cbc9fccd@mail.gmail.com>
 <7vbpejkmo5.fsf@alter.siamese.dyndns.org>
 <81b0412b1003200903gb6923e1ved6de423db97b28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 17:20:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt1PV-0004Fk-Nq
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 17:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab0CTQUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 12:20:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0CTQUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 12:20:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 775DBA3313;
	Sat, 20 Mar 2010 12:20:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5uVbTNC66i21FxQn2cSoy0BfaQA=; b=kyXawy
	QucDi02VmwgykGMzGerXOINeJJa6+kEx+sff2I8sQyUDM1LR7Ncvai8FXo91hVOI
	1/KNeWdx8rN7jlo29+LVyRGo9gmRDuXq//jtwq2GSeAP4kr9aY5PCUFfo+S7JmJE
	LXQUvuvEHaVncLq10yakleo7j+0HdtODu23WA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KdK/Hh38b6PtWVJLCx1RgLqVuewf5Xtc
	UwjGV4wEMzsQq62eSOUopFkB+HcO1CYKuBrMn9whcMxTgkPZTwcfcRXXxCl4zN8R
	TrvpihrutXGx03td1K1pg+9ROS7hf1AhQO7TJ6lxqmRfDOfBLtHhbJbNlpWHutSX
	b0sXzspeU7c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20278A330E;
	Sat, 20 Mar 2010 12:20:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CF4EA330A; Sat, 20 Mar
 2010 12:20:03 -0400 (EDT)
In-Reply-To: <81b0412b1003200903gb6923e1ved6de423db97b28@mail.gmail.com>
 (Alex Riesen's message of "Sat\, 20 Mar 2010 17\:03\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 750F3D4C-343C-11DF-80E1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142726>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Sat, Mar 20, 2010 at 17:00, Junio C Hamano <gitster@pobox.com> wrote:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>>> The values passed this way will override whatever is defined
>>> in the config files.
>>
>> You sent MIME multipart-mixed and I am getting a broken patch.
>>
>> How could this be... If I cannot expect to reliably get a non-linewrapped
>> patch, there doesn't seem to be much point in you and I taking extra time
>> to bother with MIME.
>
> That's gmail, again. There must be an attachment with a normal patch,
> but I'll resend.

I think it was coming from duplicates.  The attachment was fine, but the
normal part was wrapped.

Applied with a manual fix.  But thanks anyway.
