From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH 1/6] Modify description file to say what this file is
Date: Wed, 4 Mar 2009 07:07:14 +0000
Message-ID: <43d8ce650903032307i512268f4sa3240c517b51d0b4@mail.gmail.com>
References: <200902190736.00462.johnflux@gmail.com>
	 <7vy6w2n3cz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 08:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LelDt-0006hH-Px
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 08:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbZCDHHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 02:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbZCDHHU
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 02:07:20 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:12908 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbZCDHHS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 02:07:18 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3761670wfa.4
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 23:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=myO0XBuI8of4Oj58kG31LgZ0GhqRdU1iotqJLr6FxIc=;
        b=A6Cb7Tj6TexqTqMWNGmlOcMBmfZEL2qDU6YIZfnjoHS4iWiQzA9QRYBA55YaPWaHR3
         PRTmPVH8mmG8oiCSS1j4P7vjakckxXga/tJGENxyxJyD+aYPjwIOTO6psr+xqiIDhLuD
         Xu4/U/9MvG8rgO1WBEiTuUxgJVZs88aXT5j44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JpuyPAUHkz6ypmPOjiPp3Qt6FkXjdHVFrsCF3uHvEEqCq2WnAjBQyqtbmlqb2qfVsS
         hb8EnykkpIRgu31noFZ3J+ZwlNSqtn2dGhILl9dAzZ/4V8dD94QxFm8DemEpFM1TgeHd
         RGTEOqb+zCDs38b1VGCRFFW0z+h+m43J5133w=
Received: by 10.142.43.7 with SMTP id q7mr4043319wfq.229.1236150435313; Tue, 
	03 Mar 2009 23:07:15 -0800 (PST)
In-Reply-To: <7vy6w2n3cz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112186>

Hi Junio,
  Did you commit my patches?  I don't see them yet in git.git ?

John Tapsell

2009/2/19 Junio C Hamano <gitster@pobox.com>:
> [PATCH 1/6] Modify description file to say what this file is
>
> Looks good.
>
> [PATCH 2/6] Google has renamed the imap folder
>
> Jeff already pointed out an obvious thinko; I could fix-up locally (j=
ust
> ask).
>
> [PATCH 3/6] Improve error message for branching an existing branch
>
> The extra sentence is useless noise to annoy users and make them shou=
t
> "none of your business!" back to git.
>
> I would probably get this error message "already exists." more from
> forgetting to say "-f" in this sequence:
>
> =C2=A0 =C2=A0$ git branch -f pu next
> =C2=A0 =C2=A0$ git checkout pu
> =C2=A0 =C2=A0$ sh rebuild-pu-script
>
> to rebuild pu on top of updated next, and "did you mean to checkout?"
> misses the mark by a kilometer.
>
> [PATCH 4/6] Improve error message for git-filter-branch
>
> Looks good, with Sverre's rewording would be better, which I could lo=
cally
> squash in. =C2=A0Needs signoff, which I could locally forge (just ask=
 to fix-up
> and forge).
>
> [PATCH 5/6] Change output "error: " to "Error: " etc
>
> Jeff is right, and the patch is wrong.
>
> [PATCH 6/6] Mention to the user that they can reorder commits
>
> The placement of the new message does not feel right, as adding anyth=
ing
> near "If you remove ... WILL BE LOST" will cloud out that message whi=
ch is
> more important.
>
> I think it should come near or perhaps even before Commands, if we we=
re to
> add anything here.
>
> But I am afraid that the proposed new message will hurt the clueless =
users
> more than it would help them.
>
> The cheat-sheet at the top is not for learning what the command can d=
o for
> the first time. =C2=A0It is there to remind people (who already have =
general
> idea on what can be done) how exactly the commands are spelled. =C2=A0=
If
> somebody does not even know that the purpose of rebase-i is to amend =
and
> resequence, he will more likely destroy his history by blindly using =
the
> command without knowing what is going on, than making a lucky guess.
>
> For that reason, a more appropriate line to add, if we were to add
> anything, might be:
>
> =C2=A0# =C2=A0s, squash =3D use commit, but meld into previous commit
> =C2=A0#
> +# If you do not know what is going on, remove everything and exit th=
e editor!
> +#
> =C2=A0# If you remove a line here THAT COMMIT WILL BE LOST.
> =C2=A0# However, if you remove everything, the rebase will be aborted=
=2E
>
>
