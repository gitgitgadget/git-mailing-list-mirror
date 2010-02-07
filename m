From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: notes metadata?
Date: Mon, 8 Feb 2010 00:27:28 +1100
Message-ID: <2cfc40321002070527v3649add4sccbc771d3a51f9e2@mail.gmail.com>
References: <cb7bb73a1002070350j750287abl43de4d936a47acef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 07 14:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne7Al-0000Yq-Vy
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 14:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab0BGN1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 08:27:31 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:62256 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab0BGN1a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 08:27:30 -0500
Received: by pxi12 with SMTP id 12so6162559pxi.33
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 05:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Wvis7yAgwtTfKDexJVTKY8iSMwqfxkDchFcJ0pkFOdY=;
        b=bj0Ewa53br9k2NmFlkIm284I1pYw93ULiMOczETmNjoAT4v+logWqLsyeLJ07c5mJZ
         ziB7EwovgBGPsHmSEAQDgaByfQXQIFu1ok3CYRDiU3Ts1hA2wXEU/ocXrUTwayfD6kuX
         6iIRwE7cPfkY4iLTQT2540FsgTYCHBDSXrM1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Jm8UHpcsf0V7g/50RYqKtQVb4yLOLU6gDEavIZ5BvN9zlFCj2QwAU/f4R/1/2ziX3G
         R7d1+Fx/29iPubKHywCBnAWX9QxVwF5oNGnYmkup85oPZZnd1eHff+2Ot4skU1tWz2eE
         cbAomJ4N931VqyiySVG0+9xBjAsWG+ItiDSh4=
Received: by 10.115.114.13 with SMTP id r13mr3534037wam.69.1265549248974; Sun, 
	07 Feb 2010 05:27:28 -0800 (PST)
In-Reply-To: <cb7bb73a1002070350j750287abl43de4d936a47acef@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139239>

This is already done refs/notes/commits (or any other notes ref) is a
normal commit and so any edits to the notes are thus tracked in the
normal way.

To see this add a note, then use:

    gitk notes/commits.

Regards,

jon.

On Sun, Feb 7, 2010 at 10:50 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Hello all,
>
> ok, this may sound a little odd especially with the 'notes vs
> metadata' thread going on, but I was wondering: do we store _any_ kin=
d
> of metadata _about_ the notes themselves? If I'm reading the code
> correctly, we have neither author nor date information about the note=
s
> themselves, so we don't know who added them or when. Is it too late t=
o
> suggest that this kind of metadata be added to notes? Making them
> full-blown commit-style objects is probalby overengineered and wrong
> under many points of view (not to mention probably incompatible with
> current storage), but maybe we can set up a convention that notes
> SHOULD be in pseudo-mbox format? This would mean that when a note is
> created, the template starts with a 'From ' line including the user's
> name & =A0email and note creation date; when editing, the note is aga=
in
> augmented with the new author name email and date. Of course the user=
s
> are then free do expunge the From lines if they don't want it (just
> commenting it would be enough, of course). How does the idea sound?
>
> --
> Giuseppe "Oblomov" Bilotta
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
