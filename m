From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Tue, 04 Sep 2012 02:01:36 -0700
Message-ID: <7v4nneduvj.fsf@alter.siamese.dyndns.org>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org>
 <5041BC94.7000304@gmail.com> <504214AA.9080706@kdbg.org>
 <50425F8B.5020406@gmail.com> <7voblognny.fsf@alter.siamese.dyndns.org>
 <5044D162.1010608@gmail.com> <7voblmeua3.fsf@alter.siamese.dyndns.org>
 <CANGUGtBk7DME4pkhJhcYoaM-q_S+i9_6u_Ku-9N6D41Mx50ghg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 11:01:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8p10-00048I-Md
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 11:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625Ab2IDJBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 05:01:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753953Ab2IDJBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 05:01:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2BA06151;
	Tue,  4 Sep 2012 05:01:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=11e7hrA2CmGmC49fvQCbmjALEzI=; b=RyrUnb
	AOq5++TiuUesE73CjXHmD9hOdFTGkkbOgQFOWtjKwmZpQJvYGDVtIylXmaOwqdAu
	iT/o82dP0GFT6lbZvK0x+j1SOQu3MXsZnBc4/237uNVoBzM45KagcKlXm9KAb2nu
	0c+giBmU62nRaSrTBh7CbbRAS0Hea5mV9ELFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZUOygb+k8rkSExpi7luoCOjiva1nz3W2
	WtjdGE9wubdpOFF5LY33BQIEBU7dUjW3XwUpCBiVwaShorFPTpnBrY1KcJngAOfN
	txZ+T4eKq+Yby9QJEAvRatXlRqybwBDiE9LEnt2tAwWCU5jRrptT7gFOYb7wxpcM
	+Gw6J6086a4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0A746150;
	Tue,  4 Sep 2012 05:01:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29B3B614F; Tue,  4 Sep 2012
 05:01:38 -0400 (EDT)
In-Reply-To: <CANGUGtBk7DME4pkhJhcYoaM-q_S+i9_6u_Ku-9N6D41Mx50ghg@mail.gmail.com> (Marco
 Stornelli's message of "Tue, 4 Sep 2012 08:37:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22B31292-F66F-11E1-8569-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204730>

Marco Stornelli <marco.stornelli@gmail.com> writes:

> I don't have thunderbird now but actually it's really simple:
>
> Subject:
> To:
> Cc:
> $SEP

The above is not a very useful "example" to advance this discussion,
I have to say.  For one, where is your Oggetto?  Are these fields
the only ones you will ever see?  Are they always empty?

I would expect, at least when you are responding to an existing
message, some of them are filled already (and if so, I think appp.sh
wants to know exactly how, for example, has RFC2047 quoting already
applied, or are we supposed to write in UTF-8 and let Thunderbird
massage the contents when we give the file back to it?), and also
there would appear In-Reply-To: field already filled (possibly there
may be References: as well).

And if you are replying to an existing message and Thunderbird fills
To: or Cc: fields based on the ongoing discussion, I wonder if it is
a mistake to override that based on anything from what we read from
format-patch output in the first place.
