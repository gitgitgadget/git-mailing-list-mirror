From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 12:47:57 +0200
Message-ID: <46E12C5D.8000902@etek.chalmers.se>
References: <46DDC500.5000606@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:48:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITbNe-0004mo-2y
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 12:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbXIGKsB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 06:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbXIGKsA
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 06:48:00 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:59630 "EHLO
	anubis.medic.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965124AbXIGKsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 06:48:00 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by anubis.medic.chalmers.se (Postfix) with ESMTP id 676188B0E;
	Fri,  7 Sep 2007 12:47:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.6) Gecko/20070804 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46DDC500.5000606@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58021>

Lukas Sandstr=C3=B6m wrote:
> Hi.
>=20
> This is an attempt to use "The Better String Library"[1] in builtin-m=
ailinfo.c
>=20
> The patch doesn't pass all the tests in the testsuit yet, but I thoug=
ht I'd
> send it out so people can decide if they like how the code looks.
>=20
> I'm not sending a patch to add the library files at this time. I'll s=
end
> that patch when this patch is working.
>=20
> The changes required to make it pass the tests shouldn't be very larg=
e.
>=20
> /Lukas
>=20
> [1] http://bstring.sourceforge.net/
>=20
> ---
>  builtin-mailinfo.c |  795 ++++++++++++++++++++++++++----------------=
----------
>  1 files changed, 392 insertions(+), 403 deletions(-)

Unfortunatley, I haven't had any time inte the last few days to code, n=
or read
mail. I'm assuming that there is no point in me finishing the patch and=
 that git
will go with the strbuf solution?

/Lukas
