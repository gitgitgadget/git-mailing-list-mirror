From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: How to do a fast-forward merge without a checkout?
Date: Mon, 18 Jul 2011 12:13:46 -0400
Message-ID: <CAF_dkJAx4mK26HcarMtRosy=MU8DgKx9aHWXXbTMK9kG=1LZWQ@mail.gmail.com>
References: <CAF_dkJCvtVqoDmRXMy23ZnZL6iUAVX0nNA9Ev6e4zvBp9mfTpg@mail.gmail.com>
 <CACx-yZ1H5UfA9SeaGy-Ph+20BEsewJe7_78wQsr92Y09skSWHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 18:14:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiqST-0008WK-LX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 18:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab1GRQOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 12:14:08 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:51841 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab1GRQOH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 12:14:07 -0400
Received: by fxd18 with SMTP id 18so6893928fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Tf2WnhQ/hjCl4f8a2r3D7CL954djAItN9PR5NEQgPkM=;
        b=AJbEIrpfjxbC1V80UGuGn5iQmJCeeu2oFD7BtakHhAY5AJVDIxQaYJLjnJFfzzVrOQ
         DoJpeanUTMlYQ8VVfLUxJDuESPf64BN+OjTv4TNK1v8O20pOtjHHuib44NdM3ETi41Bj
         BCDSxW7U4FE4bEKIhRKivsAlXuWb5TLapaYd8=
Received: by 10.223.145.7 with SMTP id b7mr6219647fav.56.1311005646074; Mon,
 18 Jul 2011 09:14:06 -0700 (PDT)
Received: by 10.223.144.203 with HTTP; Mon, 18 Jul 2011 09:13:46 -0700 (PDT)
In-Reply-To: <CACx-yZ1H5UfA9SeaGy-Ph+20BEsewJe7_78wQsr92Y09skSWHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177380>

On Mon, Jul 18, 2011 at 12:08 PM, knittl <knittl89@googlemail.com> wrot=
e:
> On Mon, Jul 18, 2011 at 4:18 PM, Patrick Doyle <wpdster@gmail.com> wr=
ote:
>> [=85]
>>
>> $ git push
>> [=85]
>> To somehost:path/to/repo
>> =A0 e1004df..bad8767 =A0wpd -> wpd
>> =A0! [rejected] =A0 =A0 =A0 =A0master -> master (non-fast-forward)
>> error: failed to push some refs to 'somehost:path/to/repo'
>> To prevent you from losing history, non-fast-forward updates were re=
jected
>> Merge the remote changes (e.g. 'git pull') before pushing again. =A0=
See the
>> 'Note about fast-forwards' section of 'git push --help' for details.
>>
>
> another way to avoid pushing the master branch is to explicitely name
> the branch to push (wpd):
>
> =A0 =A0$ git push origin wpd
>
Thanks... I thought of that, but being basically lazy and not wanting
to have to type all of those extra characters every time I did a "git
push", I wanted to figure out a better way.

Seth Milliken posted a great explanation and alternative solution in a
comment to a blog post I found at
http://ken-blog.krugler.org/2010/02/25/git-failed-to-push-some-refs-the=
-multiple-branch-variant/.
 He suggested doing:

$ git config remote.origin.push HEAD

So that "git push" would default to only pushing the current branch.
I like that approach to my underlying problem as well.

But I stand in awe of Hanne's solution (#2) for it's brevity, the fact
that it does _exactly_ what I was asking about, and that the
capability is already baked into git.

--wpd
