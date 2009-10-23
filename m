From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Write and Submit Your First Kernel Patch
Date: Fri, 23 Oct 2009 12:52:18 -0700
Message-ID: <7v8wf1c2h9.fsf@alter.siamese.dyndns.org>
References: <dc1d0f40910231146y14028f4el9753debdf334103@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
	git@vger.kernel.org
To: Kevyn-Alexandre =?utf-8?Q?Par=C3=A9?= 
	<kevyn.alexandre.pare@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 21:52:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1QBk-0007Er-9N
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 21:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbZJWTw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 15:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbZJWTw2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 15:52:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbZJWTw0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 15:52:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31ED283603;
	Fri, 23 Oct 2009 15:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uj/jihwo7E/E
	BUMNMiSXH/XrnIc=; b=UgkfTbdA8wKWQj7e3XgoLl1TIB7iRpRUyEOmbk+1zucT
	YewLY0bDrIhmPBz0gJJsjV5AAVWSIruRoDxN0SzK4vxJNIWAZdIvc3VTH4iRaanL
	61QGvjhyzxelfy40dr6WkV4cpZriL2IcqIEMubz+AVECkqxrfIvAAqADRY7kH6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o8Jjtx
	3BQ2td8n8QI+mjOecV3wSRRrYRg+b0/j/BcfeidUNAlOYGVxseukz1iD7gTjptcr
	xeYTDeRqsjk2Wy8LHTSPRkTkbjcNHUZi66ZTOrBulGyLOOmBr1oGZL7S2ZcI7cky
	OSxHDBiSpWEoNG6RDpfOJxVyo3QE655TWbeQw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA102835FD;
	Fri, 23 Oct 2009 15:52:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7D176835FC; Fri, 23 Oct 2009
 15:52:20 -0400 (EDT)
In-Reply-To: <dc1d0f40910231146y14028f4el9753debdf334103@mail.gmail.com>
 ("Kevyn-Alexandre =?utf-8?Q?Par=C3=A9=22's?= message of "Fri\, 23 Oct 2009
 14\:46\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9676E97E-C00D-11DE-BBBF-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131122>

Kevyn-Alexandre Par=C3=A9  <kevyn.alexandre.pare@gmail.com> writes:

> Just before I send my patch I got this error with:
> ./scripts/checkpatch.pl --terse --file
> 0001-Staging-comedi-driver-fix-coding-style.patch
>
> 0001-Staging-comedi-driver-fix-coding-style.patch:27: ERROR: trailing=
 whitespace
> 0001-Staging-comedi-driver-fix-coding-style.patch:35: ERROR: trailing=
 whitespace
> 0001-Staging-comedi-driver-fix-coding-style.patch:43: ERROR: trailing=
 whitespace
> 0001-Staging-comedi-driver-fix-coding-style.patch:53: ERROR: trailing=
 whitespace
>
> I have done a step by step explanation of what I have done:
> http://kapare.blogspot.com/2009/09/write-and-submit-your-first-kernel=
=2Ehtml
>
> It seem to me that the whitespace are added after I do this command:
> git format-patch -s -n master..mybranch

"The whitespace are added after..." sounds to me that what you committe=
d
were checkpatch compliant, and format-patch somehow broke it.  If that =
is
the case we need to fix format-patch.

Please check if "git show $commit" output for the commit that correspon=
ds
to the "[Staging] comedi driver: fix coding style" patch has trailing
whitespaces.  That is what you committed.

If there already is whitespace breakage in what you committed, then we =
do
not have to blame format-patch and look for bugs in it to fix.

Otherwise, please send 0001-*.patch (output from format-patch) and outp=
ut
from that "git show $commit" as separate attachments, so that we can de=
bug
and fix format-patch.

Thanks.
