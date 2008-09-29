From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: Re: git can't find none
Date: Mon, 29 Sep 2008 14:13:53 +0200
Message-ID: <48E0C681.1090502@cetrtapot.si>
References: <48E0B8FE.6060203@cetrtapot.si> <48E0BD38.6070602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 29 14:16:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkHgC-00042i-5A
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 14:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYI2MPb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Sep 2008 08:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYI2MPb
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 08:15:31 -0400
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172]:55920 "EHLO
	zimbra-mta.cetrtapot.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYI2MPa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 08:15:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id F187619F9CE;
	Mon, 29 Sep 2008 14:15:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.292
X-Spam-Level: 
X-Spam-Status: No, score=-4.292 tagged_above=-10 required=5
	tests=[ALL_TRUSTED=-1.8, AWL=0.107, BAYES_00=-2.599]
Received: from zimbra-mta.cetrtapot.si ([127.0.0.1])
	by localhost (zimbra-mta.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swNtFJjWKcMh; Mon, 29 Sep 2008 14:15:22 +0200 (CEST)
Received: from [172.31.65.135] (unknown [192.168.66.2])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 6485919F9CB;
	Mon, 29 Sep 2008 14:15:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48E0BD38.6070602@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97006>

Johannes Sixt wrote:
> Hinko Kocevar schrieb:
>> Hi,
>>
>> I've recently discovered that some git command stopped working. I'm =
not sure if this is related to my git tree or not, it happens on other =
trees too:
>> $ git blame Makefile=20
>> sh: none: command not found
>>
>> 'none' ?
>=20
> Try
>=20
>    $ git --no-pager blame Makefile

It works! yes.

>=20
> and if that works, correct your setting of PAGER or GIT_PAGER, e.g.
>=20
>    $ export GIT_PAGER=3Dcat

I don't want any pager. I've set the config property to 'none' instead =
to "":
$ git-config core.pager ""

Thank you,
Hinko

--=20
=C8ETRTA POT, d.o.o., Kranj
Planina 3
4000 Kranj
Slovenia, Europe
Tel. +386 (0) 4 280 66 03
E-mail: hinko.kocevar@cetrtapot.si
Http: www.cetrtapot.si
