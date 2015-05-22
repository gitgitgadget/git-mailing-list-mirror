From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Fri, 22 May 2015 10:17:03 +0100
Message-ID: <CAFY1edZhznDENput-3E=GRrHsWXcWd5Pr3nieOVShuJ8gMfCiQ@mail.gmail.com>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
	<20150501175757.GA10569@book.hvoigt.net>
	<CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
	<5547C961.7070909@web.de>
	<CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
	<37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
	<CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
	<20150518123036.GB16841@book.hvoigt.net>
	<CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
	<20150519104413.GA17458@book.hvoigt.net>
	<CAHd499D9vOtLOBj2s5EOfsojSStZY+HdZR35icZ5cssLNkcD-A@mail.gmail.com>
	<CAGZ79kZf_C=QkfQ+LV9G9fLsfqE9USrwkMiNdLmz0-BtPuAmRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri May 22 11:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvj4r-0003HE-OM
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 11:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbbEVJRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 05:17:08 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35848 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161018AbbEVJRE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 05:17:04 -0400
Received: by igbpi8 with SMTP id pi8so30861160igb.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type;
        bh=u3f08CjcmOqtBbB48WoedAKvmrMOzZ8mYGuWP5g+B9I=;
        b=ENgiqi5fz7F8+J+k/Dqqxbzv0KUTd7A/B8/+UicDQ3/ZQyJJcb0QYZpi8YPe/MoaT8
         6vl8cprU9Z8MAoknLTRy9ls32+uVWETnyKB/ALexaxNufTJfvNzCuytvXvwOFkjmY0gh
         bxiPnIZqdB5dVEHMzkkqR7JAroKMzXeQamAPV9UkkM/vEMB68sxPam10i5953Nd3RAM6
         ALOy1rLPj2h8zWkVvyg3MuipxqJriAo5RUsthTVluYXyiu5Bq6MjC0OyKx85koCLul5U
         8R9lrYR9hySllEleMP/RSTKjvNjiM/UBNT/bSItdEcuRv+2DSGeIQB6nTKwFRu6XAre6
         v1lg==
X-Received: by 10.42.185.12 with SMTP id cm12mr8570673icb.0.1432286223606;
 Fri, 22 May 2015 02:17:03 -0700 (PDT)
Received: by 10.79.35.162 with HTTP; Fri, 22 May 2015 02:17:03 -0700 (PDT)
In-Reply-To: <CAGZ79kZf_C=QkfQ+LV9G9fLsfqE9USrwkMiNdLmz0-BtPuAmRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269701>

On Tuesday, 19 May 2015, Stefan Beller <sbeller@google.com> wrote:
> On Tue, May 19, 2015 at 12:29 PM, Robert Dailey
> <rcdailey.lists@gmail.com> wrote:
> > How do you send your patches inline?
>
> This workflow discussion was a topic at the GitMerge2015 conference,
> and there are essentially 2 groups, those who know how to send email
> and those who complain about it. A solution was agreed on by nearly all
> of the contributors. It would be awesome to have a git-to-email proxy,
> such that you could do a git push <proxy> master:refs/for/mailinglist
> and this proxy would convert the push into sending patch series to the
> mailing list. It could even convert the following discussion back into
> comments (on Github?) but as a first step we'd want to try out a one
> way proxy.
>
> Unfortunately nobody stepped up to actually do the work, yet :(

I've replied to this on a separate announcement thread on the Git mailing
list here:

http://thread.gmane.org/gmane.comp.version-control.git/269699

...I've created a new tool called submitGit, which aims to help.

> > I am willing to review the typical workflow for contributing via git
> > on mailing lists but I haven't seen any informative reading material
> > on this. I just find using command line to email patches and dealing
> > with other issues not worth the trouble. Lack of syntax highlighting,
> > lack of monospace font, the fact that I'm basically forced to install
> > mail client software just to contribute a single git patch.

I'd be interested to know what you think!

Roberto
