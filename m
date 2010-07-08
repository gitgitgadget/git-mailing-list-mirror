From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.2.rc1
Date: Thu, 08 Jul 2010 12:40:07 -0700
Message-ID: <7vd3uxpxt4.fsf@alter.siamese.dyndns.org>
References: <7vhbkk3vm7.fsf@alter.siamese.dyndns.org>
 <vpq4ogaxurv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwxI-0004gP-DH
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758447Ab0GHTkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:40:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab0GHTkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:40:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BFD9C22DA;
	Thu,  8 Jul 2010 15:40:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=a9MbDudv+KCCTLYTzDJWb3Zybbw=; b=rrpeCoQSY+0+LvCOjuidbQH
	okHJYX6OFsqtqGW4/bIdwzZcVw05+PL3sqV+WCHF3VOFm+JOHT5aJ7qpf/9vyivV
	+lYHI3FOqFkC5B90JIDZH5ANj5EsZZwI/jEX/ZIgkqa/oGc5EsE+lCzpmtiVGoMr
	PeWMw2e16ST92Z2/SaPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yhZVuDLFmaHmoTrOchSIhan1MaMRsyMLjdAh6Rv3EFOIpAXqk
	6+BzKhZqVGJZQXDTzb61eJKpiJwBRXsPYk4/+/jBJ6ZI+skzO/Fsaoih2FSfmlad
	xX8zOYcW5p4sW7wbar0dEB/RblybppcFVoXoegESc84K2jUH5a1O0A14o4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 580ECC22D3;
	Thu,  8 Jul 2010 15:40:11 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6596C22CF; Thu,  8 Jul
 2010 15:40:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F31C152-8AC8-11DF-9376-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150606>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Updates since v1.7.1
>
>>  * "git blame" applies the textconv filter to the contents it works
>>    on, when available.
>
> I think you forgot to mention "git cat-file --textconv" (branch
> cp/textconv-cat-file). How about

I wondered if that particular addition to a plumbing command is such a big
issue to advertise to the end users in release notes, and decided against
it.

> * "git cat-file" learnt a new --textconv action, to apply the textconv
>   filter to the selected blob.

Thanks.
