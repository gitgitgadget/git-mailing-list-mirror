From: Adam A <hitsthings@gmail.com>
Subject: Re: Bug: Pulling remotes into an empty repo deletes the index
Date: Sat, 3 Aug 2013 22:01:30 +1000
Message-ID: <CAJOTJ-Cgdg4CQs-3t1CsBkq_feVEpkoASzQSTATiVugjs+LL7w@mail.gmail.com>
References: <CAJOTJ-AVamimToPo4oQ=O_Pg+mJHQhardO+NfU8b1dvRxg1KMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 14:01:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aWe-0005Td-Oi
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 14:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab3HCMBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 08:01:32 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:44228 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab3HCMBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 08:01:31 -0400
Received: by mail-qc0-f172.google.com with SMTP id a1so847483qcx.17
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=JSh7WdMu/AUIbkPKkwpUmBKbJ3yzsykiznF0hwfVeGI=;
        b=N0mhnu3WU3AtqH62y5naq4YH8d4wbc4njHdFkIZ6ZS19iQ+BwSwYNB+Vb7HPehmiGf
         3L3XTBkQ0NHsiIMBI8euW021qWKGBmAxnlUDVgYGyCWJtAycpWsfrrPdqTtsPqrqEfDr
         RxhzvfGAaaCJamapcmWfpRzx7J4TWVYun99Ghiiw3faxXHGQWIa51zfEFeOCBcpMejQl
         n4d78gqhCDgxSWO40APSjKXyP6j89e4xCDCSu9/o2+D5EjvoL8kwfKtOZQn6BApglLkc
         oxLKHVbJc+Iq4SZxcbwFXs1jBsGYWPDRHQwaKjQTUIkkTSkMxa6DZjT/uBglzJvUl9lV
         q9jA==
X-Received: by 10.224.22.195 with SMTP id o3mr16574835qab.90.1375531290817;
 Sat, 03 Aug 2013 05:01:30 -0700 (PDT)
Received: by 10.49.16.39 with HTTP; Sat, 3 Aug 2013 05:01:30 -0700 (PDT)
In-Reply-To: <CAJOTJ-AVamimToPo4oQ=O_Pg+mJHQhardO+NfU8b1dvRxg1KMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231594>

Hello, the project readme on github points here for submitting bug
reports, but please let me know if I'm in the wrong place.

Steps to reproduce:

- create a remote repository at URL with commit(s) in it
  - e.g., a new github repo with README and LICENSE files auto-added
- write some files in a local directory
- git init
- git add .
  - the contents of the directory are now in the index
- git remote add origin URL
- git pull origin master

The local files added to the index are now completely wiped out and
replaced with the remote content. I lose all my previous work. :/

This was pretty painful for me to lose a few days of work. I also
couldn't stash my changes which I tried first, but git refused without
an initial commit.

Would have been nice if git warning me about the destructive operation.

Cheers,
Adam

On Sat, Aug 3, 2013 at 9:57 PM, Adam A <hitsthings@gmail.com> wrote:
> Hello, the project readme on github points here for submitting bug reports,
> but please let me know if I'm in the wrong place.
>
> Steps to reproduce:
>
> - create a remote repository at URL with commit(s) in it
>   - e.g., a new github repo with README and LICENSE files auto-added
> - write some files in a local directory
> - git init
> - git add .
>   - the contents of the directory are now in the index
> - git remote add origin URL
> - git pull origin master
>
> The local files added to the index are now completely wiped out and replaced
> with the remote content. I lose all my previous work. :/
>
> This was pretty painful for me to lose a few days of work. I also couldn't
> stash my changes which I tried first, but git refused without an initial
> commit.
>
> Would have been nice if git warning me about the destructive operation.
>
> Cheers,
> Adam
