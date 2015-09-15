From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: RE: Git Deployment using existing multiple environments
Date: Tue, 15 Sep 2015 09:48:34 +0200
Organization: gmx
Message-ID: <8f9806ed1145d5873aadf6d28d44ad64@dscho.org>
References: <BAY180-W16B5F49FFD3614D666B232C25F0@phx.gbl>
 <8797177dd247d4ef903603cbe6c57d7d@dscho.org>,<BAY180-W55A5095CC7E1322EA80876C25D0@phx.gbl>,<CA+P7+xq0ZPOAOONA9x9x_CYt1yf5J4Qcr5oQdQsbtu3iH3ehmw@mail.gmail.com>
 <BAY180-W38D1FC3FD9892A6D147968C25C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Sukhwinder Singh <php_programmer_india@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 09:48:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbkyn-0006ak-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 09:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbIOHsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 03:48:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:58823 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbbIOHsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 03:48:36 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MZ8fw-1ZLAy6445c-00L1YP; Tue, 15 Sep 2015 09:48:35
 +0200
In-Reply-To: <BAY180-W38D1FC3FD9892A6D147968C25C0@phx.gbl>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:4jLyARAbs3de3sY9ZJVIhKn2exyqMRboDUUD7Qv8Lu3ZMMLXHLa
 i7sJzDSJlXB6RtiVTybzZtdyIVlItg6O+l8zxu+RmSwJXkZ8BV+CtB2qPJylNS8j6VcPIDE
 mT3eka9MlDWaA6UthgBbQ3wbMG0rhGQpHpY9Q3bYOvu5AdKpDE5gsCNfTubVOYKrJDXehgb
 +NRQg92aoFlfZbA75byxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RuP12c+eu/k=:cJ3ydaMOWVaBcBu9ry/2hE
 lEul0uZGXk9fAe3ajHZ9srV1wV4NYNmQmTt/lxAlRcYerqUiVbPBzeP0RRUtZIiMnUDMXIRPO
 cfpL06YsTvuBggbi92BvZU3sT0FLJPr15E674eN3Zj6V2uBAbBgsR3Jmta725tU9XTQHQLoeG
 A4EzKcjpFozPsKg8uf0tyWEnq+q5dRzAghGuLnMT9TNKWLoN4qa15XuMJS5ZYItuifVqrsjZq
 Y6DgcqhwZZxckx8oD+/G0qP4rkWUCynLd7zBe+AHIJg5pywLYzJ4sBSBwtMlxnKW/ObpCnlLa
 cbBtHXF120kymTgZkHXAGumDg87nCo3iWeCm+jmSOvlZk3ZlkFV44x4y2sJ0wCCZb254GCPf/
 q3+QfCYthoBlgPs6ZTQ0JdOMNkYe8It7pzaxCwzS3Gq9WC7vFGZOKRYGnekgKSrmNUGTXahAE
 UjTy8FOFTdurY0Pv+yBpIj3/o83R3peFKehJHzeuR0Of6dFr3dRBaw8TTqgEdyaMLK4Y+hka8
 BoZItmktNZGI9s9Q+8zSqXaZRdhXo+JyBkP4bH6umhWZHzKl0MXlE0n2Q5i5gg7NDUdidHpTd
 xmCUus6gMmIcAta46DEqRvsQGa33pwPjEgW18lfgaL7B8goSv0dEcV+I86EnIkDBTHvIbqd0I
 aQOiikNFIDvcTqfaOGtzK9ES4T8pHYQ32iG4dryfANWYVZuzrwIFaQyuTNBJtV9scOc11mcBP
 z/tkWzSKTylSS7nOk7aFkf9deLTcVUsrmKsVvg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277894>

Hi,

please stop top-posting. It is quite irritating by now. Thank you.

On 2015-09-15 08:50, Sukhwinder Singh wrote:

> Now lets say we set up a repository at github which has the latest
> code (all test code)., Now at each of our own servers we already have
> existing code, that is Test, UAT and Live. For example, first he'll
> pull code from github to our Test Server and then move branches to UAT
> and then to Live. Can it work?

Yes, it can work.

The major problem here will be that you have only a single, central repository that every developer has write access to, but you expect only a single trusted person to deploy that code via three different stages. That can be tricky, in particular if your trusted person is a newbie.

> If it can work then can I please get some some example commands or the procedure to set it up?

Sorry, this feels a bit too much like "could you please do all my work for me?" to me. And if I really provide exact commands here, I may even be liable when it does not work out in the end? I am not going to do that.

Instead, I will strongly suggest to learn enough about Git to answer those quite simple questions ("How do I pull?", "What is a pull?", "How do I update a test machine's working directory with the newest branch tip?") yourself. I usually recommend https://try.github.io/

> Time is a bit of problem right now or I would have read book suggested by Johannes. I have searched on the internet but couldn't find any similar case.

If I was in your shoes, I would spend the time *now*, rather than quite possibly spending 10x as much time later when I have to clean up a mess. In my experience, 
what looks like the cheap route (copying commands without understanding them, really), invariably turns out to be the most expensive route possible.

In any case, this was as much useful feedback as I had to give to your questions.

Ciao,
Johannes
