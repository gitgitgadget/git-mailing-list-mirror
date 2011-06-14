From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: allow space as delimiter in mime.types
Date: Tue, 14 Jun 2011 14:28:50 -0700
Message-ID: <7v62o8ksq5.fsf@alter.siamese.dyndns.org>
References: <1308060595-28294-1-git-send-email-ludwig.nussel@suse.de>
 <m3ips8v4s2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ludwig Nussel <ludwig.nussel@suse.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:29:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWbAS-0002W4-0S
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 23:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab1FNV2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 17:28:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab1FNV2x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 17:28:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4BE284678;
	Tue, 14 Jun 2011 17:31:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bJMxWDXRBVzoIsu+4KxkF4oh4+A=; b=dkH4Ow
	M404f4tA9GK7vtyCmNJDuEgFqBPCbHR1UPStL5VyFxuqEWtkIMnL0EERPkR3HSQf
	SWLE6ezfUb2SO6tu5pm997ycM8N8HdpCTPtdACyyjBzqJ++N1li/qC35RkNE0flj
	L23v9hkEvZcCrnAcNhTmI/F7+Rvv1WSGAUlMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h4+gCSqQFYRL1ifbVeL+yr2zRrmlyTit
	tvwhIuj4XkHISnpLAr8mDrrFJDMvicWIsF7MYSK9EPyBeFmRd3ZWZQWaTOL+urRC
	ACermELNbkHtm02MdwZEz3gHnG0hSVNIzdYEp2vx/ZBeqX0M4xrRUKWdDLVluwU1
	TAazB0ySIx8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3ABB04677;
	Tue, 14 Jun 2011 17:31:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 889AE4676; Tue, 14 Jun 2011
 17:31:02 -0400 (EDT)
In-Reply-To: <m3ips8v4s2.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 14 Jun 2011 07:59:10 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A8049C8-96CD-11E0-AA35-2C88C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175801>

Jakub Narebski <jnareb@gmail.com> writes:

> Ludwig Nussel <ludwig.nussel@suse.de> writes:
>
>> Subject: [PATCH] gitweb: allow space as delimiter in mime.types
>
> A very minor nitpick: perhaps "work with" rather than "allow" would be
> better?

Allow is good; we earlier didn't allow space to be treated as delimiter,
with this patch we will do.

>> in openSUSE /etc/mime.types has only spaces. I don't know if there's
>> a canonical reference that says that only tabs are allowed. Mutt at
>> least also accepts spaces. So make gitweb more liberal too.
>
> Ack.
>
> It is obviously correct, as names of MUME types cannot contain spaces,
> it makes gitweb work with openSUSE /etc/mime.types, and it makes code
> simpler.
>
>> ---
>
> Signoff (i.e. Signed-off-by)?

Yes, sign-off is missing and necessary.

Thanks.
