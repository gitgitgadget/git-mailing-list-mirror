From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 07:05:49 -0500
Message-ID: <5370b91dbd91c_168f13a72fc19@nysa.notmuch>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
 <CA+55aFwf9iAKxbvdPV9Up_T709KwBXJWW4g-F829CRQP4YkivQ@mail.gmail.com>
 <53707b5955034_2b5710592f8aa@nysa.notmuch>
 <5370825f709ef_a8114c1304e2@nysa.notmuch>
 <CALbm-EZhCOvO+RiFs9A+eb-Qri8_1tphCH1JkVo1iWTc3Qcp8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git-fc@googlegroups.com, Richard Hansen <rhansen@bbn.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Dusty Phillips <dusty@linux.ca>,
	Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Christophe Simonis <christophe@kn.gl>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Stefan Beller <stefanbeller@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 14:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjpA3-0006tb-76
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 14:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbaELMQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 08:16:46 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:50628 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbaELMQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 08:16:46 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so7997976oag.37
        for <git@vger.kernel.org>; Mon, 12 May 2014 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=zZGmnSwz5KJo1qMVkuG+tVRRhn7zZO6Emt3jTtuaRl0=;
        b=mf58EcLiGpH3uWoFQtcWMvLAwLMsqadqw2b9BqkTq2bDhxGrIIqBVkFq17h4TYMBdF
         XrHaEIGGaOewKJGiYi0kO5crRGuxFOph0jtfA9p/AyLUwHYO6951GS+8uuWo74o9vrRW
         SuR578kT9JvMxTzTCO5SqmVyliAKHwN55uaWwRNkFyLgExpqSavJUZiLsdUuFQHIUVPX
         ZVadohhNYSSfjeffao4yqghLe/vcj2baGRUJIZiL3sau+ejcWQrNDuD/ENMgmefT/sM8
         jmeIjqICKYuHNT5GW6AROUeoQyKAG8ek0Sbg7hHqLcQ8vDwGt/ZJ4wCuRz7CxzbBkN3R
         KZgA==
X-Received: by 10.182.112.231 with SMTP id it7mr32817464obb.8.1399897005562;
        Mon, 12 May 2014 05:16:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id sm4sm19989768obc.3.2014.05.12.05.16.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 05:16:44 -0700 (PDT)
In-Reply-To: <CALbm-EZhCOvO+RiFs9A+eb-Qri8_1tphCH1JkVo1iWTc3Qcp8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248701>

Stefan Beller wrote:
> 2014-05-12 10:12 GMT+02:00 Felipe Contreras <felipe.contreras@gmail.com>:
> > Felipe Contreras wrote:
> >> Linus Torvalds wrote:
> >> > Felipe, stop this stupid blaming of everybody but yourself.
> >>
> >> Show me evidence that this decision was my fault. Junio certainly hasn't
> >> said so. You just have no idea what we are talking about.
> >
> > Here, let me show you.
> 
> I suspect Linus had a reason not to include the mailing lists
> in the first place

Huh?

He did include the mailing lists in the first place[1]. Either something
is wrong with the mailing list, or somebody is removing the mails.

You can see the full thread in the git-fc mailing list, and there you
can see the git ml is included in all the mails, including the one you
just sent, where you included the git ml, and it doesn't show in the
archives.

> and make a huge public discussion, but instead wrote to you
> personally.  I guess this is just Linus desire not to waste the time
> of everybody as he learned that these discussions are fruitless
> sometimes.

Don't you agree that including transparent bridges for Mercurial and
Bazaar distributed by default would be benefitial to the project?

If a discussion could potentially lead to them being included, I'd say
that wouldn't be fruitless, but it's *precisely* what our end users
would like us to be discussing right now.

> Junio C Hamano wrote [in another thread]:
> > I would not mind asking the others, as your discussion tactic seems
> > to be "repeated voices start sounding like a chorus, and a chorus is
> > project concensus".
> >
> > Those who are observing from the sideline, please raise your hand if
> > you think the three-line "Clarification" Felipe gave us is a fair
> > and accurate clarification.  Anybody?
> >
> > I also do not mind seeing hands raised of those who do not agree,
> > even though I already know that they would be a silent majority.
> 
> I think Junio is behaving very professional unlike you, Felipe.
> This includes being polite and very patient.

> Also this includes weighting different reasons to make
> informed rational decisions.

Where is he weighting the different reasons? I've asked him multiple
times to provide those reasons. He mensions there's one, but he doesn't
say which one it is.

If I haven't see this reason, how do you know he is weighing different
ones?

> Git being a project widely used and people trusting it for their
> work needs to have high quality and cannot go left today and
> go right tomorrow, but most of the decisions are done long-term.

Yes. What is right, and what is left in this example?

Presumably going right would be to include these tools in the core, but
that would imply that he plans to go left in the future. But he hasn't
said that. So what makes you think the project would go "left" in the
future?

> Felipe, this may be the reason, why you think nothing changes.
> It's just slower than you'd like, but with more thoughts weighted.

Really? I'll issue the same challenge I've issued to many people.

Name a single important change in Git (was one way before, it's another
way now) that has happened in the last 5 years. And by important I mean
for starters users noticed it.

You won't be able to, because nothing ever changes.

> Junio, I think you're doing an awesome job in maintaining Git
> and leading the community.

Maintaining, yes, but leading? Leading it where?

[1] https://groups.google.com/forum/#!original/git-fc/Clhss-fXS2k/9UtiilJ2WQ4J

-- 
Felipe Contreras
