From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 5 new messages
Date: Wed, 20 Feb 2013 06:51:28 +0100
Message-ID: <CAN0XMOLjkrZ-a0DWXJzDfcbOgMPetRBmQHVSVn8ju4+W32C2KQ@mail.gmail.com>
References: <1361293966-3975-1-git-send-email-ralf.thielow@gmail.com>
	<87ehgcoyxm.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 20 06:52:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U82bF-0007yQ-E7
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 06:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662Ab3BTFvg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Feb 2013 00:51:36 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:61481 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757582Ab3BTFva convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2013 00:51:30 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so5980243wie.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 21:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=ZgubKno8johivEv/2FQyzL7aWFLy9hynBNmXG8oiibw=;
        b=VVOVkDre5CgD6UuGxwfBNFMYkyUuR4tkFTwayOOzlkA44N9pCKpqx52iCGWRfg7plQ
         K7B3PmKWXGJbZtmcRfbr1a/hQqnO5Ai5kbD9npuhMHMqLnlcRU08Q6TGKWyUXcAPwljM
         aVuFEU6myEEdbrRVVOYTi66o3vzAWUiS2YH6Ykx3uqBzKOrDx+A8w826Isa65H5+JwrC
         iVNtLqklaCCY1c0DH5U+o1a3GTDEIvhLRBnj+/UHQIzdUWIeDPX2VETnDTZ2uhO+hxdF
         vMmWcbVtnQrYN9gZ67Ye1qKGef8nqotE20d8TD+EA8Q7yrSAVzRwg3p0+MlSApLAFeYo
         qUCA==
X-Received: by 10.180.79.6 with SMTP id f6mr31590670wix.26.1361339488947; Tue,
 19 Feb 2013 21:51:28 -0800 (PST)
Received: by 10.195.12.199 with HTTP; Tue, 19 Feb 2013 21:51:28 -0800 (PST)
In-Reply-To: <87ehgcoyxm.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216680>

Hi,

2013/2/19 Thomas Rast <trast@inf.ethz.ch>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>>  msgid "You are currently bisecting branch '%s'."
>> -msgstr "Sie sind gerade beim Halbieren."
>> +msgstr "Sie sind gerade beim Halbieren in Zweig '%s'."
>
> I know this one is already in other messages (and also in the Glossar=
y),
> but I still find it iffy and I might finally have a better idea:
>
>   Sie sind gerade an einer bin=C3=A4ren Suche in Zweig '%s'.
>
> [note to English speakers: I'm just using "binary search" instead of
> "bisect"]
>
> That makes it quite a bit harder to use it in a verbed[1] form, but I
> think it gets the concept across much better.  (And in all the usage =
I
> know in CS, the two things refer to the same.)
>

Very good idea! Thank you. I'll create a patch on top and update the
glossary.

> ACK on the rest.
>

Thanks for review.

>
> Footnotes:
> [1]  Verbing weirds language. -- Calvin
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
