From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Potential GSoC13 projects (Re: Google Summer of Code 2013 (GSoC13))
Date: Mon, 18 Feb 2013 13:11:01 -0800
Message-ID: <20130218211101.GA4022@elie.Belkin>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <20130218193424.GC3234@elie.Belkin>
 <CALkWK0mKZLotuu7pEM_3Of3i6JzU12QV_pHxOZTUr22TOq3PeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Xzt-0003mG-94
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 22:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab3BRVLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 16:11:13 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:49433 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab3BRVLM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 16:11:12 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so2586774dak.25
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 13:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ywXXzGuLWYx82W01oAoG0eJfcvd0wfVTYieAmalxFAY=;
        b=S+0clBfLT2jBf9HC4ivZJDlUA8LdxWxx+KQwyw+8WSXvW3ksTpfgmko8jqXW3JiUjF
         8pKGxea0hkGUVjxXfnVQ3pd3KR1zXQ7Fi4YHrprIaJEptwyJt0SGDUHjr6NTeHIz1sT2
         nEfAtGFHsjsBJUyeO20lido/X9hVrFZzUK7EFctICATEV2M7eeBkxS9kFaYakF/v51dy
         ACbqcBiUuTw1xvzZFEQ6EfN6acIYPc5RpPSkRtsVfk+/yIfitnvLFdhvbzNExAQdQ+Ek
         lqyN29ZEKQFSq9ZHwjgtuFItP19bmvFb3HZcwElji73sP1ZgvJlvdmtRmzlimgOLassb
         i5Ww==
X-Received: by 10.68.144.97 with SMTP id sl1mr34219185pbb.49.1361221871801;
        Mon, 18 Feb 2013 13:11:11 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id x2sm104857351paw.8.2013.02.18.13.11.08
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 13:11:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mKZLotuu7pEM_3Of3i6JzU12QV_pHxOZTUr22TOq3PeQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216531>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>>  - cross-compilable git
>
> Why, exactly?  Git for embedded devices?

My personal motivation would be building Git for Windows while
spending as little time on Windows as possible.  People deploying git
to 32-bit x86, 64-bit x86, and ARM (think "ARM laptops") might also
find it handy.

>>  - incorporation of the cgit web interface, or formalizing a subset of
>>    libgit.a to export as a stable library to it
>
> I didn't understand this: you want cgit in-tree?

Yes, or a stable API that cgit out-of-tree can use.

>>  - moving forward on a project that was the subject of a previous
>>    gsoc project: line-level logging, "rebase --interactive" on top of
>>    sequencer, usable svn remote helper
>
> I can't see a roadmap for gradually phasing out `rebase -i` as more
> and more of its functionality is built into the sequencer.

It's a break-the-world thing.  "rebase -i --experimental".

[...]
> For usable svn remote helper, the major TODO is a git -> svn bridge.

There are other major TODOs, too.

[...]
>>  - drag-and-drop cherry-pick in gitk
>
> You expect someone to write Tcl/Tk today?

Sure, why not?  Tcl is not actually too unpleasant of a language.

Maybe it has a prerequisite, though:

 - "modular gitk" (splitting gitk into digestible pieces)

[...]
>>  - assimilating the distro builds:
[...]
> Overkill.

My itch is that it would let me send packaging patches to the list
and get the usual high-quality feedback.  Oh well. ;-)

[...]
>>  - collaborative notes editing: fix the default notes refspec,
>>    make sure the "notes pull" workflow works well and is documented
>>    well, offer an easy way to hide private notes after the fact
>>    without disrupting public history
>
> I personally don't care for notes much, because I can't see practical
> usecases.

Are you sure that's not because of the poor current state of
collaborative notes editing?

Some example use cases:

 - marking regressions discovered later, to warn people bisecting or
   cherry-picking

 - matching up to corresponding commits in another repository

 - link to corresponding mailing list discussion, blog post, or
   related patches

 - a wiki-like document storing review comments

 - marking which CVE this fixes, once the CVE number has been
   allocated

 - "a tour of the project" for new contributors, using explanatory
   notes that end with a mention the next commit to look at

I'm not married to the current implementation, but I think the basic
idea of "git notes" is a promising feature that could use some polish.

Jonathan
