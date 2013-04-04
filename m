From: Jed Brown <jed@59a2.org>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 04 Apr 2013 17:27:03 -0500
Message-ID: <87eheqq6dk.fsf@59A2.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com> <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com> <87y5cyqhya.fsf@59A2.org> <CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com> <87ppyaqcie.fsf@59A2.org> <CAMP44s16Yt0mL8FKXMVgLBXw7s9_S8hGyS0YNHX7GrsAXYNDfg@mail.gmail.com> <87li8yqayf.fsf@59A2.org> <CAMP44s16NcTBLWuUR9bb6KaspJYYcfsWVyF9NVO4gxP-gXr4WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 00:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNsd8-0003oO-7m
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 00:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765262Ab3DDW1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 18:27:08 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36563 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765237Ab3DDW1H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 18:27:07 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so3388737oag.5
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=FByeZ3+9WfDUMCe5ZsQcNDK9S592ZQzxLgy0rhdBxnU=;
        b=z0oMVQGh5D6HCFJdxSdU6zcWaeIQGDZLQY6V/D1utopxt8soW5YZ4WpDfGsvcTpzhi
         6LOAI9dCEcicgoeW+WxeBSpr24JthpxpnMhFzMcRAIESq2ky1yMf45jLQPv5czPNe2Cz
         LW2kBfvfclbBICWv/ReHmopocdTDT9EwNqSNGpnOz9qJ/b7rDjjM8K1tcNKFh18p9w/2
         uHowGNT0Q9Igh/xhDP6pk7P7sx+Fl6/XC0lVNfht6R3Ys9pNh9D/QxLlWqZKhMP+iADD
         MsRUdE23QgZnGMmpChx4n73Cu6XUN//U6jX+i0x4v1Co3g0XgVZrL3+9caaKPVYtNG74
         j0Wg==
X-Received: by 10.60.42.8 with SMTP id j8mr6247761oel.43.1365114425867;
        Thu, 04 Apr 2013 15:27:05 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id d10sm9057141obk.1.2013.04.04.15.27.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 15:27:05 -0700 (PDT)
In-Reply-To: <CAMP44s16NcTBLWuUR9bb6KaspJYYcfsWVyF9NVO4gxP-gXr4WA@mail.gmail.com>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220118>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 4, 2013 at 2:48 PM, Jed Brown <jed@59a2.org> wrote:
>>
>> Then perhaps we have different goals [1].  I don't know any Git User that
>> would prefer to have an Hg upstream accessed through remote-hg.
>
> Who cares? If you don't know somebody, does that mean such person
> doesn't exist?

Maybe I wasn't explicit enough:

    I don't know any Git User that would prefer to have an Hg upstream
    accessed through remote-hg *than to have a Git upstream accessed
    through native Git.*

>> We have
>> to assume that every Git (remote-hg) User is dealing with Hg Team
>
> No, we don't.

Really?  If there is no Hg Team, why bother with an Hg upstream?

> If you are always going to do Mercurial workflows, then what's the
> point of using Git?

Using Git workflow locally while being able to interact with the Hg Team
via whatever conventions they have established.  Sane branching, merge
strategies, rerere, and a host of other Git features are plenty useful,
even when contained within your personal repo.

> Wow, catastrophic. BTW. Any commit pushed will show in 'hg log' either
> way. And who will run 'hg heads' if, according to you, the project has
> stated that new heads should not be pushed? If no new heads are
> pushed, 'hg heads' will never show anything interesting.
>
> Is that the *HUGE* problem? Too many heads will show in the arcane 'hg
> heads'?

Hg displays warnings about multiple heads, suggests that you merge them
any time they are anonymous, and doesn't have remote namespaces so that
names can collide.  Remember that the most common reason people give for
using Hg in the first place is that it's "simpler" (yeah, I don't agree
either, but that's their story).  So don the hat of a Git (remote-hg)
User: You're interacting with people that don't understand version
control very well and only know the basic Hg command set.  Do you really
think it's okay to silently put them in a state where Hg will print
confusing messages about multiple heads, disrupt their workflow ('hg
log'), and suggest that they do things that are likely to be disruptive
(like merge those heads)?

I've spent the last five years as an active contributor to an Hg-based
project and throughout that time, newer contributors would constantly
get flustered over things like this and I would get the emails asking
what happened and how to fix it.  Over that five year period, several
other Hg projects that I was involved in switched to Git.  My statements
about what is likely to be acceptable to an Hg upstream is based on my
experience with these projects and with a couple remaining Hg holdouts
(scientific applications that I support through libraries).  In none of
those projects would a force push have been acceptable.

>>> And who says we are committing upstream?
>>
>> The discussion is moot if you don't want to push your commits upstream.
>
> There are so many workflows and use cases you are completely ignoring.

Examples?  I'm just summarizing the workflows that I encounter and that
other contributors to gitifyhg encounter.  You have said yourself that
you don't actually use remote-hg [1], so why are you so confident that
you know what workflows are desirable to remote-hg users?

> Anyway, I'm not going to discuss with you any more, a configuration
> option would work perfectly, and curiously you didn't comment on that.

Sorry, defaults matter and project philosophy matters.  The fact that we
are arguing about such basic things has convinced me that I can't
recommend remote-hg because I have no confidence that the behavior will
be remotely acceptable to a Git user working with an Hg Team.



My primary project switched to Git three weeks ago and there is already
less confusion, despite having adopted a master/next/topic branch
workflow that only two of us were familiar with prior to the switch.
For this reason, I no longer have a vested interest in remote helpers so
I don't intend to debate this issue further.

But please try to make tools for actual users rather than hypothetical
users, or at least don't act so incredulous when people are less than
thrilled about using or contributing to your project.


[1] http://article.gmane.org/gmane.comp.version-control.git/219988
