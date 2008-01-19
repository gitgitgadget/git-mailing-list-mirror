From: Mark Junker <mjscod@web.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sat, 19 Jan 2008 21:39:02 +0100
Message-ID: <47925FE6.8020704@web.de>
References: <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 21:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGKTW-0003kg-2X
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 21:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbYASUjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 15:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbYASUjE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 15:39:04 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:55776 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbYASUjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 15:39:02 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 7D3DEC99872C
	for <git@vger.kernel.org>; Sat, 19 Jan 2008 21:39:00 +0100 (CET)
Received: from [92.195.28.188] (helo=mark-junkers-computer.local)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JGKSy-0003UG-00
	for git@vger.kernel.org; Sat, 19 Jan 2008 21:39:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
In-Reply-To: <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org>
X-Sender: mjscod@web.de
X-Provags-ID: V01U2FsdGVkX19yBUy1pNsPIrapJ1jWeZ+lVeoiIwwx4KW3iBvk
	zk3IEuF1KOVe4uUX9yQA29XP55udVDP4D6U0h3Zd0XYUe704lu
	PIlZuDPJ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71131>

Linus Torvalds schrieb:

>  - let's say that you have a file "M=E4rchen" on just about *any* oth=
er OS=20
>    than OS X. It could be Latin1 or it could be Unicode, but even if =
it is=20
>    Unicode, I can almost guarantee that the '=E4' is going to be the=20
>    *single* Unicode character U+00e4 (utf-8: "\xc3\xa4", latin1: "\xe=
4")
>=20
>    So from a cross-OS standpoint, that's the *common* representation,=
 and=20
>    yes, you can create the file that way (I don't know what happens i=
f you=20
>    actually create it with the Latin1 encoding, but I would not be=20
>    surprised if OS X notices that it's not a valid UTF sequence and=20
>    assumes it's Latin1 and converts it to Unicode)

=46WIW: I just made a test and it seems that MacOS X refuses the creati=
on=20
of a file with this invalid name.

> Anybody want to creat a compat layer around "readdir()" that does tha=
t NFC=20
> conversion on OS X but not elsewhere?

Maybe I'll try it.

Regards,
Mark
