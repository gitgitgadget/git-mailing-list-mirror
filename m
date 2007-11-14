From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Grammar fixes for gitattributes documentation
Date: Wed, 14 Nov 2007 10:04:25 +0100
Message-ID: <3461FD6E-1C46-4278-9EB0-5D730BB99084@wincent.com>
References: <33080F0B-80C0-4860-9A74-C6878EE3B2CD@wincent.com> <7vfxz9kxz3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:04:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsEB6-0004dH-RM
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 10:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbXKNJEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 04:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbXKNJEj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 04:04:39 -0500
Received: from wincent.com ([72.3.236.74]:35120 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349AbXKNJEi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 04:04:38 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAE94QHH006263;
	Wed, 14 Nov 2007 03:04:27 -0600
In-Reply-To: <7vfxz9kxz3.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64967>

El 14/11/2007, a las 9:55, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> -A `filter` attribute can be set to a string value.  This names
>> +A `filter` attribute can be set to a string value which names a
>> filter driver specified in the configuration.
>
> Will we get the canned "which vs that" discussion on this change?

Perhaps. Neither would be incorrect, although technically "that" is a =20
tighter match.

> I do appreciate the grammar fixes, but I needed to re-wrap and
> swap lines to see the real change.  Especially, after this
> re-wrapping, the updated lines with missing "the" fixed still
> fit nicely below 70 columns and the right edge is not too ragged
> to be distractive even for people who read unformatted text.
>
> Could you please avoid this kind of unnecessary re-wrapping in
> the future patches?


Ok, sorry about that. I wasn't sure of the maximum allowed length in =20
the doc files, and the longest line I could find in that file was 67 =20
chars, so I made sure that nothing exceeded that. Will make a note =20
that the official limit is 70. Perhaps this could be added to the =20
style document? Will whip up a patch for that.

Cheers,
Wincent
