From: Max Horn <max@quendi.de>
Subject: Re: Anybody know a website with up-to-date git documentation?
Date: Wed, 30 Jan 2013 18:05:53 +0100
Message-ID: <6BE76AE4-254E-43DD-A3FF-88B5486029A5@quendi.de>
References: <D6EAC791-63E2-4B0E-92AA-676112039BD9@quendi.de> <20130130115439.GH1342@serenity.lan> <71A3AA8C-DBA2-44F7-9B69-AEDB81BB0906@quendi.de> <CAMK1S_i+ML+HuTRuox5rU4bsV0+xoFLWpK63WrdXuzhgyHJbrA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 18:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0b7A-0006LI-EN
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab3A3RF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:05:56 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:46892 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352Ab3A3RFz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:05:55 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1U0b6f-0003bL-RH; Wed, 30 Jan 2013 18:05:53 +0100
In-Reply-To: <CAMK1S_i+ML+HuTRuox5rU4bsV0+xoFLWpK63WrdXuzhgyHJbrA@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1359565555;32356ccf;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215032>


On 30.01.2013, at 16:59, Sitaram Chamarty wrote:

> I'm curious... what's wrong with 'git checkout html' from the git repo
> and just browsing them using a web browser?

Hm, do you mean "make html", perhaps? At least I couldn't figure out what "git checkout html" should do, but out of curiosity gave it a try and got an error...

But supposing that you meant "make html": There is nothing "wrong" with it. This is mostly a matter of convenience:

* Many people just use git and don't have the git.git repos (or any git sources) at hand.  And while for many things, older versions of the reference pages may suffice, this is not always the case.

* When I want to point somebody at something specific in the git docs while, say, while discussing on IRC or a mailing list, it is very convenient to point them at a website, like this:
   http://git-htmldocs.googlecode.com/git/git-fast-import.html#_code_notemodify_code 

* Similarly if I am standing physically next to somebody sitting at their computer and they ask me something about git, it is nice to be able to send them to a current version of the docs online

* I can access the web version from my tablet -- and I actually do that (use my tablet as "secondary screen" showing some git refs and other docs while coding on my laptop).

* a website can be update by one person (or ideally: one script) and serve many people with the same need Seems more efficient than each of those people setting up an appropriate clone & a cron job to keep it up-to-date on each machine where they need it.


But of course, the "make html" has its own clear advantages, e.g. I can use it online, I have full control over which exact version of the docs I get, including most recent changes, etc. To me, the two complement each other.


Anyway, I'll stop spamming the list, I got my answers from John and Junio:

  http://git-htmldocs.googlecode.com/git/git.html

and in addition 

  http://manned.org/git.1


Thanks again,
Max