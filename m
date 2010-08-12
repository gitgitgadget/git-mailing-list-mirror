From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Proposal for new Git Wiki admin
Date: Thu, 12 Aug 2010 16:56:47 +0200
Message-ID: <20100812165647.38ee2809@jk.gs>
References: <20100810162602.GG3921@kytes>
	<m3y6ce2kdz.fsf@localhost.localdomain>
	<20100811050056.GA3715@kytes>
	<4C62494A.2030805@drmicha.warpmail.net>
	<AANLkTimuHzC_brw2bBDTvc=-Cj+70AMFEj7nzspW5mGq@mail.gmail.com>
	<20100811134640.GA10888@kytes>
	<AANLkTimQsNj-3M=y7Dop4brB8U-8vVPqgD0+zBX5R6FG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 17:12:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjZS6-00061c-Ie
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 17:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab0HLPMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 11:12:12 -0400
Received: from zoidberg.org ([88.198.6.61]:59952 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab0HLPML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 11:12:11 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Aug 2010 11:12:11 EDT
Received: from jk.gs (p508A2C60.dip.t-dialin.net [::ffff:80.138.44.96])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 12 Aug 2010 17:07:04 +0200
  id 00400232.4C640E18.00002AD0
In-Reply-To: <AANLkTimQsNj-3M=y7Dop4brB8U-8vVPqgD0+zBX5R6FG@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153379>

Felipe Contreras <felipe.contreras@gmail.com> wrote:

> IMO having more than one admin is only part o the solution, see:
> https://git.wiki.kernel.org/index.php/WikiIdeas

Here are my comments on that. For the sake of archive-friendliness, I'm
referring to this version of it:
https://git.wiki.kernel.org/index.php?title=WikiIdeas&oldid=8996

(Why am I commenting here instead of on the wiki? Because I think there
are few things worse than a wiki for discussing something.)

| Currently there's only one admin (Johannes Schindelin), it would be
| healthy to have more than one.

I agree. Few sites work with one admin; not least because most sites
are too much work for one single person to handle.

| Up to now, good faithed users have been blocked immediately, and
| permanently, without a warning. Instead of doing that, a policy like
| wikipedia's one should be followed:

I'd like to point out that this drastically increases the
administration effort. For example, issued warnings have to be tracked.
Also, this is serious overhead for obvious spammers, and different
people will have different perspectives on what constitutes an obvious
spammer. To the best of anyone's knowledge, only one false positive has
ever occurred until now. I think this approach is overkill. I would
suggest, if technically possible, automatically showing banned users a
notice that asks them to contact admins via some channel or another if
they believe that they have been wrongly blocked.

| Some people might have been wrongly blocked. By changing the blocking
| policy the old blocks might not apply and warnings should be issued instead.

Same reasoning. Also, the deletion logs look very much like only
obvious spammers got blocked.

| Allow users to see deleted pages
| This would allow transparency into the action of the admins.

I don't oppose that, but it raises technical issues. Deleted pages
should not be indexed by search engines, because doing so would defeat
the purpose of removing spammy links. I don't know whether MediaWiki
implements that; I do know that it tells robots not to index old
versions of pages.

| Up to now, good faithed users have been blocked immediately, and
| permanently, without a warning. Instead of doing that, a policy like
| wikipedia's one should be followed:

Yes, but why use a wiki for communication if you can simply use e-mail
instead? To me, all this "using wiki pages for communication and
discussions" is a classic case of "when you have a hammer"...

Also, the proposal about patrol groups seems to be about solving the
same problem, though I don't know how well it works for dealing with
problematic edits in real time. Okay, I guess we'd need a *lot* more
admins for that anyway.


All in all, I think it would be completely sufficient to find a way to
let users help with reporting spam, and to add a couple of admins...
and perhaps notify users when blocking them. I don't think anything
else is necessary or useful.

> > [...] Personally, I don't think
> > you should work with Johannes, atleast in the state in which you're
> > in right now. Please disagree only if you feel that Jakub or I will
> > do a bad job.
> 
> It's not Johannes' wiki; it's the community's. And I'm certain that I
> can work just fine with Jakub as I've done it in the past.

Nobody claimed that you wouldn't be able to work with Jakub, there was
only doubt that you might have difficulty working with Johannes (in a
way that leaves both of you in a healthy state of mind).

Also, for the record, I'm fine with Jakub and Ram doing the job. I
would volunteer myself for additional help but I don't really care
about it very strongly, and three people are probably enough for now
anyway.

(As a public service, I have cut away the rest of what I was going to
write. The discussion is long enough as it is already.)

-Jan
