From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Color support for "git-add -i"
Date: Wed, 5 Dec 2007 14:52:56 +0100
Message-ID: <D72C7087-61D9-4AEC-AA7F-52A1268F1EA8@wincent.com>
References: <7vbq95tnk7.fsf@gitster.siamese.dyndns.org> <475697BC.2090701@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Dan Zwell <dzwell@zwell.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 05 14:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzuhX-0002Uo-Nu
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 14:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbXLENxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 08:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbXLENxv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 08:53:51 -0500
Received: from wincent.com ([72.3.236.74]:37262 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbXLENxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 08:53:51 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB5DqvEk023053;
	Wed, 5 Dec 2007 07:52:58 -0600
In-Reply-To: <475697BC.2090701@viscovery.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67154>

El 5/12/2007, a las 13:21, Johannes Sixt escribi=F3:

> Junio C Hamano schrieb:
>> +color.interactive::
>> +	When true (or `always`), always use colors in `git add
>> +	--interactive`.  When false (or `never`), never.  When set to
>> +	`auto`, use colors only when the output is to the
>> +	terminal. Defaults to false.
>
> Any particular reason why color.interactive =3D true should be =20
> different from
> color.diff =3D true? See 57f2b842 ("color.diff =3D true" is not "alwa=
ys" =20
> anymore)

I wonder when you'd ever run an interactive command and not be in a =20
terminal? ie. it doesn't make much sense to ever do "git add -i > =20
foo", except perhaps from the test suite.

Notwithstanding, consistency for the sake of consistency is probably a =
=20
good thing.

Cheers,
Wincent
