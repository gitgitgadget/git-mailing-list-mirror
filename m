From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 15:19:03 -0500
Message-ID: <5373cfb744982_57c3bfb300a0@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
 <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
 <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
 <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
 <CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
 <87mweku2pt.fsf@fencepost.gnu.org>
 <CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
 <87iop8u1km.fsf@fencepost.gnu.org>
 <CAGK7Mr4N5L+jRE0ykBHvopgGv1x4iNXAK+_94R5KhBxHHqMYmA@mail.gmail.com>
 <87egzwtthf.fsf@fencepost.gnu.org>
 <CAGK7Mr6XTxpeJLSqL8PZMS8w+YCqxLrC5wX-dg4BdEaW3QAYTA@mail.gmail.com>
 <87a9aktqms.fsf@fencepost.gnu.org>
 <CAGK7Mr7jhpizoHuA9NDnyNPy_rr8_R0m8-hCFO3CDn2Hbh3_pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 14 22:30:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkfoY-0001du-Om
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 22:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbaENUaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 16:30:04 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:57901 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbaENUaC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 16:30:02 -0400
Received: by mail-oa0-f42.google.com with SMTP id j17so114898oag.15
        for <git@vger.kernel.org>; Wed, 14 May 2014 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=1sHuWvJo1BErXgBkTht9rPljFoqDAnRAimQ2M+uN+4c=;
        b=yYqU5mn8YSKLuhDWhNYUIMbq0OPt6oGmv7sJKqhYIj0Khl56xROdTCWMRyCwv93Bzq
         HxAYnDoqaHLduSrO40fCZshMHFNG79UPI2Pz6j/6ltptsMnsQBlYNtDevD0nuSbwe9Bo
         Jb5YDZVIjByYPjSQpsqNxO3pK9YukiK8y7W3VkybsHiRVR/U5O/oGAiDynRMRgmw11d7
         09sB9SddPVrdtAWAz2FOJP7Sf3HBSxAhD2Ym4+gfI69T0beun1XoA2IZCV1UBY1hiSix
         Z5ZUHbu+6e8VwAfxQdSSeDhdQ2Ecw9LJuPGe7mvHXJqu/AQEW/JFahx2BlamgroQixSj
         1bKQ==
X-Received: by 10.60.44.204 with SMTP id g12mr5784404oem.38.1400099401795;
        Wed, 14 May 2014 13:30:01 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id z8sm7475594oey.5.2014.05.14.13.30.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 13:30:01 -0700 (PDT)
In-Reply-To: <CAGK7Mr7jhpizoHuA9NDnyNPy_rr8_R0m8-hCFO3CDn2Hbh3_pQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248948>

Philippe Vaucher wrote:
> >> I'm sorry that my words aren't clear enough for you to infer the point
> >> I'm trying to make. Let's try something simpler: what I was saying is
> >> that bad behavior will get you into trouble when contributing (and
> >> thus it's important to behave nicely), where Felipe usualy says bad
> >> behavior is irrelevant because only truth/quality is important.
> >
> > Do you feel Felipe is in control of what you label bad behavior?  Do you
> > feel you are in control over how you react to his behavior?
> 
> I feel that Felipe cannot control this (or decided not to),

I am pretty much in control of my behavior. Those who know me personally
know that I *never* get angry.

The problem is that what you label as "bad behavior" I do not. For
example the atheist billboard that said "You KNOW it's a Myth. This
Season, Celebrate REASON!" caused a lot of furor, and people all over
U.S.A. said "you cannot say that!", "that's offensive!", "it's a war
against Christmass", "that shouldn't be tolerated in modern
society", and so on.

Of course, it should be tolerated in a modern society, and it should not
be offensive, those are facts. Of course people can disagree with those
facts (but those people are wrong).

The atheists are not engaging in bad behavior, it's just that the
majority constituted by religious and bend-over-backwards-liberals have
a different definition of "bad behavior" (a wrong definition).

So if somebody convinced me that my behavior is indeed bad, I would certainly
change it, but I do not think it's "bad". Just the same way nobody has
convinced many atheists that their behavior in those billboards is bad.
And they can't convince them, because they would need logic, reason, and
evidence, and the atheists have them.

> > Yesterday my girl friend bought back a mare she had sold two years ago
> > because its owner did not manage to get along with it.  It's a
> > temperamental animal that learns and performs amazingly well for its
> > comparatively compact build.  But it's highest in rank "or else", and so
> > in the end it got locked up in its stable box most of the time in order
> > to avoid injuries to other horses.  Now it's back here at the riding
> > school, and there is little question that there will be some injuries
> > before things settle down again even though most of the horses here know
> > it already.
> 
> I think that is the point: behave properly or be isolated to avoid
> harming others. Wether you control your behavior or not has little to
> do with it, it's your behavior that counts. That's how it works in
> pretty much any communities I know of.

Except the largest and most important communities; countries. In the
vast majority of countries what is labeled as "bad" (a.k.a. illegal) has
had much more consideration (millenia) than in most online communities
(barely decades). Saying something is stupid might be considered "bad" to
some people, but not all, so you can't get thrown in jail for doing
that, even though some peple thing it's "harming others". For example,
saying "religion is stupid". In order to be thrown in jail you have to
do something _truly_ bad, something we all agree is harming others.

In online communities facts don't matter, if the majority thinks you are
doing something bad (even if you are not), you get thrown to jail (or
virtual jail).

> > It may be that distributed version control systems offer more
> > possibilities for organizing cooperation in a manner leaving graceful
> > escape paths when things don't work out.  It's not what one want to have
> > to rely on permanently but it may be worth thinking about ways to make
> > consequences from difficulties less "inevitable" and/or grave.
> 
> Sure, I believe my proposal of acting on bad behavior earlier would
> prevent incidents like this one, because it would defuse situations
> before they settle in. But that's just a proposal, I'm just an
> observer here.

What you label "bad behavior" started *because* of Junio's decision.

Junio made an important (to me) decision based on a *TECHNICAL* reason
he never explained. My "bad behavior" basically consisted in pointing
out Junio's bad behavior.

In this case I'm not very dissimilar to Edward Snowden. Snowden did
somethig "bad" in the eyes of many people, but he did it *because* of
something deeper and more important. It was the government that caused
Snowden's actions, and it is the government's bad behavior that is
important. But if you look at the mass media, they don't concentrate on
the government's actions (that's risky), they concentrate on Snowden.

This might have changed after Snowden gained support, but at least
initially it was this way.

You are doing exactly the same as the mass media. Instead of looking at
the actions of Junio, namely his *TECHNICAL* decision which *triggered*
my "bad behavior", you look at me, the easy target, and ignore the real
problem.

Wait, wait! Before focusing on deciding whether leaking documents is
"bad", and how exactly it was carried out, why don't you concentrate on
the real issue; the fact that the government is spying on everyone. Nah!
that's haaard. Let's obliterate the little guy.

-- 
Felipe Contreras
