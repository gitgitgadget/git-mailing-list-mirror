From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 12:31:04 -0700
Message-ID: <7vli7hicjr.fsf@alter.siamese.dyndns.org>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
	<7vwqr1jw67.fsf@alter.siamese.dyndns.org>
	<CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
	<7v8v3hjt57.fsf@alter.siamese.dyndns.org>
	<CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 21:31:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKwK-00066i-TL
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767Ab3ENTbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:31:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757543Ab3ENTbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:31:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F7071E991;
	Tue, 14 May 2013 19:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ahB2hp/8AcKKGAXDAagWenz21bM=; b=lPNXbk
	OGnJaDec9Bf5EmMFEoDQ/Gt0ioVBgH7xPIi8AgTA5Xew0svjvyk8gg59unDhTOGv
	fBWJxkucxwu3AmtjCtzwUFxH+Z81iZUBM+9LcNgKaBZW2pmUWcOHNE+Zir3MWcTL
	ST6p1uY915rbD5hb9megtyEqO656J3lQMrmT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QRYbc1bMb+u193Gikp4WpbPrVv50as8E
	SovVxxmYWsTpez97+/AP/+n7/+2M8jP+K7NazTumueVFf9mW8J6toSS16VcjJBmX
	7v0ayr0ubmV7qET22OhnXIUCw3RAM3Pc68rPIaxgFH4gszq9i5GKs2axUw8a++Hl
	s/J13pLChLE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938EC1E990;
	Tue, 14 May 2013 19:31:06 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17D011E98C;
	Tue, 14 May 2013 19:31:06 +0000 (UTC)
In-Reply-To: <CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 15 May 2013 00:27:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D23CC5B8-BCCC-11E2-9333-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224323>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I do not use zsh but with bash+readline the old tradition lnext can
>> be used (see "stty -a" output and it typically is set to ^V), i.e.
>> \C-v followed by \C-i should give you a literal HT.
>
> Just looked it up: zsh has quoted-insert (^V) after which I can TAB.
> Still doesn't solve my problem though: I don't type out structs; I
> paste them the X clipboard (Emacs).  And that doesn't work either on
> bash or zsh.
>
> What can we do to improve the interface?

Heh, I seem to have just found a volunteer to finish the Linus's
dream by following up on http://gitster.livejournal.com/35628.html
(see section #5; I do not do GUI, neither Linus, so this has been a
four-year old dream).
