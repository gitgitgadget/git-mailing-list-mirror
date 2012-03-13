From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Tue, 13 Mar 2012 11:26:47 -0700
Message-ID: <7v4ntswe54.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <4F5EF6EC.20008@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 19:26:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7WQx-0006dx-Mm
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 19:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab2CMS0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 14:26:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab2CMS0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 14:26:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D217695E;
	Tue, 13 Mar 2012 14:26:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5xfjr7Gat8NpqdND0qHoEZgMESU=; b=YwS/dGxJfrlPnQ8jaA1E
	RMO67OZv7Ioq0HW8fRn15GNRC0f/XEOH4tvIRpUG7PsK2vmJYoDD4pMEKk0RGbV4
	1cQfWNalf1O/sOhYiuPHTmI8TU2/3mBjQ7KrEfKXR71RKVd7YC5gfkmWi2pRW77r
	b9gR6aeQ8Me3DkgRM171AW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ySVw5E6/YJxHK2LAmpV8/hCrXfVpSh+ZZKTqQSYlUIUh1P
	sF8pxlmQulr+Gu+SE3J/7WC6GCcZTwVoEFKDl/h8vL1PyeCBqXPSCcv4zGe4kDvQ
	oPltswmEJZOUHiBfgX4yC5/u/HnTXnTOUvGpFYrxJL33M9+e58gnUCxmFI924=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7470B695D;
	Tue, 13 Mar 2012 14:26:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C44D695C; Tue, 13 Mar 2012
 14:26:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18DEEBBA-6D3A-11E1-82C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193053>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 3/13/2012 2:55, schrieb Junio C Hamano:
>> I'd hold making that judgement for a several weeks until my eyes get
>> used to if I were you. I've seen that people (including myself)
>> react really badly to _any_ change and make loud noises (including
>> "we will never get used to this updated output, it is horrible!"),
>> and then eventually get used to it as if nothing happened, and that
>> happened often enough recently.
>
> I can buy that.

Assuming "that" refers to my "hold ... for several weeks", let me stop
reading right here.  We can talk about the rest of your message in several
weeks.
