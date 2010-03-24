From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Picking up multiple cherries at one go.
Date: Wed, 24 Mar 2010 12:52:22 +0100
Message-ID: <81b0412b1003240452v57026439x7647535391e299fb@mail.gmail.com>
References: <ffef8f9a1003240147o777d058jfacd79aa86908925@mail.gmail.com>
	 <81b0412b1003240221o53196568r9c8f2e0b7a2f1fd7@mail.gmail.com>
	 <ffef8f9a1003240236x34be6051ja8d013453d88d3a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jozef Babjak <jozef.babjak@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 12:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuP8Y-0000Md-2I
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 12:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab0CXLwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 07:52:33 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:54840 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779Ab0CXLwc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 07:52:32 -0400
Received: by bwz1 with SMTP id 1so2766281bwz.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 04:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=evoKmx/X3R3/aavbFchRi+bj5b8euvt/r+U+uY5JF6U=;
        b=Cn8bjW+9iNelhApuZQFtsjdkIsCWCmGG6bM6AGargMpcJn2YxOEOHUVCAlhw3VrBEg
         e0hLoDIIs6BsywWVK9v7x7FWMOmIAHyqp71DnYphZKUUDN48gnOtOk4m16FsCSudl8iY
         wZUYsQ7nyK7mDPT5sRccq0Ew6y9zHXRGOKBWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Mc4KDvjFfVvitJBiMrUWhGCpCnxKC1aYLJdqVw5WlRy+H5obFulE2i3uM2dMSFh/fJ
         RhQcAsi8jSrv89qWIeMrG9Ff6J7M3mVO9+zAOK1kjoxbvoyRudrvpRNlE2qyrWs315jX
         2gtMhTPTrLPsn3EyaJUmgoNj+B62uTuupqg68=
Received: by 10.204.138.219 with SMTP id b27mr7117382bku.139.1269431544019; 
	Wed, 24 Mar 2010 04:52:24 -0700 (PDT)
In-Reply-To: <ffef8f9a1003240236x34be6051ja8d013453d88d3a1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143082>

Please, don't strip gitml from cc. Your questions maybe interesting to
someone else.

On Wed, Mar 24, 2010 at 10:36, Jozef Babjak <jozef.babjak@gmail.com> wr=
ote:
> Thanks for hint. I did not used interactive git commands ever; maybe =
I
> should try.
>
>> Try git rebase -i (interactive) next time. It does not exactly what =
your
>> script does, but ... You may like it.
>
> =C2=A0^-- Do you mean to make a copy of the multi_purpose_branch firs=
t and
> then to rebase interactively that new base onto master or any other
> ancestor branch and removing unwanted comits? The issue is that I
> usually want to keep only small portion of commits in newly created
> topic branch. It seems to be easier to mark somehow 5 commits I want
> instead of 95 commits I do not want.

You'll be amazed how easy it is (and how nothing it costs) to make a co=
py
of a branch: "git branch tmp". And you can rebase-interactive a portion
of the branch you're on: "git rebase -i HEAD~10". This will consider la=
st
10 commits for cherry-picking. And even if you want to review all 100
commits, it maybe not that hard if you have a plain text file with subj=
ect
lines of the commits (and their sha1). You always can start a history
browser of your choice (gitk?) to help you with that.
At least that's how I do that since Johannes invented rebase-interactiv=
e.
