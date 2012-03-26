From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Sharing nested subparts of large repository?
Date: Mon, 26 Mar 2012 00:07:23 -0400
Message-ID: <CABURp0r-uY_HH1jw6P9KUvg-XNhYShVLnfcTMH78atdTV9K89w@mail.gmail.com>
References: <1332693502389-7403743.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: LordSmoke <dslice@morphometrics.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 06:08:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC1EA-0000eO-CM
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 06:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883Ab2CZEHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 00:07:45 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57631 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2CZEHp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 00:07:45 -0400
Received: by lbbgm6 with SMTP id gm6so3681973lbb.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 21:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mv3zIFlzwBEmfGhhXc0/4rexGC9ICh1vKfFGnWymMPE=;
        b=S9n5qKOslXA56Fk2wk0cUa6yDU0+uD4bgXA8iJqFEpxt/WQL2+ox/G6i27USnEOic8
         0Dbn+FiJen5537HKN4434O8xNIPYw8ou3OYIWvxigAhymhyp5/ArlaE0cxioeNuvtYDI
         iBZjJR1sPWHagY0xFaX3KO/zWCiu+YumHdiUktURimTZ1Z1lPTDy4XTg6Bv5tg9M9iHO
         gRdLaXnzEjChRAj+hv8wxEnHREVlpEeo/dBPMqcX3ALAgdAHqs9SUQE6u6ydU5Q9SsYb
         IJXFUJFqIs1tgKQZ2aanzPIepOhcFAiPojvHxITT1EPbZV/XyLsrweiXTQAY6xW2QtfF
         /gxA==
Received: by 10.112.86.229 with SMTP id s5mr7441072lbz.0.1332734863513; Sun,
 25 Mar 2012 21:07:43 -0700 (PDT)
Received: by 10.112.55.43 with HTTP; Sun, 25 Mar 2012 21:07:23 -0700 (PDT)
In-Reply-To: <1332693502389-7403743.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193895>

On Sun, Mar 25, 2012 at 12:38 PM, LordSmoke <dslice@morphometrics.org> wrote:
> I've been using git for a couple of months to get used to the system. Basic
> stuff - a few larger project repositories in unique directories, commits,
> pushes to a remote repository. Mostly as a kind of backup system.
>
> However, my ultimate goal is to share part of one large project currently
> being managed with git with my developers. I want them to have access to
> source code and test data, but not my manuscripts, correspondence, whatever.
>
> I also want to make a portion of what I will give my developers available as
> open source, e.g., on github, but not all of it. Just the stable,
> non-developmental parts. NOT the our development stuff and not the parts
> being used for private contracts.
>
> Submodules seem promising, but the examples are not quite what I am looking
> for, as far as I can tell. They talk about isolating submodules that depend
> on a larger project. I want to make available the larger project while
> keeping nested submodules (so to speak) private.
>
> Would someone point me in the right direction to achieve my goals?

There's a blog post detailing a similar workflow here:
http://www.braintreepayments.com/devblog/our-git-workflow

Grr... I think they used to have a section on keeping some parts of
the project "forever private", but I don't see that now.

Phil
