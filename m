From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 11:11:44 -0400
Message-ID: <CAEBDL5UaowCZggHijoqPF2UP5B6Y6Bkr9eP+A-Z3-x71W1Oi6Q@mail.gmail.com>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
	<20131014205908.GA17089@shrek.podlesie.net>
	<525c63b6711fa_197a905e845b@nysa.notmuch>
	<20131015123505.GA3097@shrek.podlesie.net>
	<525d35e766ad4_55661275e7426@nysa.notmuch>
	<20131015133327.GA22723@shrek.podlesie.net>
	<525d4354a5436_5844e73e843d@nysa.notmuch>
	<20131015145139.GA3977@shrek.podlesie.net>
	<CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com>
	<525e0e1b28c87_81a151de743f@nysa.notmuch>
	<CAEBDL5We2wshgMZcTXoDziXskKvb9s2=2DEZtXRBgbTiitCOZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Krzysztof Mazur <krzysiek@podlesie.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 17:12:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWSll-0004XM-RN
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 17:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760718Ab3JPPLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 11:11:47 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34128 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760716Ab3JPPLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 11:11:45 -0400
Received: by mail-wi0-f181.google.com with SMTP id l12so942537wiv.8
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eH0CRdfaJbqZ5UutIzAZLnpKpDtH8NjCJCvnAk0fxvw=;
        b=f0MnKKzUj8R3QmVpH4dG2EEEEVV6jxq5GmD2XCOuhIesir4R+MW75OcX8aVHzxUg66
         BRiKJJ7E1zPbF4sINhTjbQDNfijespn0OO4cwd/vOQ2XBFVjU+EPGaMflgK18F6C4p1T
         Dzd0YEa9gL7aIERKsZiyaYOE+Bzp5yimbN2IWFEdKakaNc/9Tyyxz+KFjOzOXQIP4AGd
         L2WN4ah6FB6N5/ISGj4LZeX5lbRLm6adXrZ+FFRGsv+Bz7UgjrUaC3fYL5ncyQ6bKbFE
         wwfX6iORLpD1o94xnXoigdEnixVzqPvSSpeYriyR4bjeZGqGVTsollv+kp+4N6fQW/em
         8OWA==
X-Received: by 10.194.2.108 with SMTP id 12mr1818117wjt.64.1381936304421; Wed,
 16 Oct 2013 08:11:44 -0700 (PDT)
Received: by 10.180.99.169 with HTTP; Wed, 16 Oct 2013 08:11:44 -0700 (PDT)
In-Reply-To: <CAEBDL5We2wshgMZcTXoDziXskKvb9s2=2DEZtXRBgbTiitCOZQ@mail.gmail.com>
X-Google-Sender-Auth: BXHZFZE2nuuMVi9g1QVYlru8xVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236247>

On Wed, Oct 16, 2013 at 6:54 AM, John Szakmeister <john@szakmeister.net> wrote:
[snip]
> "probably a minority" -- I guess that's the part I disagree with.  I'm
> not sure what a minority means here, but I don't think it'll be a
> handful of people.  How big does that number get before we get
> concerned about backlash from users if we decide to change course?
> Or, is that simply not an issue?  Why or why not?  I have to be
> honest, if the option was available, I'd have my developers turn it
> on.  I'm sure a great deal of others would do so too.
>
> Is there some other way we can solve this?  Having an experimental
> branch with all the 2.0 features merged and those concerned can just
> build that version?  I see the downside of that too: it's not as easy
> for people to try, and there is nothing preventing folks from posting
> binaries with the new behaviors enabled.  It leads me to feeling that
> we're stuck in some regard.  But maybe I'm being overly pessimistic
> here, and it's really all a non-issue.  As I said earlier, it'd be
> nice if others chimed in here.

Thinking about this a little more, we do have a proving ground.
That's what the whole pu/next/master construct is for.  So maybe this
is a non-issue.  By the time it lands on master, we should have
decided whether the feature is worth keeping or not.

-John
