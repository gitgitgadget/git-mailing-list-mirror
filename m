From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 09 Apr 2013 12:29:24 -0700
Message-ID: <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 21:29:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPeEX-0003sP-6d
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 21:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935134Ab3DIT33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 15:29:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761262Ab3DIT32 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 15:29:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B0C615513;
	Tue,  9 Apr 2013 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=myTYXLEjnT06OzMKy6Nq81u9b3M=; b=hD9FaX
	88rKPMYj1/GdcfvNgiaDedXv/h6Vb3jZ/nNbhdhzZQZd2uvMOe0r4FmTj+xkl+Ar
	hVpIForSNck2RaSV/j1782PXBRDEeWUx01ZBLn7iigdF8lWt1CUZ+GwTccsxHMsH
	Qc+OwpwY9niaz5MiQUnzQgqzofWdIR3TmC38I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wujf7fyD7uLXU7f1Ed6dy9EauebnJm9Y
	M9ktUXkI+P0s/1R6J1uB84A/63TXvejPmXASgBdxlwi23qESDVl4yefMlnUqs6IP
	L13U41jrSOLwwfF6QIzVtgr7290hw5M/jrSnHRGOlN9K/4sucS/r0wAg6Y4krSmZ
	wg1ybY+ntqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 428C315512;
	Tue,  9 Apr 2013 19:29:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4543715511; Tue,  9 Apr
 2013 19:29:26 +0000 (UTC)
In-Reply-To: <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 9 Apr 2013 23:33:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA48D5D2-A14B-11E2-A757-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220621>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> What is bad about saying "push origin ...the rest..."?
>
> I don't know which remote to push to: all I know is that the remote to
> push to is configured somewhere in the web of ...

Ahh, and then the recent triangular stuff makes it even worse.

I can see why we might want some token that says "I am pushing where
I would push normally if this were a 'git push' that does not say
'to where' and 'push what'" to help users.

Some background to explain why I was hesitant to the change.

There must be a reason why the user wants to use a custom set of
refspecs, not the configured ones, for this particular push only.
There must be something special for this particular push that makes
it different from the configured 'git push' default.

I was wondering if it is sensible to assume that the user is likely
to still want to push to the same repository where she usually
pushes to, when she has that special reason.  The underlying
assumption for it to be sensible is that 'to where' (destination
repository) is more sticky than 'push what' (the refspecs).

And I think now I agree that indeed is a sensible assumption.  I am
not sure '-' is a good token for that, but I do not offhand think of
a reason why '-' would be a _bad_ token for that, either.
