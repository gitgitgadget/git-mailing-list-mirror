From: Tim Uckun <timuckun@gmail.com>
Subject: Re: can anybody explain the following to a git noob?
Date: Sat, 23 May 2009 20:21:09 +1200
Message-ID: <855e4dcf0905230121h28ef22f8n4758953e612325cf@mail.gmail.com>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
	 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>
	 <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>
	 <4A1671E5.4030400@op5.se>
	 <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>
	 <4A16822A.2060404@viscovery.net>
	 <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
	 <alpine.LNX.2.00.0905221244370.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, Andreas Ericsson <ae@op5.se>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 23 10:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7mTn-0002F8-W6
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 10:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbZEWIVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 04:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZEWIVK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 04:21:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:14380 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbZEWIVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 04:21:09 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1290359ywb.1
        for <git@vger.kernel.org>; Sat, 23 May 2009 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TTstWtVbgoLpirCvUWvUFz6yD+m7jwv08vJZmIoWGeE=;
        b=Hc1B40q4ZvEPzExTKEftZ1iLotBTp2kAqWNDc4a29CEJydKmBjhbAIk3Ltq7TzJxCJ
         WlQ4i1yDyXg7KpbisniKhxZvCC/3fhikKqetwW/ithOs7ToGlCO7TxJAOrZuEvywMsqP
         4AnJVvFMcwDXFIdVZIRSWiIyJ95e72pCEJb+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ibDXWkehyeXp2kL99jxoLBOezZ8C+hVd8lzsoJs6XkInXhP+PR/C++FhkOrDsimzsI
         /+QKnHr6cVHOiQLt1FrhtPBfznRmOOY7XvgsCAdqhsr+jGajdcp2tNysWzvaWgedg+JN
         n/+RKLD8YzKaSAY1dUdabEmUJl+mfYb9ixDFM=
Received: by 10.90.88.17 with SMTP id l17mr1672046agb.80.1243066870025; Sat, 
	23 May 2009 01:21:10 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0905221244370.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119760>

>
> Obviously, there's more before the transcript started; otherwise, there
> would be nothing to import in the initial commit, and there certainly
> wouldn't be .git directories that came from nowhere.

Sorry. The command before git init is svn export  blah/blah/blah/

I am taking a rails project and putting it under git.  The .git files
are there in the pluging because the plugins are hosted on github and
they ware installed via git clone.

I know people keep mentioning those directories so I want to repeat
myself.  I renamed the test directory which had no .git folders
anywhere in them.  It contains the tests for the rails project and
nothing else.



> I don't think any
> version control system I know of likes having your initial import be of a
> directory with other working directories for the same system as
> subdirectories. (That is, Mercurial will be fine having git working
> directories in the import, but git won't, and Mercurial wouldn't be happy
> about having Mercurial working directories as subdirectories).
>

I now realize that.  I did however did the same thing again but first
deleted all the .git directories before doing a git init.  The end
result didn't change.


>> > In this case, when you checkout the
>> > branch that does not have test_new, only the tracked files are removed;
>> > the ignored (i.e untracked) files remain. Therefore, after the checkout
>> > you still have a test_new directory.

I now understand that this is the way git works. I wasn't expecting
this though. I was exptecting the master branch to look like it was
before I switched to another branch and mucked around.

As I said in a previous email mercurial worked as I was expecting.
Subversion also works the way I expected. Coming from subversion I
never expected git to carry the new directory name into the original
branch.

The way I have always thought about branches was that they are
isolated from other branches and it surprised me greatly when git
"leaked" the new directory from the "my_branch" branch into master.

I still kind of think I did something wrong.  This behavior seems
extremely odd to me.

> This tends to happen if, while on a different branch, you editted some
> files and left editor backups or compiled (maybe just-in-time) files in
> that directory. Then there are files in the directory that don't belong to
> any branch, since they're not source files.

I didn't edit any files. I didn't compile anything. There should have
been on artifacts of any sort.  I did a commit before switching
branches.


> It's also highly likely that what's missing is stuff you thought you
> imported initially, but did not actually import due to the confusion with
> it already being a git working directory.
>

As I said the test directories did not have any .git directories in
them. If they had  git mv would not have worked.
