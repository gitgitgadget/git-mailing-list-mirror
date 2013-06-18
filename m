From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] am: handle stray $dotest directory
Date: Tue, 18 Jun 2013 07:31:01 -0700
Message-ID: <7va9mna3tm.fsf@alter.siamese.dyndns.org>
References: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
	<1371300192-6222-2-git-send-email-artagnon@gmail.com>
	<7v38shjw01.fsf@alter.siamese.dyndns.org>
	<7vy5a8ei6u.fsf@alter.siamese.dyndns.org>
	<CALkWK0kq6+K4fotWq1Qz9BrqOG56NezJqnfH9Xrg1vh6AS9bnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:31:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowwA-0007Vx-AE
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244Ab3FRObF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:31:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755764Ab3FRObD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:31:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46F3726D4C;
	Tue, 18 Jun 2013 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0o8L4bpaxjmdpsbC0eOCMuCSKPk=; b=Zzkdho
	YO0x4S1BF7iYgY7s7e84GnxQLnMUYDmMKy/+XtZRt2uQoxTADkEAVY5RFWFSqMda
	l/0ei2KuHU0Z0zcHkU/O348KV4JCDIt9OdlBzY7M3JaYr3o47wmoTuRtoWcNKPXW
	eEo7kZU4lUqin809Rb7NshVFU9hZYumAQ3FLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CuMGfGhjJV6+i6fcs9Bf4/NIRVJVZPHH
	MwM5FVCJ0RLs9DQcejj12YD2mvKWbF2NXb+u5PWULhErjdSwdGYV6a56pUhjoAkn
	og7dtvwZiNihbQ9794aIYvnVx/L2G3d1/jsrPpiqhNkK/vYgZgH+eHgYeH4z8XQb
	B3pzQj/NZO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3764A26D4B;
	Tue, 18 Jun 2013 14:31:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8418D26D4A;
	Tue, 18 Jun 2013 14:31:02 +0000 (UTC)
In-Reply-To: <CALkWK0kq6+K4fotWq1Qz9BrqOG56NezJqnfH9Xrg1vh6AS9bnw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 18 Jun 2013 12:35:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3BD21CE-D823-11E2-AF80-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228238>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>> Will replace what has been queued on 'pu'.
>>
>> ... after fixing an indentation error, that is.
>
> Where did the error occur?

I think you can compare what is in 'pu' and what you sent out
without asking.
