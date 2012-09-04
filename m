From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Tue, 04 Sep 2012 08:49:05 -0700
Message-ID: <7vd321dc0e.fsf@alter.siamese.dyndns.org>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org>
 <5041BC94.7000304@gmail.com> <504214AA.9080706@kdbg.org>
 <50425F8B.5020406@gmail.com> <7voblognny.fsf@alter.siamese.dyndns.org>
 <5044D162.1010608@gmail.com> <7voblmeua3.fsf@alter.siamese.dyndns.org>
 <CANGUGtBk7DME4pkhJhcYoaM-q_S+i9_6u_Ku-9N6D41Mx50ghg@mail.gmail.com>
 <7v4nneduvj.fsf@alter.siamese.dyndns.org>
 <CANGUGtChELcXe08JtrJW=rt48xOSSeEd9tCgcJvtHiKaX5GCMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:49:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8vNN-0005HO-75
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 17:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163Ab2IDPtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 11:49:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099Ab2IDPtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 11:49:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEEA18634;
	Tue,  4 Sep 2012 11:49:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IRNSWPaD0ULXk8nI9jWOKullcgU=; b=KPO8h4
	vpF6Q++cJ7GBezWMhvHfjY+Z0/9JMUcGWwxYZuqFVNWx8du0fmLIXFGxQY0cDbl+
	4dt+u5++dphUmBIk06/+jFZpYtFhVPgpMzTmAodnEUaalrOc+gYEfqHR91lgt3EL
	LRd9ZmGuspGiTiFG3OmDrLNFipho/h7BZnq/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N1Nk0Ix/EBt45LrYCjHDggnaFxIy/1Ai
	cVrgJMx9vKKA7lZXHgE2IVhrHQe3qUletz4Hax0QFkfLar6gTqFXs/H8ZrfL461o
	V9cnonHS+Y0J471PxSyhqJwzmS+iOE/03/oqf4fGo/JneNWyCv3tk1JFvm7Sp//n
	AqvTLap7vUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC27E8633;
	Tue,  4 Sep 2012 11:49:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23E7E8630; Tue,  4 Sep 2012
 11:49:07 -0400 (EDT)
In-Reply-To: <CANGUGtChELcXe08JtrJW=rt48xOSSeEd9tCgcJvtHiKaX5GCMQ@mail.gmail.com> (Marco
 Stornelli's message of "Tue, 4 Sep 2012 13:22:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F6CBEAC-F6A8-11E1-A2BB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204749>

Marco Stornelli <marco.stornelli@gmail.com> writes:

> 2012/9/4 Junio C Hamano <gitster@pobox.com>:
>
>> I would expect, at least when you are responding to an existing
>> message, some of them are filled already (and if so, I think appp.sh
>> wants to know exactly how, for example, has RFC2047 quoting already
>> applied, or are we supposed to write in UTF-8 and let Thunderbird
>> massage the contents when we give the file back to it?), and also
>> there would appear In-Reply-To: field already filled (possibly there
>> may be References: as well).
>
> Message reply is out of scope of my patch. The goal here is send a
> patch, so the execution flow is to open a new message,
> clik on external editor (configured properly), select patch file and
> send. It was the scope of the old script and it is the scope of my
> patch.

I certainly can understand that you updated the script for that use
case and that use case only, but given that the original tries very
hard to preserve:

 - what was in $HEADERS (by only replacing Subject);
 - the recipients CC'ed in $HEADERS (by grabbing them into $CCS); and
 - the body of the message in $BODY (i.e. what came after $SEP),

I find it hard to believe that it was meant to work on a freshly
created empty message and nothing else.  If people were depending on
the recipients listed on Cc that are taken from $1 to be preserved,
your patch will introduce a regression for them, no?
