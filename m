From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 6/7] user-manual: add global config section
Date: Fri, 1 May 2009 11:37:37 +0300
Message-ID: <94a0d4530905010137h772b53f1q8af0d30400a05043@mail.gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
	 <7v7i1zv3cg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 10:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzoFf-0000eH-IP
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 10:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbZEAIhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 04:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZEAIhk
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 04:37:40 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60063 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbZEAIhi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 04:37:38 -0400
Received: by fxm2 with SMTP id 2so2229116fxm.37
        for <git@vger.kernel.org>; Fri, 01 May 2009 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MMrGWhrO68WDgowZHVqFyBWrOBL8qww3ucg7cNs+liI=;
        b=r/rcYIsJ+bIuGZdVEGNZPwz3IzqcXMGlkpLI8O7PIzyvymoDfT7CDq2jELTXMzMPyW
         SMEfUFGk0Un5u+gDyzI/L06tHtR87vtuHIrY/x9tLfCSPF9xKvFU/NyL2erflOfCg202
         l0V5XW3pxOMunJa6toUmM9HJLnTOl4wKj4msk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D42mlaehJSJC8xKfUGjOMWpjJMJYHydpY0kaSTZAvztomr932+hzcDRW5U96MLlP1Z
         8s0CrfvPV9eqTyfUuvr7nqD8xTJNGRIsMjYZ3vl35BGSHwjxZhb0aUXh+ldl9le97OAK
         IJVXYc+9kebz6Gtl4SHvgnXmSycUkeoKKNiBY=
Received: by 10.86.92.9 with SMTP id p9mr2657185fgb.15.1241167057706; Fri, 01 
	May 2009 01:37:37 -0700 (PDT)
In-Reply-To: <7v7i1zv3cg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118060>

On Sun, Apr 5, 2009 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0Documentation/user-manual.txt | =C2=A0 30 ++++++++++++++++++++=
++++++++++
>> =C2=A01 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/user-manual.txt b/Documentation/user-manu=
al.txt
>> index 3278aa7..a3032c7 100644
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -40,6 +40,36 @@ without any explanation.
>> =C2=A0Finally, see <<todo>> for ways that you can help make this man=
ual more
>> =C2=A0complete.
>
> I think a "getting started" section near the beginning of the manual =
is a
> good idea (and ll.40- is a very early part of the manual).
>
> For that "introductory" purpose, however, I'd suggest showing how the=
y
> appear in the actual .git/config file first in the editor and then sh=
ow a
> way to use the "git config" command as an alternative.

I disagree. Opening ~/.gitconfig will just open an empty file for the
new users, afterwards they'll just scratch their heads wondering, now
what?

If you first teach them to do 'git config --global color.ui auto'
they'll blindly enter the command but then when they open the file
they'll say "ahhh, so that's what happens".

>> +[[getting-started]]
>> +Getting started
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Git's configuration is distributed among different locations--this =
manual will
>> +only to deal with 'global' and 'repository' variables, where 'repos=
itory'
>> +variables take precedence over 'global' ones.
>> +
>> +You would probably want to start setting up something useful:
>> +------------------------------------------------
>> +$ git config --global color.ui auto
>> +------------------------------------------------
>> +
>> +This will make prettier the output of certain commands such as `git=
 diff`, but
>> +that's not important; what is important here is that `color.ui` has=
 been
>> +stored in the 'global' (for the user) configuration.
>
> "(for the user)" in parentheses here is better than not saying it
> anywhere, but I think you should have it in the first paragraph where=
 you
> explain there are (at least) two kinds, global vs repository, in orde=
r to
> clarify what you mean by 'global' is not "system/site wide" but "in a=
ny
> repository I use" upfront.

Ok.

>> +View and manually modify the configuration with the `--edit`
>> +option (which will use '$EDITOR'):
>> +------------------------------------------------
>> +$ git config --global --edit
>> +[color]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ui =3D auto
>> +------------------------------------------------
>
> Copies of user manual are found quite easily (and bookmarked by many
> people) on the web, and are looked at by people with not-so-bleeding-=
edge
> version of git, so I'd rather not to give them "config --edit" this e=
arly
> in the documentation. =C2=A0Perhaps after at least 6 months (preferra=
bly a
> year) after a release that has the new option, we can start encouragi=
ng
> it, but not before. =C2=A0So I'd suggest replacing 'with the --edit .=
=2E.' =C2=A0with
> '$HOME/.gitconfig with your favorite editor' or something like that f=
or
> now.

Good point.

>> +Or you can manually edit the file which is located in `~/.gitconfig=
`. Other
>> +locations are `/etc/gitconfig` (system), and `.git/config` (reposit=
ory).
>
> IOW, have this (without "Or") at the very beginning, and then as an
> alternative give "git config color.ui auto".

Read my first comment.

I'll send another round of patches.

--=20
=46elipe Contreras
