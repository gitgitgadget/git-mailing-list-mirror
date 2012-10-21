From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Sun, 21 Oct 2012 22:31:27 +0200
Message-ID: <CAMP44s3xo6dnNa_-AkhDurvWqp5yC-idoZ_bkcPdPwYsmtWf-A@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.1.00.1210171759230.3049@bonsai2>
	<CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
	<alpine.DEB.1.00.1210171936170.3049@bonsai2>
	<CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
	<CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com>
	<CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com>
	<alpine.DEB.1.00.1210181031320.3049@bonsai2>
	<CAMP44s0jgxqb8EyjCcEdzaDR6y8gqydW7X-C268NahjaXMrh6A@mail.gmail.com>
	<alpine.DEB.1.00.1210212138290.2695@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 22:31:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ2BP-0000KT-Ip
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 22:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205Ab2JUUb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 16:31:28 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36289 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab2JUUb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 16:31:27 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1861515oag.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2ilSddXFDba1i+/wPUiKLrytJJdMfDZ8GnnQyU0trKM=;
        b=l/MevyGDHeLKv+zMHNxv+Gsq9xsoiC1hZSmMKhmTpMnGCOrqSX2geMZqwb/itsDtxT
         RB4tZn50/8R91IGKE4VqTvcVWZD5P74XtKqeX4qHV9mc4UzjDX6q77GTiPwCSEGBrjWi
         rqq6gG99SVr0jmxbqGj6KYLFm7C3ATYPS4SxIevI86g6vyCARjBIg/GoagI2eOAg/evH
         myR7ZtitxW9CWj0tR1GjE038C8f7z6wvMCTv7QwjX0LZv8yq3XHQRx6xhW0qsCWQm+6o
         Hmcz2zE6C6ToEtPeOJjN8021r1KNvZ5U9V3DLTT+0WIXnhn+3sRRQEA3hqi+v2FoLsja
         PYqQ==
Received: by 10.60.5.129 with SMTP id s1mr6330049oes.85.1350851487057; Sun, 21
 Oct 2012 13:31:27 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Sun, 21 Oct 2012 13:31:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210212138290.2695@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208146>

On Sun, Oct 21, 2012 at 10:03 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 21 Oct 2012, Felipe Contreras wrote:
>
>> On Thu, Oct 18, 2012 at 10:47 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > Without push support, remote-hg is useless to me. Without regression
>> > tests proving that it is rock solid, I will not use remote-hg.
>>
>> Done and done. My remote-hg now has support for pushing, all in less
>> than 500 lines of code. It also manages to pass all 14 of the "extensive
>> tests" of your remote-hg. Anything else?
>
> While I think that a lot of effort was duplicated now, and while I am
> still interested in less handwaving arguments than "I find the code
> bloated",

The only way to avoid duplicated effort is to work together, and I've
yet to see where the remote-hg branch is supposed to be (without any
msysgit stuff), so that other people can give it a try, and propose
changes.

> P.S.: Sverre's remote-hg does not really handle octopus merges. It is
> incomplete. I had a good plan how to complete it (see the msysGit wiki
> page about remote-hg) but lacked the time to implement it (the problem is
> that hg does not have octopus merges, and we want things to be
> bidirectional).

Yeah, I'm aware mercurial doesn't have those, that's why I didn't
implement that, other tools do something similar as you mention in the
wiki, but the code is rather convoluted.

Note that this doesn't prevent things to be bidirectional, what it
prevents is using this tool to export git repositories to mercurial,
not the other way around. If you do an octopus merge on a repository
that you know is going to end in mercurial, that's just asking for
trouble, and complaints from the other users of that repo.

Anyway, I don't think that feature is that important, what is more
important is to make sure renames and branches are stored properly. I
have tests that check that the output is the the same as hg-git, but
I'm still not there.

Cheers.

-- 
Felipe Contreras
