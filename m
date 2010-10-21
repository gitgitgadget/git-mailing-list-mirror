From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv4 00/21] git notes merge
Date: Thu, 21 Oct 2010 16:00:44 -0500
Message-ID: <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 23:01:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P92G7-0004Dv-Ti
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 23:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757926Ab0JUVBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 17:01:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39643 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900Ab0JUVBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 17:01:05 -0400
Received: by gwj21 with SMTP id 21so476581gwj.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LaxJRPy7yMXpYhthT/T2TjYMjL4bZmEHLHcavEpeZrE=;
        b=MBw9coZNsXnAvWaVlOZLzBtwAoMltO5TyQx6nRRv21aaCtWsVL0zb1pJvF2/fPVTR2
         mje3ltxeXaQekyIvjSBqhb5cmNy55bwF2AVjWaKEirJrzPhC2sVdnFI+Ws7lZp2Ccn4D
         Qmr+/lNwzJ5DzQMW/jCpsNszw6++YsnJ8qeVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h8nFBJCm4TyePHK2xKtP/zeSwTlR7+apEALyZro2g3iEUx8OYCdoL/um5oojfDUN5o
         IbwKjDe4sBAX5Sx7Jbj3AucA2C0BAYx2L1JVq1jyZQ7yOUX0NCJLdKSjLh/TsnbJcL7x
         WT9YoUT5Fohwm/MMCyMSq2z+ivXGSzrzdRfyo=
Received: by 10.151.10.12 with SMTP id n12mr4476000ybi.148.1287694864709; Thu,
 21 Oct 2010 14:01:04 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Thu, 21 Oct 2010 14:00:44 -0700 (PDT)
In-Reply-To: <1287626936-32232-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159571>

Heya,

On Wed, Oct 20, 2010 at 21:08, Johan Herland <johan@herland.net> wrote:
> - Sverre Rabbelier suggests renaming 'git notes merge --reset' to
> =C2=A0'git notes merge --abort'. I sort of agree, but would want some
> =C2=A0consistency with 'git merge', e.g. by providing 'git merge --ab=
ort'
> =C2=A0as an alias to 'git reset --merge'.

Can someone comment on whether "git reset --merge" is a good
implementation of "git merge --abort"? If we can get an Ack from
someone I'd love to see this implemented.

> - When resolving notes merge conflicts, you can add/remove files/note=
s
> =C2=A0in .git/NOTES_MERGE_WORKTREE; 'git notes merge --commit' does n=
ot
> =C2=A0check that the notes have any relationship to the notes origina=
lly
> =C2=A0put there by 'git notes merge'. Should we warn about removed an=
d
> =C2=A0added notes in .git/NOTES_MERGE_WORKTREE? Currently we don't, a=
nd
> =C2=A0I'm not sure it's worth it. Users can always review the merge c=
ommit
> =C2=A0afterwards.

If it's easy to do, it would be useful.

> - Fetching and pushing note refs:
> =C2=A0- Add refs/notes/* to default fetch refspec?
> =C2=A0- A way to specify (at clone time) which refspec(s) to set up?
> =C2=A0- A way for the remote repo to hint at which refspecs you might=
 want
> =C2=A0 =C2=A0to set up (by default?)

Didn't we already discuss this earlier? Can you summarize (or at least
link to) that discussion?

--=20
Cheers,

Sverre Rabbelier
