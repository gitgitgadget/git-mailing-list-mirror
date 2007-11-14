From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Grammar fixes for gitattributes documentation
Date: Wed, 14 Nov 2007 01:27:19 -0800
Message-ID: <7vfxz9jhxk.fsf@gitster.siamese.dyndns.org>
References: <33080F0B-80C0-4860-9A74-C6878EE3B2CD@wincent.com>
	<7vfxz9kxz3.fsf@gitster.siamese.dyndns.org>
	<3461FD6E-1C46-4278-9EB0-5D730BB99084@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsEXE-0002zm-Kd
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 10:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbXKNJ10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 04:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbXKNJ1Z
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 04:27:25 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41481 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbXKNJ1Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 04:27:24 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8B7222F0;
	Wed, 14 Nov 2007 04:27:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 07A9C9449D;
	Wed, 14 Nov 2007 04:27:42 -0500 (EST)
In-Reply-To: <3461FD6E-1C46-4278-9EB0-5D730BB99084@wincent.com> (Wincent
	Colaiuta's message of "Wed, 14 Nov 2007 10:04:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64968>

Wincent Colaiuta <win@wincent.com> writes:

> El 14/11/2007, a las 9:55, Junio C Hamano escribi=F3=BA=8A=8A> Wincen=
t Colaiuta <win@wincent.com> writes:
>>
>>> -A `filter` attribute can be set to a string value.  This names
>>> +A `filter` attribute can be set to a string value which names a
>>> filter driver specified in the configuration.
>>
>> Will we get the canned "which vs that" discussion on this change?
>
> Perhaps. Neither would be incorrect, although technically "that" is a=
 =20
> tighter match.

Yes, that was what I was getting at, although I do not
particularly find the original wrong nor harder to read, either.

>> Could you please avoid this kind of unnecessary re-wrapping in
>> the future patches?
>
> Ok, sorry about that. I wasn't sure of the maximum allowed length in =
=20
> the doc files, and the longest line I could find in that file was 67 =
=20
> chars, so I made sure that nothing exceeded that. Will make a note =20
> that the official limit is 70.

I did not mean to say 70 was the official limit.  Indeed, there
is no hard official limit (and there shouldn't be any "hard"
limit).  But 70 should certainly be lower than the limit anybody
around here would want to impose, and that was why I said 70.

Some considerations:

 - Many of us read the unformatted ASCII version, as AsciiDoc
   was designed to be very readable, and mixing excessively long
   and short lines will make the document harder to read.

 - We tend to exchange patches over e-mail and assume everybody
   has at least 80-column wide terminals, so although we say a
   line should be less than 80-chars, in practice the limit is
   somewhat lower. to accomodate diff change marks [-+ ] and
   quoting ">> " in e-mails.

 - But "80-chars minus a bit of slop" is not a very hard limit.

Please apply some common sense to decide when to re-wrap and
when not to within these constraints.
