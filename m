From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 09 May 2014 04:32:16 -0500
Message-ID: <536ca0a0f38af_39ea14ab31017@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
 <536c8e63448c2_25d198d30c55@nysa.notmuch>
 <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
 <536c966cf0e9c_2bf0e952f079@nysa.notmuch>
 <CABPQNSay4gDJ2Ea-w0=wnU1oqVZ_ATm1Q_M71zt+rAd1XUr0zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 11:32:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WihAL-0000rv-9u
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 11:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260AbaEIJcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 05:32:24 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:46450 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbaEIJcX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 05:32:23 -0400
Received: by mail-yk0-f181.google.com with SMTP id 131so3195940ykp.40
        for <git@vger.kernel.org>; Fri, 09 May 2014 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=PR+YyvEoZjsSpei1mm4Bvh5/CVkTW/y5H7e0VzLYSoU=;
        b=crmcEJAoCh8SBIPg9uhzwEacO7aq7nY2zCyUywYRsa/Ergk0YMyIKNn8Sovdn5Tozy
         rrP2OTL8YGZvB/HDBEOQdGb4UjMQx78/QKYJZS5+wYynE3zuu1Mf8nIqW3jeViv1dGJ8
         vro1O9bnkz1GUit4oHetS3usg48Q43PvPpww31Z6HVOiyIhOuKWHDlAUKW1lEa8fSSRb
         K0HDIjW8JuVglIsidz6xVG875ctFKzZGHlJcz7Z6+NTYf/EpnGSlE67coJO19MC+iW8w
         MKeCGTrjM0nu/LuPA6gJvg3abbhdyuf9H9BNQhsoCCYKzgNwo8mVwqDaMyfHnuh/HdEf
         3FCA==
X-Received: by 10.236.25.207 with SMTP id z55mr13459210yhz.34.1399627942659;
        Fri, 09 May 2014 02:32:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r23sm5389415yhb.46.2014.05.09.02.32.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 02:32:21 -0700 (PDT)
In-Reply-To: <CABPQNSay4gDJ2Ea-w0=wnU1oqVZ_ATm1Q_M71zt+rAd1XUr0zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248542>

Erik Faye-Lund wrote:
> On Fri, May 9, 2014 at 10:48 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Erik Faye-Lund wrote:
> >> On Fri, May 9, 2014 at 10:14 AM, Felipe Contreras
> >> <felipe.contreras@gmail.com> wrote:
> >> > If you want this script to remain in contrib, please:
> >> >
> >> >  a) Write at least a few tests
> >> >  b) Write some documentation
> >> >  c) Explain why it cannot live outside the git.git repository like other
> >> >     tools. [1][2][3]
> >>
> >> (Adding Marius, the original author to the CC-list)
> >>
> >> Uh, why is such a burden required all of a sudden? contrib/README
> >> mentions no such requirements, and the scripts have been accepted (and
> >> maintained) since.
> >
> > contrib/README mentions clearly the expectation that these scripts
> > eventually move to the core once they mature. This is never going to
> > happen for these.
> 
> Yes, *expectation*. Not requirement.

That's right, but these tools fail all expectations.

> > It also mentions that inactive ones would be proposed for removal, and
> > this one is clearly inactive. It has 9 commits (if you count the one
> > that changes the execution bit).
> 
> It mentions that Junio *might* suggest things to be removed, not that
> things *should* be removed if left unmaintained.

That's right.

> And this script is not unmaintained, it's simply just still working.

Prove it.

Either way, if there was people actively caring about these scripts,
there should be cleanups, tests, documentation. But there's nothing.

> >> Besides, you say "No activity since 2010" - this is not the case,
> >> bc380fc is from November 2013.
> >
> > You think changing the execution bit of a file is considered "activity"?
> 
> Well, now we're getting into semantics, which I don't care so much
> about.

Convenient.

> It shows some sort of interest in the scripts, at least.

Not it doesn't. Jonathan Nieder updated the execution bit on a bunch of
scripts in contrib, these being just in the way. It doesn't show
interest at all.

> >> And there's already *some* documentation in the scripts themselves.
> >
> > That's nice. So you can just copy that into a README.
> 
> Feel free to scratch that itch yourself, you're the one inventing new
> requirements here.

If you care about these scripts, you have an interesting way of showing
it.

> >> Please stop your pointless crusade that'll only break other people's work-flows.
> >
> > If you care about these scripts, it should be trivial for you to add at
> > least a few tests, souldn't it?
> 
> Again, testing this is not my itch. Feel free to scratch that one
> yourself, but please don't remove the script.

If you don't care that these scripts keep working properly, I don't see
why anybody else would.
 
> > Please tell me how exactly will your work-flow be broken. More
> > specifically, tell me why your scripts cannot be moved outside of git,
> > like git-extras[1], git-deploy[2], git-ftp[3], and countless other
> > tools.
> 
> Moving the script out of the repo makes it less convenient to bisect
> issues with MSVC, as it depends heavily on the top-level Makefile.
> Moving it out would require figuring out what version of the script
> matches a given git revision, which is a hassle.

The script doesn't depend on the version of the Makefile, and proof of
that is that is has *never* been changed even though the Makefile has.

If you do:

 % cd ~/git
 % ./contrib/buildsystems/generate

You can do:

 % cd ~/git
 % ~/buildsystems/generate

And the result would be *exactly* the same.

That is not a reason.

-- 
Felipe Contreras
