From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 20 May 2012 14:04:46 +0200
Message-ID: <CAMP44s2bbJLgqOdi49jS34E79EvNtRifpCbDE_bQUys+3xrs3w@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<vpqehqxmwpj.fsf@bauges.imag.fr>
	<CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
	<CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
	<7v1umv7ub0.fsf@alter.siamese.dyndns.org>
	<CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
	<20120519060031.GB23799@burratino>
	<20120519063208.GA24556@burratino>
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
X-From: git-owner@vger.kernel.org Sun May 20 14:04:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW4sX-0002GI-G9
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 14:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab2ETMEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 08:04:49 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41172 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab2ETMEs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 08:04:48 -0400
Received: by lbbgm6 with SMTP id gm6so2904382lbb.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=22f35EKLY3gNp+IyLTDd5Wn4hxTCJzZPXrNMbKzkSjo=;
        b=EtWjKp19F4EYUkhOavyIQOv/CFdsU/BCE+HsHXgT/yP7KI4H6N2qDfpnTbX8oYQDAz
         C0vWf++/GWHRhr9CxWTsRwx4UNgPbkvLIg3vvIHteqb2ScKSc7NTc2KkaieBCkVwk249
         Tq7LrVREyH9M3+LkIuNruLjmpqf7UmNn6RO/w42GeiTd91FMJ0/+DA+Cro4twjLa+uOy
         XZoRP3kDcCaOyy3D+aO5OJr+bHcTelqCmv/sozC4tZrGZlEQYWLfoVEardDF8AiCjLeg
         8rqy5w9L6gHRSBKUzMsFE5F3sPEK1zvIwRJwaVjcPL77bhevfolGvTRyLGKkThKe3l+1
         NUmA==
Received: by 10.152.109.166 with SMTP id ht6mr16607528lab.46.1337515486557;
 Sun, 20 May 2012 05:04:46 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Sun, 20 May 2012 05:04:46 -0700 (PDT)
In-Reply-To: <20120519063208.GA24556@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198058>

On Sat, May 19, 2012 at 8:32 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jonathan Nieder wrote:
>
>> For the sake of having a proposal: :)
>
> For the command-line interface:
>
> Making the "git stage" command more prominent. =C2=A0Unfortunately it=
 is
> currently a synonym for "git add", which makes "git rm" less
> discoverable and generally isn't very helpful. =C2=A0But if we discar=
d that
> property, it could become a nice way to make some operations more
> discoverable:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stage --add <paths>; # stage an additi=
on
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stage --remove <paths>; # stage a remo=
val
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stage --edit <paths>; # edit the stage=
d content
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stage --apply <patch>; # stage the des=
cribed change
>
> These would be commands that modify the index without touching the
> worktree.

If they are commands, why do they start with --?

'git stage add'
'git stage remove'
'git stage edit'

Would be more appropriate.

But I think revamping 'git stage' should be a separate task.

> Finding a better mnemonic than "also update the current directory cac=
he"
> and "trust the current directory cache" for operations like git apply
> --index and git grep --cached. =C2=A0Better concepts would be "search=
 the
> content staged for the next commit" and "also update the staged
> content".
>
> Maybe:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git apply --index=3D(yes | no | only)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# apply =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D apply --index=3Dn=
o
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# apply --inde=
x =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D apply --index=3Dyes
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# apply --cach=
ed =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D apply --index=3Donly
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git grep --index; # (=3D git grep --cached=
)
>
> I imagine others can come up with something better.

'index'? That goes contrary to this request; the term 'index' should
be avoided in porcelain commands. s/index/stage/ and the proposal
seems sensible, but I fail to see how --stage=3Dno could be helpful, an=
d
--stage=3Dyes should be the same as --stage, and then I wonder what
would be the purpose of having --stage, and --stage=3Donly, where we
could have a --stage(d)-only for commands that need this distinction
(not all of them). If in the future we want more --stage=3Dfoo options,
then it might make sense, but I just don't see that ever happening.

I guess the next step would be to list all the commands that use
--index, --staged, and --cached, and propose new options that would
eventually help to remove --index and --cached (after some period of
deprecation).

Cheers.

--=20
=46elipe Contreras
