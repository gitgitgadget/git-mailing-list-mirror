From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 12:27:11 +0200
Message-ID: <87txlj30n4.fsf@linux-k42r.v.cablecom.net>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
	<CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
	<87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
	<87y5av4jvj.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 31 12:27:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiMYJ-0007iG-TH
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 12:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab3EaK1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 06:27:16 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:11516 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab3EaK1O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 06:27:14 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 31 May
 2013 12:27:09 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 31 May 2013 12:27:11 +0200
In-Reply-To: <87y5av4jvj.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Fri, 31 May 2013 10:46:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226087>

Thomas Rast <trast@inf.ethz.ch> writes:

> However, if that turns out to be the culprit, it's not fixable
> currently[1].  Having commits with insanely long messages is just, well,
> insane.
>
> [1]  unless we do a major rework of the loading infrastructure, so that
> we can teach it to load only the beginning of a commit as long as we are
> only interested in parents and such

Actually, Peff, doesn't your commit parent/tree pointer caching give us
this for free?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
