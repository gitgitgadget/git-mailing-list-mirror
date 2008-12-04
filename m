From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 04 Dec 2008 23:26:16 +0100
Message-ID: <49385908.5020202@fs.ei.tum.de>
References: <49382612.3010207@fs.ei.tum.de> <7vhc5jeo60.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 23:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8MfX-0007sk-AA
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 23:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356AbYLDW0S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 17:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756369AbYLDW0S
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 17:26:18 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:34760 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353AbYLDW0S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2008 17:26:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id E48071C25E;
	Thu,  4 Dec 2008 23:26:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id weYD7m8W2-vT; Thu,  4 Dec 2008 23:26:16 +0100 (CET)
Received: from [192.168.10.11] (dyn.144-85-212-018.dsl.vtx.ch [144.85.212.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 75B5C1C0F1;
	Thu,  4 Dec 2008 23:26:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (X11/20081021)
In-Reply-To: <7vhc5jeo60.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102371>

Junio C Hamano wrote:
> Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:
>=20
>> We need to play some shell tricks to be able to pass directory names
>> which contain spaces and/or quotes.
>=20
> There already was an earlier attempt for this feature by Kevin Ballar=
d,
> which had issues I pointed out:
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/94335/focus=3D=
94456
>=20
> The patch was carried for a few weeks in 'pu' but was dropped due to =
lack
> of follow-up updates.
>=20
> Does your version address the issues Kevin's one had?

You mean not storing/restoring the flags across an invocation?  No, tha=
t's=20
a different thing.  My patch only adds the --directory option, it does =
not=20
fix the previously existing bug.

cheers
   simon

--=20
   <3 the future  +++  RENT this banner advert  +++   ASCII Ribbon   /"=
\
   rock the past  +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1 =
 +++     Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
