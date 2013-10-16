From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 14:57:18 -0500
Message-ID: <525eef9ea46bd_3983c19e7c61@nysa.notmuch>
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
 <CAEBDL5UaowCZggHijoqPF2UP5B6Y6Bkr9eP+A-Z3-x71W1Oi6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Mazur <krzysiek@podlesie.net>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 22:09:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWXOr-00067O-3w
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 22:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760584Ab3JPUIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 16:08:52 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:39454 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab3JPUIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 16:08:51 -0400
Received: by mail-oa0-f43.google.com with SMTP id i3so1141263oag.16
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=BR16IKIOHVmH1VPokfKifOPxKQwlSHF/GVVqubsxdh0=;
        b=G6WZ+Hp0ogPTZki217ul6Ii5Jd9u7NiUlFMhz/m/imE8oJKeICVCD/PQCZtCTfRECP
         WmPE9tN2euFS+jV31EbvOdE5KhHjGLLN+f4L+TNz0Knu4q/9erb0p4xFYMB/NCjfwtD9
         oyTWHbY6uoB/G3oqZQHkeihlzJ9s6+wgOIQFhCOzEz7Kez0lo/EeUKFRlsPTLUrOs4uH
         Ozqjp7UYRTQrFSx6CV4FArGgRbXL2FiXLjtxePgDg4e5w/Hf9OH00Cd0yNQojY/zLnvZ
         GTqpe+S5gTIIdKZWC1Du37oQJYLmKNo+wHbJVaV0fXBRZ8CH+XQ+mT6Fyb6tKIHFE1No
         Cacg==
X-Received: by 10.182.60.194 with SMTP id j2mr7617522obr.2.1381954131111;
        Wed, 16 Oct 2013 13:08:51 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm65638582obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 13:08:50 -0700 (PDT)
In-Reply-To: <CAEBDL5UaowCZggHijoqPF2UP5B6Y6Bkr9eP+A-Z3-x71W1Oi6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236259>

John Szakmeister wrote:
> On Wed, Oct 16, 2013 at 6:54 AM, John Szakmeister <john@szakmeister.net> wrote:
> [snip]
> > "probably a minority" -- I guess that's the part I disagree with.  I'm
> > not sure what a minority means here, but I don't think it'll be a
> > handful of people.  How big does that number get before we get
> > concerned about backlash from users if we decide to change course?
> > Or, is that simply not an issue?  Why or why not?  I have to be
> > honest, if the option was available, I'd have my developers turn it
> > on.  I'm sure a great deal of others would do so too.
> >
> > Is there some other way we can solve this?  Having an experimental
> > branch with all the 2.0 features merged and those concerned can just
> > build that version?  I see the downside of that too: it's not as easy
> > for people to try, and there is nothing preventing folks from posting
> > binaries with the new behaviors enabled.  It leads me to feeling that
> > we're stuck in some regard.  But maybe I'm being overly pessimistic
> > here, and it's really all a non-issue.  As I said earlier, it'd be
> > nice if others chimed in here.
> 
> Thinking about this a little more, we do have a proving ground.
> That's what the whole pu/next/master construct is for.

No, that's not true.

'next' doesn't contain experimental patches, it contains potentially dangerous
one that might benefit from some testing before going to master, but they are
certainly not experimental.

'pu' doesn't contain experimental code either, the code in 'pu' has to be
feature complete. It might require a few more tunning patches, but it's not
experimental, and those branches are not long lived. For example the pack-v4
patches could be merged today, and the people involved could keep working on
top of that merge point, but that doesn't happen, because 'pu' is not for
experimental stuff.

There is no place in the Git repository for pack-v4, because there's no place
for experimental patches.

> So maybe this is a non-issue.  By the time it lands on master, we should have
> decided whether the feature is worth keeping or not.

I believe without an experimental branch, many branches would never mature to
go into master, or next, or even pu.

-- 
Felipe Contreras
