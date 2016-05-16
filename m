From: Chris B <chris.blaszczynski@gmail.com>
Subject: Re: git push --quiet option does not seem to work
Date: Mon, 16 May 2016 09:13:20 -0400
Message-ID: <CADKp0pzOLs5g9Jc6_sA6jr-XOifx0Yn6b7wDW2qcC2UB5Q_WPQ@mail.gmail.com>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
 <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
 <20160515212332.GB31809@sigill.intra.peff.net> <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
 <20160516005824.GA1963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 15:14:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2ILV-0002MU-OJ
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 15:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbcEPNOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 09:14:02 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36777 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbcEPNOA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 09:14:00 -0400
Received: by mail-ig0-f173.google.com with SMTP id qe5so49160495igc.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3P+Ghj2yWqzbj8Fmi1fYzOi35/Z1EXHQBud1A3R70P4=;
        b=guPsJOQyjlkymKwRDKh2KeIe2YmZonFbevy/09QsDnS5kPuJ/CdM/72PTfc9yz1SpW
         jth+5G9qjLAwScOb+qHqW0RZRlVQw4l720ot4zLM/tHNzLB53TQr60yv26ZQx7EdLFsW
         DYRHVORHqUmmAZE1orZ0NZ2yB5SKkMD3nGJdo+6SeqaeWDQw+hjzCbKeYIDttgMuaxma
         CenJ03Wne/FhtMwwLL6wamHQv94mGrHyKxPAGticNl0qdoeVMybRc5CJBJ48WsoWvfL2
         zRhXlPhgCevVDvk5myRp732Rz6OE4W+ul8dKBnwMiqkW7Fuw31WBZlVJmnyCPYsXcjcD
         stMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3P+Ghj2yWqzbj8Fmi1fYzOi35/Z1EXHQBud1A3R70P4=;
        b=VmtJNKDfPWxt28jJ6VFy45mzYyJD3ipDrNRQTRe3RjQvdfRJqbCEJvzWjbelEXlm8D
         kcTnA70zi6wP8Wx1dP2VkxT6vl9vwZ0Y6zpG4eFD5qdrBlXEqC/XtNEYHr1GN8Um9uUV
         m+TEwyrof9JzetDvfuyAx4flkMT3xGyDTOQylbksmhaL6TVlf8Ubw3ZgwahNxOE/XpIv
         /6RuPiiVIZYKSReuBSMCjBJ2dMyY5NwrXsHGY9/UrKSMyHUU8trUoGXtQT9L1+Pgpn/c
         UK9b10Uj5okx4Cozp23gEtJCEm+GC+vKF7zwjSpGjC1L8EqG063wErktquuEjU0qAiKO
         NgnA==
X-Gm-Message-State: AOPr4FW1Kt7UgZ1QwajAZKwS6z38rcEL2wf6+ngTqP1FLaCC3t+IzAeLZUgNGKoSNVhvxNCjcDDqMD/MzS7wiA==
X-Received: by 10.50.58.166 with SMTP id s6mr10744974igq.13.1463404439451;
 Mon, 16 May 2016 06:13:59 -0700 (PDT)
Received: by 10.107.20.88 with HTTP; Mon, 16 May 2016 06:13:20 -0700 (PDT)
In-Reply-To: <20160516005824.GA1963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294733>

PS H:\test-ps\myrepo> "hi" >> whatever

PS H:\test-ps\myrepo> git add .

PS H:\test-ps\myrepo> git commit -m 'boo'
[test1 3cde450] boo
 Committer: xxxxxxxxxxxxxxxx
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly. Run the
following command and follow the instructions in your editor to edit
your configuration file:

    git config --global --edit

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 0 insertions(+), 0 deletions(-)

PS H:\test-ps\myrepo> git push --quiet
git : remote:
At line:1 char:1
+ git push --quiet
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (remote: :String) [],
RemoteException
    + FullyQualifiedErrorId : NativeCommandError

remote: Analyzing objects... (3/3) (119 ms)
remote: Storing packfile... done (113 ms)
remote: Storing index... done (29 ms)
