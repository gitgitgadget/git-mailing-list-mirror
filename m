From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: handle stray $dotest directory case
Date: Thu, 13 Jun 2013 15:49:22 -0700
Message-ID: <7vtxl1sk25.fsf@alter.siamese.dyndns.org>
References: <1371133031-28049-1-git-send-email-artagnon@gmail.com>
	<7v61xivsxh.fsf@alter.siamese.dyndns.org>
	<CALkWK0mUnNTfJQuGQAoMtnsOXvXU+z+W6D_MMuio1sq4vkucjA@mail.gmail.com>
	<7vmwqtua5r.fsf@alter.siamese.dyndns.org>
	<CALkWK0kO=KY4=Y7ex47LJ2F0oEfF+R9g3REO7rddDLL4c8CuEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 00:49:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnGKg-0000t0-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 00:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759417Ab3FMWt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 18:49:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757357Ab3FMWtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 18:49:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21882270EB;
	Thu, 13 Jun 2013 22:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NibrjqksNbwyiO/VZ45thst0KQo=; b=t2A6UI
	+1SisBpskEJVHPQiHRENp3pZCa1uZcc7OpLOAWpG1V7/yVtR8+O/vNNM1arWr33p
	kZpRqJfw6MxduvM2ww7R+Uv9oRux8hVr62y8sl5LqQVEUfQ3pBoenGIZQDA7K/9+
	U1lejO3VKVw7RrSA4zUF9Ps0dpkue8GSoiooM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kEIdO2SELhpDUB0+euQSBcLcFZ+sGXIX
	rGyiDcN0dV6J/lQBPxF6Eqjytb2qj4kwnWnz9ZSc+Zo5S52dpzFyXwi7PTbHXS44
	Fzxoe1AcCW0JYfVlRs99IP+EdWj0II1+vCHjFrcOxUFZekvVzY1ygiT3lJ6AN6Vm
	qg9LzkuvF1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 153AC270EA;
	Thu, 13 Jun 2013 22:49:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F66D270E8;
	Thu, 13 Jun 2013 22:49:24 +0000 (UTC)
In-Reply-To: <CALkWK0kO=KY4=Y7ex47LJ2F0oEfF+R9g3REO7rddDLL4c8CuEw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 14 Jun 2013 00:37:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EAE4E82-D47B-11E2-8D06-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227782>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> But that is entirely an independent issue (I am going to agree with
>> you in the end).
>
> Exactly.  It might be nice to fix those two things (are there any
> observed bugs?), but it is entirely orthogonal to our issue.

OK.

>> That is a correct observation.  But it needed a bit of thinking to
>> reach your conclusion that special casing this and handling --abort
>> in a new different codepath is the right solution.
>
> Yeah, the commit message is lacking.

OK.  I'll queue this on 'pu', not in 'next' so that it can be
rerolled.

> I'll probably work on these follow-ups in the morning.  Thanks for poking.

Thanks.
