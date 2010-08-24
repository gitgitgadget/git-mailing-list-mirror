From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] shell: Rewrite documentation and improve error
 message
Date: Tue, 24 Aug 2010 12:01:15 -0700
Message-ID: <7vaaobvnr8.fsf@alter.siamese.dyndns.org>
References: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
 <AANLkTi=u7VUhz4VrU2hdd3SXK7rMvMrijL-X9qXCG1vs@mail.gmail.com>
 <20100822080359.GB15561@kytes>
 <AANLkTintw7=25nsr-7NjE_-xJqMab_HggjPOtSHBf109@mail.gmail.com>
 <20100824053647.GA2037@kytes>
 <AANLkTikeZTF5zZyRDtLfnPrtCYFH0WayXrJeCj8_VuC1@mail.gmail.com>
 <20100824123525.GA18641@kytes>
 <AANLkTikqoELMOxjdtzvrFTgyHK0dLCZLrwt2NhCSUDL5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Aug 24 21:01:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnykW-0002uP-PQ
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 21:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086Ab0HXTB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 15:01:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab0HXTB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 15:01:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1E56D0B19;
	Tue, 24 Aug 2010 15:01:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=twx9ZnwZ07Iaf+P/kgpDFVgRoEk=; b=ibRP3W8N4AT0o7JT2816Mss
	AGn0O8RDikjR0bxHXd6J1uD8+kf/vTJIxFcfD/nhfDrTBTtNxEzbQ9HrIPqTyfQk
	v95q6BIboEIif2AquGsX0Lg9hsHNsaL8FkMShlQ9i6O7xm7WTle30rM7HwMt6P//
	9Vtq/4v+Dhy/OudGT4pI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DFSHKbVY6WJvcf9Apd0uBiRC2W9eF0GqkG7uBTfIEybvEmApv
	A6s7R1t5nfMbE2KIPdSookjiEs8uHkTMLGuiTVBeB9ToOvFFv8whjQfB+gMX8DYp
	qbHIIETRHsXVhHqfiHwbG1zMQeWX/fmLuOX/G759RnPJJ6mA+xL7tz9tzo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A72F4D0B12;
	Tue, 24 Aug 2010 15:01:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98E34D0B0F; Tue, 24 Aug
 2010 15:01:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC025118-AFB1-11DF-AE5F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154335>

Greg Brockman <gdb@MIT.EDU> writes:

>> Ugh. So sorry about this- I've been suffering from insomnia over the
>> last few days.
> No worries :).
> ...
>> -- 8< --
> LGTM.
>
> Reviewed-by: Greg Brockman <gdb@mit.edu>

Thanks, both.  Will queue.
