From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 01:44:20 +0100
Message-ID: <CAMP44s058Km_=xUn8UvwYwuk0DStTB3bMYu-HPsQWDF-pT_6EQ@mail.gmail.com>
References: <20121109192336.GA9401@sigill.intra.peff.net>
	<CAMP44s3yVtQ4wGqVTyHN-VfAM7iRo9WfNnAu+ns7Zkc_cPBH3g@mail.gmail.com>
	<20121110003331.GA12567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:44:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWzBa-00015w-Ga
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 01:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab2KJAoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 19:44:21 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52994 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab2KJAoV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 19:44:21 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4640708oag.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 16:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lhuMU7htdXA0tuUsk8p91oZv7P5r7vJgPwgwLkBpkSc=;
        b=zW2dBo39yU6A7Sh8RVFnvVezG7hRy9AMVZfVPGJrWEk4EL3kdwBITSVgDRSXm1HDhn
         w1qrq9iMKsJqSX0ro8jIUhHrmSMoY3mx4eyjDZ90Hn+NZvIn7hOl/giYSEA/A7keVry0
         fvxVBorDQZ91k0tGLXvFcc7QFbVjL6J2sRKIMe9RXJcWYWUP4dy6gb6Uks5/3QIlM9ag
         HSW+hfq7ZvYBJ8sISgrmroMfALC5k8TRWBRXtO/KM1LFEpVw6IRTyRr9cFzdIbGAef6b
         hvUdEmfFNcjGC4FtBpI7DUFLI77EzMyj44K4vDBbx7PVmZbnFbqxn3xBPLZoeaSu64V/
         N5tg==
Received: by 10.60.32.19 with SMTP id e19mr9509472oei.9.1352508260265; Fri, 09
 Nov 2012 16:44:20 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 9 Nov 2012 16:44:20 -0800 (PST)
In-Reply-To: <20121110003331.GA12567@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209255>

On Sat, Nov 10, 2012 at 1:33 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 10, 2012 at 12:21:48AM +0100, Felipe Contreras wrote:
>
>> > * fc/fast-export-fixes (2012-11-08) 14 commits
>> >  - fast-export: don't handle uninteresting refs
>> >  - fast-export: make sure updated refs get updated
>> >  - fast-export: fix comparison in tests
>> >  - fast-export: trivial cleanup
>> >  - remote-testgit: make clear the 'done' feature
>> >  - remote-testgit: report success after an import
>> >  - remote-testgit: exercise more features
>> >  - remote-testgit: cleanup tests
>> >  - remote-testgit: remove irrelevant test
>> >  - remote-testgit: get rid of non-local functionality
>> >  - Add new simplified git-remote-testgit
>> >  - Rename git-remote-testgit to git-remote-testpy
>> >  - remote-testgit: fix direction of marks
>> >  - fast-export: avoid importing blob marks
>> >
>> >  Improvements to fix fast-export bugs, including how refs pointing to
>> >  already-seen commits are handled. An earlier 4-commit version of this
>> >  series looked good to me, but this much-expanded version has not seen
>> >  any comments.
>> >
>> >  Needs review.
>>
>> I can send the previous 4-commit version if needed, the only thing
>> that changed is the commit messages.
>
> In the actual code, perhaps, but aren't there significant changes to the
> git-remote-testgit infrastructure that were not originally present? That
> could use some review.
>
> I also seem to recall that the tests in this version rely on the presence of bash;
> don't we still need to mark the tests with a prerequisite?

I meant in the 4-commits.

>> > * fc/completion-test-simplification (2012-10-29) 2 commits
>> >  - completion: simplify __gitcomp test helper
>> >  - completion: refactor __gitcomp related tests
>> >
>> >  Clean up completion tests.
>> >
>> >  There were some comments on the list.
>> >
>> >  Expecting a re-roll.
>>
>> The second patch I can re-roll, but the first patch needs some
>> external input. My preference is that tests should also be simple and
>> maintainable, SZEDER's preference is that tests are better being
>> explicit and verbose (even if harder to maintain) to minimize possible
>> issues in the tests.
>
> I think it is better to keep the tests simple and maintainable. If there
> are multiple ways to do things and they all need testing, then that
> should be clear from the tests, not done haphazardly because some tests
> happen to use a different way of doing things.

Good, that's what my first patch does; no functional changes, just
refactor code into a single function.

> I seem to recall there was a one-liner fix that needed to be rolled in,
> which is why I held it out of next.

Yes, that I can reroll.

Cheers.

-- 
Felipe Contreras
