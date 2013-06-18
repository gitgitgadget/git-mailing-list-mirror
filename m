From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: stop hard-coding 40-character hex checks
Date: Tue, 18 Jun 2013 07:27:57 -0700
Message-ID: <7vehbza3yq.fsf@alter.siamese.dyndns.org>
References: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
	<1371317906-3991-2-git-send-email-artagnon@gmail.com>
	<CABURp0qs7uPkczmS8EC-iNgCVh2eTaeCKsh7NwVuS4j92jMn+A@mail.gmail.com>
	<CALkWK0=_Ac+dQV23xiXty3peWdhn2iFzgSPb7LYDFmoCzYhxQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:28:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowtG-0001eA-8u
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868Ab3FRO2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:28:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932830Ab3FRO2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:28:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DEF526B18;
	Tue, 18 Jun 2013 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uu4UQ6tXPrGgvuoYf6oLkDiJNKY=; b=aqLETU
	mR3TKoHuSTJnLosGqMpvIGm8Foy+MbIqFS8ONdJIwtVwGc/GyTgcMDqusCNbUyXD
	vOACASuMb7w/6cp5ciJ6L5c3na6thxvHrqNPJG9LjCteutc4pIxVoZhLh2B89cPS
	/VHiVJfKL18lFGPXjD51pqRCAF64HgqSpYgkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQ5iO9vBa7tIHXm6Z+bq0kRDv5fsP184
	K0QFMXyGxtRXPyc4iPyMBrDY5U7HeCkJ1WzY5e5RO8mTD0Y69V8s/+PnP2y0tnhr
	Q/kRfMZTVxUAtsziLU91SM+xmi91dkahGpQ9MwnRblWbOEhUKPR5wuCPaTcpBW0S
	UKsyVYa/ARE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74C9326B17;
	Tue, 18 Jun 2013 14:27:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5D5026B14;
	Tue, 18 Jun 2013 14:27:58 +0000 (UTC)
In-Reply-To: <CALkWK0=_Ac+dQV23xiXty3peWdhn2iFzgSPb7LYDFmoCzYhxQQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 18 Jun 2013 12:33:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 464E1012-D823-11E2-91B6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228237>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Phil Hord wrote:
>> I share your disdain for the bare '40's in the code.  But I think this
>> code is less clear than the previous version with the magic number.
>
> Please read the cover-letter: 

Which was...

>> [1/2] is important.  [2/2] is a minor prettification, that wouldn't
>> have been possible without [1/2].

...and I do not find how the above is connected with

> I was just toying around to see if this
> was a good idea,...

...this in any way.  Puzzled.
