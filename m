From: demerphq <demerphq@gmail.com>
Subject: Re: Including git-describe info as version strings for generic "-v" output
Date: Mon, 23 Jan 2012 12:16:23 +0100
Message-ID: <CANgJU+XUg8=WMjHLNhe9kxgoGna6m4+YyduBRNGurAke12vLgg@mail.gmail.com>
References: <CAG_NL2So7cf6o+en9ktHGr94Eu5WJ9giWq6OmSxK+ZL4RdtaGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Harry portobello <harryportobello@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 12:16:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpHsz-0007hJ-8j
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 12:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab2AWLQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 06:16:25 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61728 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab2AWLQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 06:16:24 -0500
Received: by ggnb1 with SMTP id b1so1217555ggn.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 03:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NQt68gNCcS+8IXtErUxC0M2EKlwFZwUvi6EQOerCpeY=;
        b=Ed6tvT7cMovMrKdxQZQQG9fN6Fbgk3jL+eub+wjKXlmdoHS7MakmuxYqPJZh2zqvfl
         towKiQmf1OHo0IU3LGQUuGX4vL1PxnxmvlVLqNQFOimxW+8rAeYPR8GBmGnplRxXoxuh
         B9mjH2PizVZBNNRkUJkvt76GB7xohYoLO+YcU=
Received: by 10.101.51.12 with SMTP id d12mr3018279ank.69.1327317383875; Mon,
 23 Jan 2012 03:16:23 -0800 (PST)
Received: by 10.236.63.2 with HTTP; Mon, 23 Jan 2012 03:16:23 -0800 (PST)
In-Reply-To: <CAG_NL2So7cf6o+en9ktHGr94Eu5WJ9giWq6OmSxK+ZL4RdtaGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188987>

On 21 January 2012 20:09, Harry portobello <harryportobello@gmail.com> wrote:
> Hi all,
>
> I hope the subject makes sense -- I'll explain what I'm trying to do.
>
> I'm wondering what the best approaches are to being able to include
> output from git-describe [1] for generic version strings in projects
> managed by Git? This would have to work from within an
> autotools-managed project.
>
> At the moment, I've managed to hook the output from git-describe in to
> a few .m4 files, which works only at ./configure time -- but of
> course, with this being Git, I'd ideally like the same mechanism to
> work in a situation where someone does:
>
> $ git pull && make
>
> It's knowing how to plumb this in to the Makefile.am part I'm hazy over.
>
> Any help would be much appreciated.

FWIW Perl does something like this. Have a look at the Perl makefiles
for an example.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
