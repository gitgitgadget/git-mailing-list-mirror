From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Git Wiki Move
Date: Fri, 15 Jan 2010 16:12:14 -0800
Message-ID: <7v3a26rjq9.fsf@alter.siamese.dyndns.org>
References: <20100113232908.GA3299@machine.or.cz>
 <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net>
 <vpqbpgxrn32.fsf@bauges.imag.fr> <4B4F68E8.5050809@eaglescrag.net>
 <4B50F7DB.7020204@eaglescrag.net>
 <fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com>
 <4B510217.8060200@eaglescrag.net>
 <fabb9a1e1001151608k6911bcf8p854d97c2f2d46264@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.H." <warthog19@eaglescrag.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:12:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwHK-0007Bn-AO
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758722Ab0APAM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758718Ab0APAM3
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:12:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758392Ab0APAM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:12:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D2DC91C82;
	Fri, 15 Jan 2010 19:12:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RoHetCyojyqNubDKQLXJh9SXXRQ=; b=FHBbWT
	iqjcsg1u0PqGR9JRVQjvjsri1UxSNjLSo+2lmUmQm1CYqFlDs0fKSBnaHpjPVh4B
	lVdAH5Y/k7J1nob7tned5RtxdwQMc+6yZFNVSUa8fXwx+7+yRJaoKbOnXOo7S22+
	deQdcHyxxyOYnReXp3GxbdbE81bPw3ltsk/Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yb6JpwtJIifvUfIrHxwCT29+V7FE7VMg
	VZ0AWnCj6L1skXANLFuDQxuatxHwiVZ6coAL2i9FIe2Hlc2s3TNoKFkLAk0acQrK
	peG8loup/DVllUKKdR4ehQNLMz5PEWqQlPZ0nfKxsDurdu6NPQ9BD0CZTZ86RYW+
	7RPutvp4/dQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA72191C7C;
	Fri, 15 Jan 2010 19:12:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEA3A91C78; Fri, 15 Jan
 2010 19:12:15 -0500 (EST)
In-Reply-To: <fabb9a1e1001151608k6911bcf8p854d97c2f2d46264@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 16 Jan 2010 01\:08\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D118CDAA-0233-11DF-A822-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137171>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> From the original faq:
>
> <<GitLink(git-name, Because Linus is an egotistical git)>>
>
> Is translated to
>
> <<[[GitLink]](git-name, Because Linus is an egotistical git}}
>
> But should instead be turned into a comment (from the source of the faq):
>
> <!-- GitLink[git-name] Because Linus is an egotistical git -->
>
>> There's some
>> extraneous bits on the page that I haven't figured out what they were
>> for originally but most everything on the page seems to work fine for me...
>
> We're probably referring to the same then :).

IIRC, they are read by gitbot listening to #git channel at freenode, so
that people can say "faq git-name" and such to summon a response.
