From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Problem with "From:" line on "git format-patch" generated patches
Date: Tue, 3 Nov 2009 18:02:05 +0100
Message-ID: <adf1fd3d0911030902x15faffcen86644733ffda43d5@mail.gmail.com>
References: <b8bf37780911030830l42ea6dc2v3ef66e2a9e1ca281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 18:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Mm2-0004IL-4e
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 18:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbZKCRCD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 12:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbZKCRCD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 12:02:03 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:59868 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbZKCRCB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 12:02:01 -0500
Received: by ewy3 with SMTP id 3so2168043ewy.37
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 09:02:05 -0800 (PST)
Received: by 10.216.85.78 with SMTP id t56mr81113wee.126.1257267725813; Tue, 
	03 Nov 2009 09:02:05 -0800 (PST)
In-Reply-To: <b8bf37780911030830l42ea6dc2v3ef66e2a9e1ca281@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131980>

On Tue, Nov 3, 2009 at 5:30 PM, Andr=E9 Goddard Rosa
<andre.goddard@gmail.com> wrote:
> Hi, everybody!
>
> =A0 =A0When I generate patches using "git format-patch" it always mak=
es
> my name garbled in the "From:" line
> as shown below. I'm using openSUSE 11.2 RC 1 (x86_64) with the
> following settings:
>
> =A0 =A0 =A0 =A0# locale charmap
> =A0 =A0 =A0 =A0UTF-8
> =A0 =A0 =A0 =A0# echo $LANG
> =A0 =A0 =A0 =A0en_US.UTF-8
>
> =A0 =A0I've tried changing my environment to use another encoding lik=
e
> ISO-8859-1, but it didn't work as well.
>
> =A0 =A0Does someone can explain why does this happens? Any suggestion=
s?
>
> P.s.: the problem never occurs on the commit message (Signed-off-by)
>
>
>>> >From 584d9bfc7c1d41b76a05655b4562b98fcbef6ee4 Mon Sep 17 00:00:00 =
2001
>>> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Goddard=3D20Rosa?=3D <andre.go=
ddard@gmail.com>
>>> Date: Sun, 1 Nov 2009 14:09:06 -0200
>>> Subject: [PATCH v2 7/7] vsprintf: factor out skip_space code in a
>>> separate function
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset=3DUTF-8
>>> Content-Transfer-Encoding: 8bit

This is the normal encoding for email headers where you cannot use
8bit characters. You have to use a 7bit characters with this
=3D?UTF-8... encoding.

You can check the From: line in your mail, the mail I'm replying:

=46rom:	=3D?ISO-8859-1?Q?Andr=3DE9_Goddard_Rosa?=3D <andre.goddard@gmai=
l.com>

At the other hand the tools using the output of git-format-patch must
deal with this all, as they do. git-am handles it well, if not it's a
bug that should be reported.

HTH,
Santi
