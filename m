From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Fix t9101 test failure caused by Subversion "auto-props"
Date: Sat, 17 Nov 2007 14:28:02 +0100
Message-ID: <270B4D20-EC93-43C9-8BCD-EAE7018F2039@wincent.com>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com> <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr> <73246E38-9C22-4279-A53E-678434238E5C@wincent.com> <20071116124850.GA14473@atjola.homenet> <2F7DFDC9-D4E2-42D0-9E48-E51E7905FF42@wincent.com> <7vy7cxwwoo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 14:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItNip-0004Im-52
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 14:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbXKQN2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2007 08:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbXKQN2M
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 08:28:12 -0500
Received: from wincent.com ([72.3.236.74]:44346 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbXKQN2L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2007 08:28:11 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAHDS27o018202;
	Sat, 17 Nov 2007 07:28:03 -0600
In-Reply-To: <7vy7cxwwoo.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65276>

El 17/11/2007, a las 1:19, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> If a user has an "auto-prop" in his/her ~/.subversion/config file fo=
r
>> automatically setting the svn:keyword Id property on all ".c" files
>> (a reasonably common configuration in the Subversion world) then one
>> of the "svn propset" operations in the very first test would become =
a
>> no-op, which in turn would make the next commit a no-op.
>
> Thanks for diagnosing and fixing.
>
> I presume this fix also applies to both 'maint' and 'master',
> right?

I prepared it against master, but I believe it will apply cleanly to =20
maint, where it's also needed.

Cheers,
Wincent
