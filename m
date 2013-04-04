From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 4 Apr 2013 15:34:40 -0600
Message-ID: <CAMP44s16NcTBLWuUR9bb6KaspJYYcfsWVyF9NVO4gxP-gXr4WA@mail.gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
	<1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
	<87y5cyqhya.fsf@59A2.org>
	<CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com>
	<87ppyaqcie.fsf@59A2.org>
	<CAMP44s16Yt0mL8FKXMVgLBXw7s9_S8hGyS0YNHX7GrsAXYNDfg@mail.gmail.com>
	<87li8yqayf.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Jed Brown <jed@59a2.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:35:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNroM-00027K-Uv
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764931Ab3DDVem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 17:34:42 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:64973 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764926Ab3DDVel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 17:34:41 -0400
Received: by mail-la0-f49.google.com with SMTP id fs13so2922820lab.36
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SfkVlIC1KPI94v6j1DwiUjePXF5+C03Bq+t0AIb/Kb4=;
        b=rprtu1ITHm1WnbS0YBoEjBE0txkTuXHO3wx4FyB6OKFpHzE22YftUAPlrve+89Iwdc
         SWkjnneC5Ghv+tFQjTQnP8wE7FY7fB4tQD6KFPoJ3h7roaTOYTRWcGwrBG6qePYDyqtm
         dlLAOIruFyQP1hjoI5PYEVKUAiYWQDSNbjDE3avjqk5iuGzMh4Gb0KLe+Po7yyThnyJ5
         krPUdd/yYu66Z0siq9LCFKIYAm5iaEdbp3Xdkqo2ek5uk5Q/AEHcSKCCOSLESOcRZDhC
         +PTwNLiTNB857up2ynQLGdFoNwu6+rHUZyHdwltoUQvjMKLF12BfUULqbK34RuD7E1pN
         9XtQ==
X-Received: by 10.152.128.98 with SMTP id nn2mr4465799lab.17.1365111280288;
 Thu, 04 Apr 2013 14:34:40 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Thu, 4 Apr 2013 14:34:40 -0700 (PDT)
In-Reply-To: <87li8yqayf.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220110>

On Thu, Apr 4, 2013 at 2:48 PM, Jed Brown <jed@59a2.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>
> [...]
>
>>> will need to play by those rules.
>>
>> No, we don't. The fact that you say so doesn't make it so.
>
> Then perhaps we have different goals [1].  I don't know any Git User that
> would prefer to have an Hg upstream accessed through remote-hg.

Who cares? If you don't know somebody, does that mean such person doesn't exist?

> We have
> to assume that every Git (remote-hg) User is dealing with Hg Team

No, we don't.

> that
> is setting the rules, since otherwise Git User would just change the
> whole damn project to Git and be done with it.  In that sense, it is
> inappropriate to do things that are likely to make Hg Team yell at Git
> User.

If you are always going to do Mercurial workflows, then what's the
point of using Git?

>> I create a branch felipec-bookmarks, and I push as many heads as I
>> wish. Who will get affected? Nobody.
>
> Every Hg user will see those heads by default every time they run 'hg
> log' or 'hg heads'.

Wow, catastrophic. BTW. Any commit pushed will show in 'hg log' either
way. And who will run 'hg heads' if, according to you, the project has
stated that new heads should not be pushed? If no new heads are
pushed, 'hg heads' will never show anything interesting.

Is that the *HUGE* problem? Too many heads will show in the arcane 'hg heads'?

>> And who says we are committing upstream?
>
> The discussion is moot if you don't want to push your commits upstream.

There are so many workflows and use cases you are completely ignoring.

Anyway, I'm not going to discuss with you any more, a configuration
option would work perfectly, and curiously you didn't comment on that.
It's quite clear that you are arguing for the sake of arguing, or at
least not looking for a solution.

Bye.

-- 
Felipe Contreras
