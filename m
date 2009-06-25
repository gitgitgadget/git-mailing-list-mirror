From: Ryan <ryanphilips19@googlemail.com>
Subject: Re: names using git config
Date: Thu, 25 Jun 2009 10:16:56 +0530
Message-ID: <376636be0906242146h1d4c3b1q8c2e9af26f124af4@mail.gmail.com>
References: <376636be0906240958l70c81b68g83340556f2bf4eca@mail.gmail.com>
	 <vpqljnhv9w0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 25 06:47:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJgs0-0004MY-LS
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 06:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbZFYEqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 00:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbZFYEqy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 00:46:54 -0400
Received: from mail-yx0-f186.google.com ([209.85.210.186]:35520 "EHLO
	mail-yx0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZFYEqx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 00:46:53 -0400
Received: by yxe16 with SMTP id 16so137169yxe.33
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 21:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bgIgfPAHJDwBmg1ODg6Vx+P+9CNOL94SAc/tJ49pmrY=;
        b=HRDKbkqs+g4VKQ5Ee5b9h8merZ7ic1fZXBnozs802N0WntsKfuIO/yd/E88MrDRko8
         XeTkDNbhJb60LjuPyLJDpPtYRaz5H7oWVJaJHOUqC8LlvYd1dgPzLsjlNwK4OpwBGo/k
         OR7bWCwEfxT9zZZ3V2T5gLh7FVQGkVjwnMBiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gNAHIxXWF56Z+wiGO/VsGSBCHBxfMRz6cnL93/tH3rPPwFkDI3vP1mi/1jBblYE4+M
         +vWnezTas/yoX2DM7Yayv4q3cm8vwt6U5exSncRW6QkBDy/wC1JWS8fwIuoCxj+YwDS4
         NOibr8sJx1AED1WEI3QmDNiopGG1F/OAqYFK4=
Received: by 10.231.17.12 with SMTP id q12mr718455iba.55.1245905216130; Wed, 
	24 Jun 2009 21:46:56 -0700 (PDT)
In-Reply-To: <vpqljnhv9w0.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122177>

Hi,
  Thank you for your response.

1) git config user.name 'Matthieu M. Moy' Works
2) git config user.name 'Matthieu M.'  does not


Probably, Name cannot end in a '.' <dot>. in git config user.name


Regards,
Ryan W.


On Wed, Jun 24, 2009 at 10:36 PM, Matthieu Moy<Matthieu.Moy@imag.fr> wr=
ote:
> Ryan <ryanphilips19@googlemail.com> writes:
>
>> How do i select a Name which ends in a dot something like Ryan W.
>> Philips in Git using =A0git config user.name
>>
>> Because when i do that "Ryan W. Philips" It just comes and Ryan W
>> Philips in git log when i add a commit.
>
> Can't reproduce here:
>
> $ mkdir git
> $ cd git/
> $ git init
> Initialized empty Git repository in /tmp/git/.git/
> $ git config user.name 'Matthieu M. Moy'
> $ cat .git/config
> [core]
> =A0 =A0 =A0 =A0repositoryformatversion =3D 0
> =A0 =A0 =A0 =A0filemode =3D true
> =A0 =A0 =A0 =A0bare =3D false
> =A0 =A0 =A0 =A0logallrefupdates =3D true
> [user]
> =A0 =A0 =A0 =A0name =3D Matthieu M. Moy
> $ touch foo; git add foo
> $ git commit -m "foo"
> [master (root-commit) 6814174] foo
> =A00 files changed, 0 insertions(+), 0 deletions(-)
> =A0create mode 100644 foo
> $ git log
> commit 681417491423260ad13c3fb59c28fc96a68bf4f9
> Author: Matthieu M. Moy <Matthieu.Moy@imag.fr>
> Date: =A0 Wed Jun 24 19:05:43 2009 +0200
>
> =A0 =A0foo
> $ git version
> git version 1.6.3.rc1.35.gabb3a
> $
>
> --
> Matthieu
>
