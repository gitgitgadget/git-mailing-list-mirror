From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCHv2] doc: Clarify that "cherry-pick -x" does not use "git notes"
Date: Sat, 16 Apr 2011 13:11:04 -0400
Message-ID: <BANLkTim2=Jg4QcgKwO=J6343zWAoCkyXZQ@mail.gmail.com>
References: <4DA7F73B.9050007@gmail.com> <7v7have8wo.fsf@alter.siamese.dyndns.org>
 <4DA8862F.5070102@gmail.com> <BANLkTi=HecmdGbEX5inqUi4FZ5Ty+L1Ybg@mail.gmail.com>
 <BANLkTi=jr0hkmBUGj7tHURSj5XiJkyyQqg@mail.gmail.com> <7vk4eub1g9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 19:11:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB925-0001t6-Ad
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 19:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab1DPRLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 13:11:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53096 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab1DPRLf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2011 13:11:35 -0400
Received: by ewy4 with SMTP id 4so1007929ewy.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=x9fLafRGUDkmFk0lTWaFQ0jmJIc6Mva113pJuuqbkxo=;
        b=qWD2GJuFVNiC5pnFEqEu5oXpXOMltYCX5RgdU5xCaqDpEUOUIhxqJXcVri3kssmd4j
         Qg9lKibcNXT4MOj0xljiaxkSa/ijJaZlpg4nxvA03XhNJZfv0sEZvOghDghLg5TtTs+c
         VC4zMoG6t9D6uVKUPFXcApsA1lR7KCQ4CDgFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=e5L3a97JLtz4O1xxnVm5qbPjwLpHt48R9H7JZlyD289JbaEaKus4sOlFx40OODs265
         cacZOKAyB6eVXrzhv0D8ihO9VLG9LDsRR55QWQ/d8/Utay/GOnDWJdPYPla43399SyIb
         NfOpQc8bmeHbn6cJxv3jaXKmKfQ3hfAFs00fA=
Received: by 10.213.23.90 with SMTP id q26mr1336861ebb.102.1302973894457; Sat,
 16 Apr 2011 10:11:34 -0700 (PDT)
Received: by 10.213.29.142 with HTTP; Sat, 16 Apr 2011 10:11:04 -0700 (PDT)
In-Reply-To: <7vk4eub1g9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171683>

On Sat, Apr 16, 2011 at 12:33 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> I suspect Jay had the recent CHERRY_PICK_HEAD series that lets you om=
it
> saying "-c <picked>" in mind.

Correct.

> =C2=A0We should not leave the cherry-picked from
> in such a case, I think, but the new code may be buggy.

Disagree. Here was my thought process (it was a conscious decision):
after conflict, when the user runs "git commit", the message is
brought up in the editor, leaving it up to the user to decide whether
it is appropriate to remove the "cherry-picked from" message. I
personally think it is correct to keept it, along with the list of
"Conflicts:". I understand some users think it's not appropriate to
keep the "cherry-picked from" message, but git should not force the
decision.

j.
