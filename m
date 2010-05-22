From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Sat, 22 May 2010 13:01:58 +0200
Message-ID: <20100522110158.GA30035@efreet.light.src>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
 <201005171632.48253.trast@student.ethz.ch>
 <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>
 <201005171712.22763.trast@student.ethz.ch>
 <20100517175939.GA3575@efreet.light.src>
 <1274122619.4780.36.camel@dreddbeard>
 <4BF246ED.3040706@drmicha.warpmail.net>
 <4BF25F7C.10303@syntevo.com>
 <1274189611.1294.10.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Singer <thomas.singer@syntevo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 13:02:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFmT9-00075n-Mx
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 13:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab0EVLCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 07:02:08 -0400
Received: from cuda1.bluetone.cz ([212.158.128.5]:42770 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab0EVLCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 07:02:04 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by cuda1.bluetone.cz (Spam & Virus Firewall) with ESMTP
	id CF51816F3D8A; Sat, 22 May 2010 13:01:59 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by cuda1.bluetone.cz with ESMTP id lmaGkwGqEfI4NFSS; Sat, 22 May 2010 13:01:59 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.71)
	(envelope-from <bulb@ucw.cz>)
	id 1OFmSt-0005j8-3z; Sat, 22 May 2010 13:01:59 +0200
Content-Disposition: inline
In-Reply-To: <1274189611.1294.10.camel@wpalmer.simply-domain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147513>

On Tue, May 18, 2010 at 14:33:31 +0100, Will Palmer wrote:
> On Tue, 2010-05-18 at 11:35 +0200, Thomas Singer wrote:
> > ... and even worse, (s)he will most likely
> > not be able to find a solution by searching google for this error message.
> 
> Other software projects make this a non-issue by reporting an "error
> code" or something along those lines, along with the message. The code
> is easily indexed, so that the message can be located by support staff
> and, nowadays, google. I assume any internationalization effort would
> require a message code of some sort be generated internally (if only to
> look up which internationalized message to display), so doing something
> as simple as outputting the internally-used code (even if that is just a
> hash of the English version of the message) could solve this problem.

Gettext does not require any kind of internal ID. It uses the english string
as a key. It should (as already suggested) be easy to have
a reverse-translation tool on the web somewhere for deciphering session logs
from users with non-english locale.

Non-English-speaking users won't be able to find a solution to problem by
searching google most of the time anyway, though, because the prevalent
English resources won't be understandable for them. Usually, however, they
will have somebody on their team who does and will be able to help them out
if they get into deep trouble.

> Having error messages pasted into #git in 14 different languages could
> be annoying, but if those are 14 people who otherwise would not be using
> git at all, then I expect we're looking at the wrong problem, and
> internationalisation /should/ be a priority.
> 
> But what do I know? I speak English :)

It is important for cases when somebody wants to use git in their team, but
some of their colleagues don't speak English. One has to expect having to
help their colleagues occasionally in such cases, but than when you propose
using git in some team, you have to expect having to help your colleagues
in any case.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
