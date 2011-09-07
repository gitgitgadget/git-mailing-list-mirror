From: Kyle Neath <kneath@gmail.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Wed, 7 Sep 2011 13:14:01 -0700
Message-ID: <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <4E6769E3.4070003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 22:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1OVx-0006Yz-1w
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 22:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab1IGUOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 16:14:23 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50191 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab1IGUOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 16:14:22 -0400
Received: by wwf5 with SMTP id 5so36051wwf.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+GGSf4WDHm9hOb3GzA1IyMov3yRDSRkJ1pvPcU2rGbU=;
        b=CsTxqTtZqENNLPvYQbR7PuuScwtEQ/WnpAv9T1DEZUbNTzcga6/irNfdrfrVl815Yr
         TV4IUvZEFx7i14X2NePYR19GfEHTqNLROX8R1K3+XpW1mk3AfqMwePwCkcnkgk3N6+AL
         6X66ScuxE3dSuKyQa3+Nd60JrfowzLwcfMKC8=
Received: by 10.227.152.132 with SMTP id g4mr2630569wbw.41.1315426461144; Wed,
 07 Sep 2011 13:14:21 -0700 (PDT)
Received: by 10.227.54.208 with HTTP; Wed, 7 Sep 2011 13:14:01 -0700 (PDT)
In-Reply-To: <4E6769E3.4070003@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180903>

Junio C Hamano <gitster@pobox.com> wrote:
> If this were a new, insignificant, and obscure feature in a piece of
> software with mere 20k users, it may be OK to release a new version with
> the feature in an uncooked shape.

For the sake of my paycheck, I should certainly hope not! I'm not at all
suggesting we merge what we have in. However, I do think this feature is
important enough to delay the release. I trust in the judgement of the core
members to know when something is ready for inclusion in master.

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> So, it's been a year or more that you've been aware of the importance of
> this issue (from your/github's perspective), and we hear about it now,
> at the end of the rc phase.

I apologize if it sounds like that. I've been discussing this situation with
many people (including Jeff King) for a very long time now, and it was my
understanding that the credential caching was done and simply waiting for a
new release. This is the first I've heard that it will not be included in
1.7.7, so I'm voicing my opinion now. Admittedly, late in the game - and I
apologize for that.

I'd be happy to help in any capacity I can. Unfortunately I'm no C hacker, and
I've accepted that as a character flaw (it's something I'm working on). I'm
afraid I can't be of much help with the actual code. What I can provide is an
alternate viewpoint to the core team. A viewpoint of someone who's spent 3
years trying to make git easier for newcomers.

I urge the core team to think about what kind of opportunity we have here.
Credential caching isn't some minor feature. It's the last piece of the puzzle
that promotes Smart HTTP to a viable alternative over the git & ssh protocols.
Smart HTTP solves an huge collection of problems people have with using git
day to day. One URL to push privately and pull anonymously. No firewall
restrictions at universities or workplaces. Username & password
authentication. I get kind of turned on just thinking about it.

Kyle
