From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Arguments to git hooks
Date: Mon, 7 May 2012 03:10:07 +0530
Message-ID: <CAH-tXsDe7Hsacz19egdeW2sDV3SoPkJpJLPAmk_pCoEiR3wvcQ@mail.gmail.com>
References: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
 <20120506191202.GB5725@moj> <CAH-tXsBpfXkr-qWdSBhPu6CcSZbm3f=3i1xJVtk6OkHz1NKCfA@mail.gmail.com>
 <20120506211120.GC5725@moj>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Sun May 06 23:41:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR9Co-0006vU-OX
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 23:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab2EFVkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 17:40:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36391 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729Ab2EFVku (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 17:40:50 -0400
Received: by wibhq2 with SMTP id hq2so20923wib.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XlbbI+TCj0bWtRXtgAoy6h2vt86sumq03wXAAUg6yks=;
        b=VuMuH4synRDjhmlKlPQdBcBIGK/lUlylBx2V5FBTCHeYN+LZK81eh252jfoLllv1AU
         lZUse4xiP30PRBn2u8CQOSZpgrEiohax3nzzD76jWuH8cLHjugQtLJItCh2bL39Hfxp5
         tkxKlY/aKHOukdFDg3FjhKb+yE1HiGnirrozcc0XJIupdqk2A8zZix/NY6hK3WOPUVlF
         yXcwgtEv3A6bivaU79XdOdjkHfAVz1k7/GzHMRb3PHXKe6meAZXTCNxcRhvTGmtGAx0g
         oj00p/nChaw7ej+UM17P1mV3G8ZomunAu0Fsb1ITrGyLXag3Y0tIhDRO3FLBBRF7behc
         zrEA==
Received: by 10.180.101.103 with SMTP id ff7mr7090856wib.6.1336340447989; Sun,
 06 May 2012 14:40:47 -0700 (PDT)
Received: by 10.227.39.96 with HTTP; Sun, 6 May 2012 14:40:07 -0700 (PDT)
In-Reply-To: <20120506211120.GC5725@moj>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197218>

On Mon, May 7, 2012 at 2:41 AM, Marcus Karlsson <mk@acc.umu.se> wrote:
> There are many different reasons to use hooks. If everything that a hook
> could potentially need was passed to it as an argument then a lot of
> data would often end up unused. Better to supply as little as possible
> and only do more work when it's actually needed.

That seems like a good reason not to pass all of the data, but isn't
the file names the most primary thing somebody can ask for?

>> Are you suggesting me to run some plumbing command, parse the result
>> and get the required data ? Is there an easier way to get this done?
>
> I wouldn't go as deep as the plumbing, I think git status --porcelain
> should work just fine, the output is fairly easy to parse.

I have always wondered why 'git status --porcelain' is giving a
'plumbing' style output. Any docs on this somewhere?

-- 
Jaseem Abid
http://jaseemabid.github.com
