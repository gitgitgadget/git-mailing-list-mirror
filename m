From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 16:59:11 -0500
Message-ID: <5356e62feb9f3_6cbadd72f0f1@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <20140422213039.GB21043@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:09:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcisn-0006O9-Dr
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbaDVWJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:09:36 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:62375 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbaDVWJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:09:35 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so123361obc.34
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=JH05PW/SNPExL8ul1F+374KRf3KT5vo4cyG3jBwxE1M=;
        b=TjYIozabToydAG8aObuOsgWvv+yob+37kAPlzbgFXjOzoWuGoHozecMfStMmUfwHQg
         fZwFkfLIqMmXXyayBSiOYo/m+HgjwyZ3ComFOB0Jd709lZTFyrlrspJCjmatj6Lmdguw
         Ot8SWpvfdyWnjtJ/+XtjNnCtkeWcV/RxOUMALc72e1QQqtFOVGp1m1IKZDEKtt1S3vzp
         xpD3I/Rx39DoUufXNKWDRjv/VKn076ITvMPFlUnIQeNfYyMLmQUMIepoXnpmvRImP9e6
         t7d/DnzQz1sbWnYynoVutwCw7NKmlqI4jhu9iSzNS2IPO+icsyQp64oZmWTr9XdG4x9I
         bNsg==
X-Received: by 10.182.129.134 with SMTP id nw6mr34229798obb.34.1398204575331;
        Tue, 22 Apr 2014 15:09:35 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cq1sm182922455oeb.4.2014.04.22.15.09.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 15:09:34 -0700 (PDT)
In-Reply-To: <20140422213039.GB21043@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246792>

Theodore Ts'o wrote:
> On Tue, Apr 22, 2014 at 02:23:18PM -0500, Felipe Contreras wrote:
> > > I am not fundamentally opposed.  I just do not think it would add
> > > much value to new people at this point, and it will actively hurt
> > > if we shoved barely cooked one in 2.0.
> > 
> > You are probably biased in that you've used Git far much more than
> > the average user has (or future new users).
> 
> I think Junio has a really strong point.

What is that point?

> If the goal is to make life easier for new users, allowing them to save a few
> keystrokes is probably not the most significant thing we can do.

No, but it's *one* thing we can definetly do, and since we are not doing
anything else, we might as well do this one thing.

> And we have to balance this with the additional cognitive load in remembering
> how a particular two character alias maps to the "real" command.

What cognitive load? You don't *need* to remember the default aliases; you
don't need to use them at all.

> This is especially true for commands which might not be used as often --
> e.g., "rebase", and for commands where the meaning of "git commit" without
> any argument is qualitatively different from what "ci" (for checkin) means in
> most other source management systems.

ci means commit in Mercurial.

> So I do think it's worth thinking about this very carefully.  For
> certain, I would **not** recommend using shortcuts in example command
> sequences.  If the user reads "git rebase" or "git cherry-pick" it
> means a lot more than if they see a series of apparent chicken
> scratches filled with things like "git rb", "git pi", "git st", etc.

Certainly, but that is orthogonal.

> In fact, to be fair, you may be getting biased because you're used to
> using the two character shortcuts, so for you, of *course* "rb" and
> "pi" and "ci" make a lot of sense.

I can't be biased to those because I don't use them, mine are one character
shortcuts.

And if that hypothesis was correct, why does Mercurial, Bazaar, Subversion,
CVS, and pretty much everything uses aliases? And why does pretty much every
.gitconfig has similar aliases? That would imply that the whole world is
biased.

> But for someone who is starting from scratch, I really question how much it
> helps, and how much it might hurt, to see the two character shortcuts or even
> to have to remember the two character shortcuts.

Here you are talking from your own bias.

It would help when the user starts to think "Geez, I seem to be typing
`git checkout` an awful lot, I wonder if there's a shortcut", which if the
.gitconfigs out there are any indication, it happens all the time.

> And for a command like "rebase" where the user can very easily shoot
> themselves in the foot to begin with, I'd actually suggest that it's a _good_
> thing that they have to type it out in full.

And now you contradict yourself; you actually want to make life harder for new
users, on purpose.

-- 
Felipe Contreras
