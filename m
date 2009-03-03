From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: clarify how -S works
Date: Tue, 03 Mar 2009 10:24:28 -0800
Message-ID: <7veixebh2b.fsf@gitster.siamese.dyndns.org>
References: <49AD3E78.1050706@sneakemail.com>
 <20090303152333.GB24593@coredump.intra.peff.net>
 <20090303154041.GA31265@coredump.intra.peff.net>
 <7v1vted0d7.fsf@gitster.siamese.dyndns.org>
 <20090303171138.GA454@coredump.intra.peff.net>
 <43d8ce650903030939u73f09171uf4041b6d9824b698@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lis?= =?utf-8?Q?ts=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 19:26:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZJq-00053q-JH
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZCCSYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 13:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbZCCSYi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:24:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbZCCSYi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 13:24:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A26A93D88;
	Tue,  3 Mar 2009 13:24:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CBB673D86; Tue, 
 3 Mar 2009 13:24:30 -0500 (EST)
In-Reply-To: <43d8ce650903030939u73f09171uf4041b6d9824b698@mail.gmail.com>
 (John Tapsell's message of "Tue, 3 Mar 2009 17:39:38 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C7B3B6E-0820-11DE-ACAA-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112141>

John Tapsell <johnflux@gmail.com> writes:

> 2009/3/3 Jeff King <peff@peff.net>:
>> On Tue, Mar 03, 2009 at 08:42:12AM -0800, Junio C Hamano wrote:
>>
>>> In retrospect, because --pickaxe was designed primarily for Porcela=
in use,
>>> it was a mistake for it to have taken a short-and-sweet -S synonym.
>>
>> Hmm. I actually like the pickaxe behavior and find it useful for
>> searching. IOW, I consider it a porcelain feature, just perhaps not =
the
>> one that some people are expecting.
>>
>>> > =C2=A0-S<string>::
>>> > - =C2=A0 Look for differences that contain the change in <string>=
=2E
>>> > + =C2=A0 Look for differences that introduce or remove an instanc=
e of
>>> > + =C2=A0 <string>. Note that this is different than the string si=
mply
>>> > + =C2=A0 appearing in diff output; see the 'pickaxe' entry in
>>> > + =C2=A0 linkgit:gitdiffcore[7] for more details.
>>>
>>> Look for differences that change the number of occurrences of <stri=
ng>?
>>
>> Yes, that is technically correct. I was trying to find a wording tha=
t
>> was a little less "this is literally what it does" and more "this is
>> what you might find it useful for".
>
> Is there any way to have an option to also match any line containing
> the string?

Patches welcome. I've already outlined what you need to do.

I think it can be called -G (short for --grep-diff), if --search cannot=
 be
used because "-s" is unavailable.
