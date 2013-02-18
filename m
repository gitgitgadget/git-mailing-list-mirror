From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 00:14:19 +0530
Message-ID: <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:45:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Vi5-0004Qf-9o
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 19:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010Ab3BRSol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 13:44:41 -0500
Received: from mail-bk0-f45.google.com ([209.85.214.45]:47953 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab3BRSol (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 13:44:41 -0500
Received: by mail-bk0-f45.google.com with SMTP id i18so2681869bkv.32
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UQHZoVR8QrezfOXp1KZztUgMSXlkcLx3kDjO954Lt+w=;
        b=n8Kpuopq959iGJewCJSdkeAEAauDnrIuFik77zfAyWyfj5sSTPHaywr4ivHdee/cED
         lJ6ADC4m40GFDpeQ9Svq6Y5/4f5Lf3jKlb3LIXXKcLzStmillIOEInFN1G2cYmRZE6x0
         ln5ldPc/JyzFVEwVFvBQKe8LhzB29GFZYH9RWCRvBgw76Ioqu15yIhvH+Ki38MtvTu8j
         /esXyRmjvNifzZLn53KH43uFLr4ljdD6mpHKhEsbtOoboUPoHnEEpH1hd69eSC60i9Wf
         ObHQGE59/uKH2YctxzAyi+lyQEBUMOx398MaMDDEg2dcECrSatEYUHhLU0FxWjf5hPjC
         Q4iQ==
X-Received: by 10.204.146.91 with SMTP id g27mr5123825bkv.124.1361213079763;
 Mon, 18 Feb 2013 10:44:39 -0800 (PST)
Received: by 10.205.81.202 with HTTP; Mon, 18 Feb 2013 10:44:19 -0800 (PST)
In-Reply-To: <20130218174239.GB22832@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216494>

[corrected David Barr's email address]

Jeff King wrote:
> And I do not want to blame the students here (some of whom are on the cc
> list :) ). They are certainly under no obligation to stick around after
> GSoC ends, and I know they have many demands on their time. But I am
> also thinking about what Git wants to get out of GSoC (and to my mind,
> the most important thing is contributors).
>
> As far as merged code, I think part of the problem is that git is fairly
> mature at this point. The most interesting projects are of a bigger
> scope than a student with no experience in the code base can do in a
> summer project. Maybe that means we need to do a better job of breaking
> projects down into reasonably sized sub-components. Or maybe it means
> the project is hitting a point of diminishing returns for GSoC. I don't
> know.

I'll be frank here.  I think the main reason for a student to stick
around is to see more of his code hit `master`.  I think it is
absolutely essential to get students constantly post iteration after
iteration on the list. It would be nice to get them connected with 2~3
people in the community who will follow their progress and pitch in
everytime they post an iteration.  It might also make sense to stage
their work in the main tree (a gsoc/ namespace?), so we can just
checkout to their branch to demo what they've done.

Also, we need more projects that will scratch everyday itches.  A
collection of related tiny features might not be a bad idea.  Often,
we risk erring on the side of too-big-for-one-summer when it comes to
specifying projects.  What's the harm of including something estimated
to take 80% of a summer?

On a related note, I don't like our Wiki.  It's down half the time,
and it's very badly maintained.  I want to write content for our Wiki
from the comfort of my editor, with version control aiding me.  And I
can't stand archaic WikiText.
