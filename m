From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Testing JavaScript code in gitweb.
Date: Sun, 20 May 2012 10:50:52 +0100
Message-ID: <4FB8BE7C.8050306@pileofstuff.org>
References: <CAH-tXsDif9YOrkEcj7AdRfn6gvLx4mj4+SKCB4GzyW6QJpx=9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 11:51:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW2n1-00040y-Ao
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 11:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab2ETJu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 05:50:58 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:26242 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752684Ab2ETJu5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 05:50:57 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120520095054.JMJF10903.mtaout01-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Sun, 20 May 2012 10:50:54 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120520095054.RYQW23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sun, 20 May 2012 10:50:54 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <CAH-tXsDif9YOrkEcj7AdRfn6gvLx4mj4+SKCB4GzyW6QJpx=9A@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=ShIRDlIvKzsA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=PA96aEbZAAAA:8 a=srOc7P55AAAA:8 a=VtgRi3-oXtsXb9VYMxQA:9 a=qbO0XBW0n0NLDArBpvMA:7 a=QEXdDO2ut3YA:10 a=CfJtRmWnoNsA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198054>

On 19/05/12 22:44, jaseem abid wrote:
<snip - broadly sensible analysis of the testing options>
> 
> I would prefer BDD style Jasmine for testing. The argument against it
> was that It cant be run from terminal (node.js). That will add a new
> dependency and hence cant be done. And as Andrew mentioned earlier, I
> think its better to run JavaScript tests in a real browser itself,
> because that's where it ultimately needs to run. He also mentioned
> that TDD would be a nice way to go [7]. I guess BDD will be ok in the
> context.

I think it would be clearer if I said "TDD is worth developing an
opinion about".  Unit tests are very valuable, but the way you go about
writing them is fairly personal - some people find TDD just right, some
like BDD, some want to chase the next technique, and some of us just
muddle through.  If BDD works for you, great!  If you try it and don't
like it, think about the problems you had and what would be a more
productive approach for you.

One important thing we haven't discussed yet is measuring code coverage.
 I often fall into the trap of thinking very hard about some parts of my
code and not paying enough attention to others.  Then I write loads of
tests for the things I've been obsessing about and ignore the things
I've been ignoring.  Guess where the bugs appear :)

Measuring code coverage lets you avoid that trap by showing what's
covered by tests and what isn't.  I've never actually done test coverage
in Javascript, but JSCoverage[1] and JesCov[2] are worth a look.  I'd
particularly recommend having a look at the JSCoverage example for
jQuery - it seems like they don't regularly check coverage, as there are
several obvious gaps in their tests.

	- Andrew

[1] http://siliconforks.com/jscoverage/
[2] http://jescov.olabini.com/
[3]
http://siliconforks.com/jscoverage/instrumented-jquery/jscoverage.html?test/index.html
