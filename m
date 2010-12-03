From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Merging (only) subdirectories
Date: Fri, 3 Dec 2010 11:12:47 +0000
Message-ID: <AANLkTina5UwRZVGOVdnAJe0U2B_rCiGhoOdSArw6ZQd+@mail.gmail.com>
References: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com>
	<AANLkTik-d8oys9h=wFRnyt8sukTsSymaw5LGM39BU2K=@mail.gmail.com>
	<20101203105957.GA14783@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 12:12:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POTZO-0005cF-Nu
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 12:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358Ab0LCLMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 06:12:49 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58202 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab0LCLMr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 06:12:47 -0500
Received: by ywl5 with SMTP id 5so4692265ywl.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 03:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=6fxE29pmKi79DAlJTx+t1NTDdFbDpWq4ME//IMBJ5CQ=;
        b=dwtnaMN/8TuyVbOJz5sadmEShRRBTtE/zuPCUAB7rmPVfui9UL02b4zCnQ6BMTdx/1
         YwhHaD0WSHrn7w48hePqbfnWJybPrG9okw3WPSsbr7CS5+ZBHw0B160SvF0uNsBrs+o+
         1m+8T9bHW7s2rOLnz49zlo0dzBH3qsRvJiI8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        b=FcfevDNSttyD5hpsu5SoQjgI9OaKo+wmz3tmAF11JxJ+GWGcoBpTf1uYAj6d0yToyh
         KV0pAxyo97ayj7iC8By5F3mmEyojNfZR4GdMeLFTGsW8bs1WLPBjfCHtbsOXDBpcLLbJ
         AHKxGvEwjjy+QQavtTFW0NgRH4gln1zGHaWuI=
Received: by 10.101.56.12 with SMTP id i12mr1384120ank.142.1291374767160; Fri,
 03 Dec 2010 03:12:47 -0800 (PST)
Received: by 10.100.38.15 with HTTP; Fri, 3 Dec 2010 03:12:47 -0800 (PST)
In-Reply-To: <20101203105957.GA14783@nibiru.local>
X-Google-Sender-Auth: HI2y3aBxdapwbpfQ69YFVHSLJ7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162789>

> Another option could be completely splitting off the themes to
> their own branches (eg. using git-filter-branch), check them
> out in an separate workdir and use unionfs to get a combined/merged
> view of the working trees.
>
> So, you'd actually have to fully separate branches, checked out
> in their own worktrees/repos:
>
> a) mainapp (the main application)
> b) theme (the current theme you're working on)
>
> For testing/runtime, the webserver gets a union'ed tree,
> which just merges both namespaces (from host filesystems's, not
> git's view) together. Your actual development happens in the theme
> repo only.
>
>
> On actual deployment (if you're using git here, too), you can simply
> merge both branches together (will be just an passive - aka:
> merge-down-only - branch).

Ok... thanks for that. I'll have a look at that as well.

This type of thing was actually the one thing I can think of that
cvs/svn made easy as they keep the repo info in each directory :)  (Do
I get thrown out for saying that?)
