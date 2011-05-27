From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Whitespace and '&nbsp'
Date: Fri, 27 May 2011 18:50:13 +0200
Message-ID: <m262owhyuy.fsf@igel.home>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
	<7vzkm9unu0.fsf@alter.siamese.dyndns.org>
	<BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 27 18:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ0Ez-00015s-O3
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 18:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406Ab1E0QuT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2011 12:50:19 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51066 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab1E0QuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 12:50:18 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id E2306182446B;
	Fri, 27 May 2011 18:50:14 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id D97FC1C00052;
	Fri, 27 May 2011 18:50:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id tOLK8tGwhIkJ; Fri, 27 May 2011 18:50:14 +0200 (CEST)
Received: from igel.home (ppp-88-217-115-48.dynamic.mnet-online.de [88.217.115.48])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 27 May 2011 18:50:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5DD8FCA29C; Fri, 27 May 2011 18:50:13 +0200 (CEST)
X-Yow: WHOA!!  I'm having a RELIGIOUS EXPERIENCE right NOW!!
In-Reply-To: <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com> (Linus
	Torvalds's message of "Thu, 26 May 2011 15:08:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174630>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, May 26, 2011 at 2:57 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>
>> But in the longer term, I think we should find what MUA causes this
>> breakage and yell at them. It might be some mail relays, but I am no=
t sure
>> where these come from. =C2=A0I often see alternating real whitespace=
 and nbsp
                         ^^ Like this...
>> in "> " indented quotes.
>
> In this case, it was
>
>   Content-Type: text/plain; charset=3Dutf-8
>   Content-Disposition: inline
>   Content-Transfer-Encoding: 8bit
>   User-Agent: Mutt/1.5.21 (2010-09-15)
>
> so there was nothing odd in the MUA.

Is this a gmail thing?

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
