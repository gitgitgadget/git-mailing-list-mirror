From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Thu, 12 Jul 2007 12:24:26 +0200
Message-ID: <4C80B6B8-F6D6-4C8B-86F5-629B5662247C@wincent.com>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com> <Pine.LNX.4.64.0707111807470.4516@racer.site> <86sl7u12m3.fsf@lola.quinscape.zz> <7vodiivx50.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 12:25:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8vrK-0008Nk-Ok
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 12:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759501AbXGLKZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 12 Jul 2007 06:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759748AbXGLKZP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 06:25:15 -0400
Received: from wincent.com ([72.3.236.74]:42951 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbXGLKZO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 06:25:14 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l6CAOlS3010015;
	Thu, 12 Jul 2007 05:24:59 -0500
In-Reply-To: <7vodiivx50.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52265>

El 12/7/2007, a las 10:34, Junio C Hamano escribi=F3:

> David Kastrup <dak@gnu.org> writes:
>
>> Don't educate people.  Just don't trigger their problems.  Of course=
,
>> there are millions of ways of shooting oneself in the foot, but in
>> this case the same foot has been hit several times already.
>
> Yup.  We do exactly that in git-clone, git-sh-setup and
> t/test-lib to avoid getting bugged by this stupidity.

El 12/7/2007, a las 9:51, David Kastrup escribi=F3:

> [ "X" =3D "X$CDPATH" ] || unset CDPATH # ignore braindamaged exports

Whatever decision is taken in the end, I think we should avoid terms =20
like "stupidity" and "braindamaged" to avoid causing possible =20
offense. Exporting CDPATH is a simple mistake that can be made =20
inadvertently or unwittingly, but very easily (Googling for "export =20
CDPATH" yields 18,000+ results, many of them purporting to be Bash =20
"tutorials").

Cheers,
Wincent
