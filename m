From: Orgad Shaneh <orgads@gmail.com>
Subject: Fwd: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 10 Apr 2013 23:13:38 +0300
Message-ID: <CAGHpTBKn-2dgDwTFtw9eLuJAgFidzEa2itjE+Jc=VrQ0z+-oNA@mail.gmail.com>
References: <1365618262-8024-1-git-send-email-orgads@gmail.com>
	<5165C4EA.60308@web.de>
	<CAGHpTBK6qGUcj=ioWCN2Y5bkhNg8t0ik0BNfXNLww0zjm+1xGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 22:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1Oq-0002Zm-CR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936367Ab3DJUNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:13:40 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:63934 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935623Ab3DJUNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:13:39 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so871836oag.36
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=l1u2amht6H0txM0ysezmRLqMb+xqOZV8cSbZQLQWaCM=;
        b=HEFNcm3O+WuLskFEm9MR83dDwT0uVVF2EiZjSEF+78nPGWMBXYC+iTeukmBAauMIKo
         rH3GpxsxVNiQpzWt9amFdz0e0Kw56Gj0gm8b4/ha8wCnLS67FcA47kT+ZkeQkzGbp21f
         Y9dUZp1WPoB+7C9hqYd7w0m+2SqbZVwuqKoMAfPZvlioPwIzSmh59TksxZPHUAmdO3ln
         7Eb5m4zUklgOpascgBnNfAJwh2A4D2NQEjNteg0ASgQV7a6rNJXx9q+VGbj5vu3pBIAU
         c+75ruu4rDdYfQOqaAc7Rv2bZL06+8+RlMXPn72OPef/QP9qGQOknMOPDks+X0bMsYOd
         bGxA==
X-Received: by 10.182.61.6 with SMTP id l6mr1256941obr.69.1365624818917; Wed,
 10 Apr 2013 13:13:38 -0700 (PDT)
Received: by 10.182.78.35 with HTTP; Wed, 10 Apr 2013 13:13:38 -0700 (PDT)
In-Reply-To: <CAGHpTBK6qGUcj=ioWCN2Y5bkhNg8t0ik0BNfXNLww0zjm+1xGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220750>

On Wed, Apr 10, 2013 at 11:00 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>
> Am 10.04.2013 20:24, schrieb Orgad Shaneh:
> > Executes checkout without -q
>
> Nice, looks like you picked the proposal I made last September:
>   http://permalink.gmane.org/gmane.comp.version-control.git/204747

Took me a while, but I finally got to it :)

> The change is looking good, but you still need to document the
> new option in Documentation/git-submodule.txt too please.
>
> And the commit message is still too short, as I said in that
> other thread:
>
> On Tue, Sep 4, 2012 at 6:28 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> > Before the "Signed-off-by" is the place where you should have
> > explained why this would be a worthwhile change ;-)
>
> And you answered to that with something that would really make
> sense as first part of the commit message, because you explain
> *why* you do that change:
>
> Am 05.09.2012 13:42, schrieb Orgad and Raizel Shaneh:
> > When I run 'git submodule update' I don't expect to be in the dark
> > until the submodule/s finishes checkout, this sometimes can take a
> > significant amount of time and feedback is expected.
>
> Another paragraph after that should explain *how* you do it.
>
> So what about the following as commit message:
> --------------------------------------------------------------
> When 'git submodule add/update' is run there is no output during
> checkout. This can take a significant amount of time and it would
> be nice if user could enable some feedback to see what's going on.
>
> Add the -v/--verbose option to both add and update which suppresses
> the -q normally given to checkout so the user sees progress output
> from the checkout command.
>
> <Your Signed-off-by goes here>
> --------------------------------------------------------------
>
> I'm looking forward to your next iteration.

Done quicker this time ;-)

Thanks a lot for your review (previous and current). It was very helpful!

- Orgad
