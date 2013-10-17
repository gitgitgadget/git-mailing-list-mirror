From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Thu, 17 Oct 2013 16:08:19 -0500
Message-ID: <526051c3c2f07_448145fe74a@nysa.notmuch>
References: <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
 <CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com>
 <525e0e1b28c87_81a151de743f@nysa.notmuch>
 <CAEBDL5We2wshgMZcTXoDziXskKvb9s2=2DEZtXRBgbTiitCOZQ@mail.gmail.com>
 <525ee9d93c3af_3983c19e7caa@nysa.notmuch>
 <8629441933A94862982C5CDD6BF47690@PhilipOakley>
 <20131016230634.GO9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 17 23:34:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWvCv-0000VM-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 23:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762950Ab3JQVeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 17:34:09 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:60327 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759508Ab3JQVeI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 17:34:08 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so2647509oag.41
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Uj07w9G4RZFjd9pZK6h0VGx4MaI6F8rwgdkZwoUPWNI=;
        b=H8NtDdfPaaFkt1h59S37Yc2akBana7HtZ+XN4lPFe2Za68gdj38dSQ89rfvVmNop+g
         tjNnS+N84tQCWHBPJ2e0IaM9KNRIbx9lQKyU+BDpJByiSjNUd2zNqngER2bi6JdFlFX5
         mZOjJOnEu/t70sMBPO+Oh0HaU27c8yWXu8yO/luVFjfuUxneBnzRtyQ7x0trC1Dcsg4r
         kGsT7oYfaZTu5/PAiuBsDd1eWHDpFydY0n983pLVku8XtM1bBpY3GSC3fHUEnKqOljXw
         LYrcJvcB+BpwXqnnTmA1suEmH9cNrEzPvp7ozBZTPMks+SqwEoQaNhIvAjmy8WAi5RHQ
         RFcg==
X-Received: by 10.182.99.231 with SMTP id et7mr17272269obb.10.1382045647488;
        Thu, 17 Oct 2013 14:34:07 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm78781758obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 14:34:05 -0700 (PDT)
In-Reply-To: <20131016230634.GO9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236323>

Jonathan Nieder wrote:
> Philip Oakley wrote:
> 
> > Would this be a good time to suggest a specific wording should be
> > proposed (or a reminder of what was proposed repeated) for the
> > documentation of this option. It will be the documentation that
> > users will refer to when they need to know, rather than the list
> > discussions.
> 
> It's not clear to me that this config item is a good idea.
> 
> What is the intended use?  If someone wants to test that their scripts
> will continue to work with git 2.0, wouldn't testing a 2.0 release
> candidate

There is no 2.0 release candidate, and the window between the first 2.0 rc and
2.0 final is limited, such person might not have the time do such testing in
that window.

Moreover, it's not just to test their scripts, but also their fingers.

> (or the current state of the 'jch' branch until one exists)

That doesn't work for the vast majority of users who do not compile Git.

> If someone just likes the proposed behavior changes and wants to start using
> them right away, maybe we can help them by releasing 2.0 sooner ;-)

So basically you are advocating for another v1.6 fiasco, where users start
complaining about the new behaviors *after* the release has been made, and
their user experience has been broken. Is that the case?

> , or by advertising the
> fairly simple changes in commandline usage to get the new behaviors:
> 
> 	Instead of "git add", use "git add -A".
> 
> 	When using "git add -u" or "git add -A" from a subdirectory
> 	of the toplevel, specify "git add -u ." explicitly unless you
> 	want it to apply to the whole tree (in which case use
> 	"git add -u :/").
> 
> 	Instead of letting "git push" guess, name the branch you
> 	want to push: "git push origin master".  Or set
> 	'[push] default = simple' in your configuration.
> 
> 	Pass --prefix to "git svn clone".

I don't get why you don't understand something so simple about human nature.
Every teach knows that you don't just give a lecture, even if the student
understands what you explained, most likely (s)he would not learn it until
after doing excercises.

99% of our users have not read the release notes about the 2.0 changes, 98%
will not read that advertizement you just said, 90% of those who read it will
only get noise, and the ones that read and understand it, might change their
minds once they experience it.

That's why in every game conference they don't just explain to you the new
game, they let you play it, only then the end users can give an honest opinion
about the game.

Perhaps it's unfortunate, but our users are human, and that's how humans work.

We don't know if our users would be OK with the 2.0 changes, it's only after
they have given it a try that they can honestly say, and it's better to give
them as much time as possible and make it easier for them to try.

> The downside of configuration like the proposed core.next is that it
> is hard to explain ("What do you mean that I can't roll back to the
> pre-2.0 behavior in Git 2.0 by setting this configuration setting to
> an appropriate value?"),

It is not hard to explain.

core.mode = next enables the proposed behavior for the next major version of
Git (v2.0), which might change. core.mode = current (the default) enables the
behavior of the current version of Git (v1.x).

It is implied that there's no core.mode = previous, but it can be explicitly stated.

> users or scripts can rely on it, and configuration variables tend to
> accumulate and never be removed.

Not this one, because this one makes it clear that is volatile (although
probably not that much).

> If we really want a run-time switch for this, I suspect an appropriately
> named environment variable would work better, since we have a history of
> being able to remove those without alarming people.

The fact that B has done the job in the past, doesn't mean it would do the job
better than A in the future.

-- 
Felipe Contreras
