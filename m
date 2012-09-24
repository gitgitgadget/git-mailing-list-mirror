From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Mon, 24 Sep 2012 18:11:56 +0200
Message-ID: <CANQwDwe1H3Va5T7uy6zUJ0oz_mk0=fW8hK_buky4x4hMThY9UQ@mail.gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <201109031738.11678.jnareb@gmail.com>
 <CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
 <201109141939.14070.jnareb@gmail.com> <CAMP44s31xx5qfF4-f3kGsa1uEe7TMVmqSDvB9zL=prR12xwM6g@mail.gmail.com>
 <CANQwDwfVM+besf2if-z6UT6K1QYfj7A7jXsEgfyfxJ1Ww9oBdA@mail.gmail.com> <vpqobkvxwhq.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 24 18:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGBGn-0001Sd-UB
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 18:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab2IXQMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2012 12:12:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60502 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab2IXQMR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 12:12:17 -0400
Received: by obbuo13 with SMTP id uo13so4803155obb.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ltyaoFE1PRRyVdb9nDCBJ6RAuzF9pKMtkUxkIt87qxc=;
        b=IfrNZYtW/EIA0zDjAFpUyqvc1Vz2hLY9eltTQ8rqOKZgqOJCwlfDENIRhPHL0XT7J5
         Nw7g7nhBMf15RmAV/WLMlwSC0PYlGh+2neWg8CMT3nTqy1cguq5fIr7RVXAhBa0I4zFX
         VUK4EKUz6hq/Nz3ixLDHYoHQz0lEMqTabsHYPwJC/a/zxNiHScjWVZBqECNdVeWgu1VN
         YUAvVEdlOLmoIzpeK2cpFWxK6ylsqHmB0OqUuvUWVXFz53IhlNUC8NnY0Qlsu+8BHxNQ
         pkbd2CqufSxvtlLzG8OjJnWYRpp2C6JBTMb3TV+XhR5y/pdGE1R4saCnDatQmJYTvzla
         TmSQ==
Received: by 10.60.29.134 with SMTP id k6mr9974477oeh.5.1348503136715; Mon, 24
 Sep 2012 09:12:16 -0700 (PDT)
Received: by 10.76.163.98 with HTTP; Mon, 24 Sep 2012 09:11:56 -0700 (PDT)
In-Reply-To: <vpqobkvxwhq.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206291>

On Mon, Sep 24, 2012 at 5:37 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jakub Nar=EAbski <jnareb@gmail.com> writes:
>
>> I have created short (well, at least shorter than previous ones)
>> "Git User's Survey 2012" on Survs.com.  The test channel is
>>
>>   https://www.survs.com/survey/J87I3PDBU4
>
> If it's still time, it would be nice to add a question on the kind of
> workflow people use. E.g.
>
> Which workflow do you use? (never / rarely / often / always)
>
> Centralized workflow (everyone pushes and pulls to the same shared
> repository).
>
> One-repository per developer (people push to their own public
> repository, and pull from other user's public repository)

You were not the only one to ask for question about workflows
used; Junio also asked for something similar.

I have therefore added the following multiple-choice question:

#19. What git workflow(s) is used by projects in which development you
participate?
[ ] single developer, only private repository (no interaction)
[ ] centralized workflow (push to common repository)
[ ] branched centralized (push to different branches in common reposito=
ry)
[ ] peer-to-peer workflow (all repositories roughly equal)
[ ] integration-manager workflow (maintainer pulls/applies patches to
"blessed" repository))
[ ] dictator and lieutenants workflow (hierarchical workflow)
[ ] using collaborative code review tool, e.g. Gerrit
[ ] other workflow, please explai

I was also thinking about adding merge vs rebase question, but it
is direction orthogonal to above, so maybe as separate question...

--=20
Jakub Narebski
