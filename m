From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] run-command.c: fix build warnings on Ubuntu
Date: Sat, 30 Jan 2010 17:43:27 +0100
Message-ID: <201001301743.27439.markus.heidelberg@web.de>
References: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 17:43:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbGQ1-0004Th-UB
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 17:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259Ab0A3Qn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 11:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223Ab0A3Qn2
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 11:43:28 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:60993 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab0A3Qn2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 11:43:28 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id D557413CE1FA6;
	Sat, 30 Jan 2010 17:43:26 +0100 (CET)
Received: from [91.19.0.24] (helo=pluto.localnet)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1NbGPu-0008Nc-00; Sat, 30 Jan 2010 17:43:26 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.30-gentoo-r8; KDE/4.3.3; i686; ; )
In-Reply-To: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/m6b1SAr7e9eZ+LTraujm4eB6AjprDVsR4pXtY
	Kdg401qsrxxONdOlXtCZbJo9KTO6elXZi/jF+TYzOJxOaKRcxd
	zy8blLibfKCJiRIefX2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138482>

Michael Wookey, 2010-01-29:
> Building git on Ubuntu 9.10 warns that the return value of write(2)
> isn't checked.
>=20
> GCC details:
>=20
>   $ gcc --version
>   gcc (Ubuntu 4.4.1-4ubuntu9) 4.4.1
>=20
> Silence the warnings by reading (but not making use of) the return va=
lue
> of write(2).

Since a few weeks I get several warnings about fwrite(), currently 28
times this:
warning: ignoring return value of =E2=80=98fwrite=E2=80=99, declared wi=
th attribute warn_unused_result

gcc (Gentoo 4.3.4 p1.0, pie-10.1.5) 4.3.4

Not sure if it should be muted, that are really many places.

Markus
