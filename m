From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 01/10] refs: add "for_each_bisect_ref" function
Date: Thu, 26 Mar 2009 16:50:05 +0100
Message-ID: <49CBA42D.3000404@drmicha.warpmail.net>
References: <20090326055509.1bc16b28.chriscool@tuxfamily.org> <fabb9a1e0903252320j2edf4a8ct39f784c4319c3cb0@mail.gmail.com> <200903260848.42104.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 16:52:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmrrz-0007mE-V0
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 16:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759008AbZCZPuR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 11:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759110AbZCZPuQ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 11:50:16 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47738 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758908AbZCZPuP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 11:50:15 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 225432FECF3;
	Thu, 26 Mar 2009 11:50:13 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 26 Mar 2009 11:50:13 -0400
X-Sasl-enc: LqPfN16CJ2U6L40xOJY9UX5H5tisSjZ1AEw9yGYxOjlP 1238082612
Received: from localhost.localdomain (p4FC63417.dip0.t-ipconnect.de [79.198.52.23])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 67820B1D5;
	Thu, 26 Mar 2009 11:50:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090326 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <200903260848.42104.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114795>

Christian Couder venit, vidit, dixit 26.03.2009 08:48:
> Hi Sverre,
>=20
> Le jeudi 26 mars 2009, Sverre Rabbelier a =E9crit :
>> Heya
>>
>> On Thu, Mar 26, 2009 at 05:55, Christian Couder <chriscool@tuxfamily=
=2Eorg>=20
> wrote:
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>
>> A 10 patches series with no cover letter?=20
>=20
> I am not a big fan of cover letters. Usually I prefer adding comments=
 in the=20
> patches.

I'm sorry I have to say that, but your individual preferences don't
matter. Many of us would do things differently, each in their own way,
but people adjust to the list's preferences. It's a matter of attitude.
So, please...

Cheers,
Michael

>=20
>> And no description of the=20
>> individual patches either!=20
>=20
> There is a commit message in each patch. And many of the patches are =
very=20
> small.
>=20
>> C'mon Christian, you know better than that=20
>> ;).
>=20
> If some commit messages are not clear enough, please tell me and I wi=
ll try=20
> to improve them ;)
>=20
> Regards,
> Christian.
