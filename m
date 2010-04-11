From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [ANNOUNCE] Git 1.7.1.rc1
Date: Sun, 11 Apr 2010 18:55:18 +0200
Message-ID: <m2pr26c4jt.fsf@igel.home>
References: <7vmxxar5h7.fsf@alter.siamese.dyndns.org>
	<y2i51dd1af81004110908mcf6ce8cahf04225d7c261a85b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 18:55:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O10Ra-0005UF-Fj
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 18:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab0DKQzX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 12:55:23 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51197 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab0DKQzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 12:55:22 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id F3F6B1C15694;
	Sun, 11 Apr 2010 18:55:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id EC62E902D4;
	Sun, 11 Apr 2010 18:55:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id k1T8Yzz3LXxn; Sun, 11 Apr 2010 18:55:18 +0200 (CEST)
Received: from igel.home (ppp-88-217-112-45.dynamic.mnet-online.de [88.217.112.45])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 11 Apr 2010 18:55:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id BB5B4CA297; Sun, 11 Apr 2010 18:55:18 +0200 (CEST)
X-Yow: I think I am an overnight sensation right now!!
In-Reply-To: <y2i51dd1af81004110908mcf6ce8cahf04225d7c261a85b@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 11 Apr
 2010 16:08:27
	+0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144657>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Apr 11, 2010 at 04:13, Junio C Hamano <gitster@pobox.com> wro=
te:
>> A release candidate Git 1.7.1.rc1 is available at the usual places
>> for testing:
>
> This is a minor nit but when I generate the info docs from master I
> get this at the top of user-manual.texi:
>
>     @menu
>     * : id2860714.
>     * Repositories and Branches::
>     * Exploring git history::
>     * Developing with git::
>
> I can't find what produces that token but here are all occurrences of=
 it:

That appears to be because the first title is empty:

$ head -n 9 user-manual.xml
<?xml version=3D"1.0" encoding=3D"UTF-8"?>
<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN" "http://www.=
oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<book lang=3D"en">
<bookinfo>
    <title>Git User&#8217;s Manual (for version 1.5.3 or newer)</title>
</bookinfo>
<preface>
<title></title>

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
