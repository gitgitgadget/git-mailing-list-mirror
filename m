From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Fri, 05 Dec 2008 00:41:50 +0100
Message-ID: <49386ABE.2050404@fs.ei.tum.de>
References: <49382612.3010207@fs.ei.tum.de> <7vhc5jeo60.fsf@gitster.siamese.dyndns.org> <49385908.5020202@fs.ei.tum.de> <7v7i6fd0zt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:43:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Nqi-0000n2-RZ
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 00:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYLDXl4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 18:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbYLDXl4
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 18:41:56 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:52264 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbYLDXlz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2008 18:41:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id A5FF01C25E;
	Fri,  5 Dec 2008 00:41:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0Wn1bvybytRq; Fri,  5 Dec 2008 00:41:51 +0100 (CET)
Received: from [192.168.10.11] (dyn.144-85-212-018.dsl.vtx.ch [144.85.212.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 642811C0F0;
	Fri,  5 Dec 2008 00:41:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (X11/20081021)
In-Reply-To: <7v7i6fd0zt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102377>

Junio C Hamano wrote:
> Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:
>=20
>> You mean not storing/restoring the flags across an invocation?  No,
>> that's a different thing.  My patch only adds the --directory option=
,
>> it does not fix the previously existing bug.
>=20
> The question is if it _introduces_ a bug that the directory given in =
the
> initial invocation of "git am --directory=3Dfoo" is lost if an patch =
does
> not apply and you need to manually resolve and continue.
>=20
> If it does not introduce such a bug, you do not have the same issue a=
s the
> old patch.  Otherwise you have the same issue as the old patch.  The
> question was if you have the same issue or you don't.  Yes?  No?

Yes, that's the issue.  In this regard it behaves bug-compatible with t=
he=20
-p and -C options.

--=20
   <3 the future  +++  RENT this banner advert  +++   ASCII Ribbon   /"=
\
   rock the past  +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1 =
 +++     Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
