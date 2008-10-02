From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Git commit hash clash prevention
Date: Thu, 02 Oct 2008 13:08:48 +0200
Message-ID: <48E4ABC0.80100@gmx.ch>
References: <20081002085358.GA5342@lapse.rw.madduck.net> <200810021118.15313.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Thomas Rast <trast@student.ethz.ch>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 13:10:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlM4O-00067P-IX
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 13:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbYJBLI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 07:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbYJBLI5
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 07:08:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:40286 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751643AbYJBLI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 07:08:56 -0400
Received: (qmail invoked by alias); 02 Oct 2008 11:08:54 -0000
Received: from 243-17.79-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.79.17.243]
  by mail.gmx.net (mp041) with SMTP; 02 Oct 2008 13:08:54 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1+FHnFt3QKF/grIysTY0KTaKo1hRbuIZAyc0NMxlM
	p5549M2cYl28/9
User-Agent: Thunderbird 2.0.0.17 (X11/20080928)
In-Reply-To: <200810021118.15313.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97314>

Hello list!

Thomas Rast wrote:
>   However, the expected number of objects needed to get a collision is
>   on the order of 2**80 (http://en.wikipedia.org/wiki/Birthday_attack),
>   and since there are (very roughly) 2**25 seconds in a year and 2**34
>   years in the age of the universe, that still leaves you with 2**21
>   ages of the universe to go.

In case it's interesting to someone, I once calculated (and wrote
down) the math for the following scenario:

  - 10 billion humans are programming
  - They *each* produce 5000 git objects every day
  - They all push to the same huge repository
  - They keep this up for 50 years

With those highly exagerated assumptions, the probability of
getting a hash collision in that huge git object database is
6e-13.  Provided I got the math right.

So, mathematically speaking you have to say "yes, it *is*
possible".  But math aside it's perfectly correct to say "no, it
won't happen, ever".  (Speaking about the *accidental* case.)

jlh
