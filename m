From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 20 May 2012 13:49:13 +0200
Message-ID: <CAMP44s2cGeQq3V=jS1Xjg-S0-rMyKS79XFN9yFm+4KxMo963OA@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<vpqehqxmwpj.fsf@bauges.imag.fr>
	<CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
	<CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
	<7v1umv7ub0.fsf@alter.siamese.dyndns.org>
	<CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
	<20120519060031.GB23799@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 13:49:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW4dZ-0007Ak-Pg
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 13:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab2ETLtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 07:49:18 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36376 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751843Ab2ETLtQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 07:49:16 -0400
Received: by lahd3 with SMTP id d3so2924790lah.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/oJs7pjL9VUAmmOAcxRvqaOxcr3djzY97OirgG7S+BI=;
        b=VtU4yFpWxU0zF+Nsn+lbPWClQT0aKDNLOScG8fKNYSxHuJdUGP0JdXIsQ3lAUe/ACS
         E2VWkDscuG/jy0r3/zs1jPbOAmnjqy/GgUf6ASG5BkaHC6YQnQsytlLu0qhH73KZbUPK
         Nq6gVaYERBtSLWWm/f4IUOX5Ce4Xjx3x8QjeXvVIu6S0LMcPfQ6TWM4AWHfBk9hkDLUO
         yaKlU4q2x3YCn11nFk6TOpRHBi/glMyOxJNKnEvlnf3c+GsM0qHRokwbtMZ8W9OITuS8
         uGQySuP5OlRHm1J1BChZSjb/xAFQuCln7W6dThJD6WZwSDmKT5toNFw6nR/AHkEmA1Na
         XMBg==
Received: by 10.152.112.138 with SMTP id iq10mr1320372lab.13.1337514553822;
 Sun, 20 May 2012 04:49:13 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Sun, 20 May 2012 04:49:13 -0700 (PDT)
In-Reply-To: <20120519060031.GB23799@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198057>

On Sat, May 19, 2012 at 8:00 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

> For the sake of having a proposal: :)
>
> =C2=A0- the file representing the content of the next command would s=
till
> =C2=A0 be called .git/index and not be renamed

Agreed, that is an implementation detail anyway; the changes should be
done with how the a typical user interacts with git, and a  typical
user doesn't need to know the index exists.

> =C2=A0- adding and removing content to and from the index is "staging=
 a
> =C2=A0 change". =C2=A0Since it is not safe to assume the reader alrea=
dy
> =C2=A0 knows what that means, when working on the manual authors shou=
ld
> =C2=A0 try to imagine themselves as a new user and make the text
> =C2=A0 unambiguous enough to help such a person.
>
> =C2=A0 For example, the first sentence of the "git add" manual:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This command updates the index using the c=
urrent content found in the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0working tree, to prepare the content stage=
d for the next commit.
>
> =C2=A0 should not be changed to:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This command updates the staging area usin=
g ...
>
> =C2=A0 because that just makes it less clear. =C2=A0Before, it said "=
the index"
> =C2=A0 and I could look in the glossary or the .git directory to at l=
east
> =C2=A0 find what file it was talking about. =C2=A0Afterwards, it is u=
sing an
> =C2=A0 everyday term and the new user wonders "which staging area?".

The git's staging area, of course. How is that not clear?

If the (new) user wants to know more about the staging area, she can
read about it, just like she currently can. A 'man git staging-area'
might actually help.

However, there's no 'man git index', or anything like that, so where
do you suppose new users currently look for information when they
wonder "what index"? And looking into the .git directory for an
"index" file? Seriously? I doubt any new user would do that, I haven't
even done so myself. The whole point of documentation is to be user
*friendly*.

> =C2=A0 Instead, it would be better to change it to something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This command modifies the content staged f=
or the next commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0using content found in the working tree. =C2=
=A0It typically adds ...

> =C2=A0 =C2=A0 =C2=A0 =C2=A0The "index" file (see gitindex(5)) typical=
ly holds a snapshot of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the content of the working tree, and it is=
 this snapshot that is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0taken as the content of the next commit. =C2=
=A0Thus after making any
> =C2=A0 =C2=A0 =C2=A0 =C2=A0changes to the working directory, and befo=
re running the commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0command, you must use the add command to a=
dd any new or modified
> =C2=A0 =C2=A0 =C2=A0 =C2=A0files.

I find this paragraph completely unnecessary. This is useless
distraction; the user wants to know about 'git add', she doesn't need
to know about the index, and we should hide it from her.

Instead, the 'git add' documentation should point to the 'man git
staging-area', and there, hidden somewhere is the implementation
details; the index, and all the gory details.

Cheers.

--=20
=46elipe Contreras
