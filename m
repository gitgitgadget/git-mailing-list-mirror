From: Lionel CHAZALLON <LongChair@hotmail.com>
Subject: Re: how do I ignore a directory for diff
Date: Sun, 5 Apr 2015 16:19:50 +0200
Message-ID: <BLU436-SMTP49446C5C4D772905567D4B4FF0@phx.gbl>
References: <BLU168-W455AD13F694F68E77DFD0EB4FF0@phx.gbl> <20150405121705.GE21452@serenity.lan>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 05 16:19:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YelP4-0002Hm-CI
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 16:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbbDEOTx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2015 10:19:53 -0400
Received: from blu004-omc3s17.hotmail.com ([65.55.116.92]:57883 "EHLO
	BLU004-OMC3S17.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863AbbDEOTx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Apr 2015 10:19:53 -0400
Received: from BLU436-SMTP4 ([65.55.116.72]) by BLU004-OMC3S17.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.22751);
	 Sun, 5 Apr 2015 07:19:53 -0700
X-TMN: [Y0sO1aMxI6VCficuTfH++wGZtSUkMWqp]
X-Originating-Email: [longchair@hotmail.com]
In-Reply-To: <20150405121705.GE21452@serenity.lan>
X-Mailer: Apple Mail (2.1993)
X-OriginalArrivalTime: 05 Apr 2015 14:19:52.0518 (UTC) FILETIME=[95177E60:01D06FAB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266806>

Hello John,

Thanks for the answer. I am also using some GUI client (smartgit). Is t=
here any way to make this part of the repo attributes / configuration s=
o that my git GUI would use it ?=20

Lionel.

> Le 5 avr. 2015 =C3=A0 14:17, John Keeping <john@keeping.me.uk> a =C3=A9=
crit :
>=20
> On Sun, Apr 05, 2015 at 11:31:54AM +0000, LongChair . wrote:
>> I have been looking into ignoring a subdirectory of my tree for
>> diffing with upstream.  I'll explain the situation below :
>>=20
>> My tree is a fork of an upstream repo.  There is a specific director=
y
>> in my tree lets call it foo/bar that i would like to ignore for diff=
=2E
>> This directory includes only files that i added to my repo and is
>> therefore irrelevant for diffing (i know all files in there have bee=
n
>> added and are not in upstream). Having there in the diff is just
>> making a lot of files to appear and that is confusing to see what is
>> changed from upstream.
>>=20
>> I have read the docs and found a way mentioning that i should add a
>> line to .gitattributes with : foo/bar/* -diff
>>=20
>> But this still lists the files in there when i'm diffing.
>>=20
>> Is there any way to achieve this ? i cant find any clear explanation
>> in the docs.
>=20
> Since git-diff takes a pathspec you can use the exclude magic to excl=
ude
> certain directories like this:
>=20
> 	git diff upstream -- ':(top)' ':(exclude)foo/bar'
>=20
> or equivalently:
>=20
> 	git diff upstream -- :/ ':!foo/bar'
>=20
> The documentation for the pathspec syntax is in git-glossary(7).
