From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
Date: Sun, 17 Oct 2010 14:33:33 +1100
Message-ID: <2A61B63C-B0E2-4CAC-8D36-5A238D152333@cordelta.com>
References: <AANLkTim6w54CPhw0GzaDxT9e0t19XQ7-rMEe5aSBevS+@mail.gmail.com> <26761091.515858.1287188219315.JavaMail.root@mail.hq.genarts.com> <AANLkTinbaBs=xWwRVU42h91ox-qXzuhDcgP-13wn+QSp@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Bash <bash@genarts.com>, Matt Stump <mstump@goatyak.com>,
	git@vger.kernel.org, Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 05:33:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7K0I-0007BH-RM
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 05:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab0JQDdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 23:33:40 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:31876
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751260Ab0JQDdk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Oct 2010 23:33:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAIcLukzLWHsF/2dsb2JhbAChIghxuTuIToVJBA
X-IronPort-AV: E=Sophos;i="4.57,342,1283695200"; 
   d="scan'208";a="261145943"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 17 Oct 2010 14:33:35 +1100
Received: (qmail 25218 invoked from network); 17 Oct 2010 14:33:35 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 17 Oct 2010 14:33:34 +1100
In-Reply-To: <AANLkTinbaBs=xWwRVU42h91ox-qXzuhDcgP-13wn+QSp@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159190>

Hi all,

>> That idea along with a bunch of others are now brewing a 2.0 in
>> my head since I started revisiting this proces.  We'll see if I have a
>> productive weekend or not...
> 
> Looking forward to seeing what you come up with :).

I don't know how much it will help, but I started work on a simplistic
mapping strategy with speed in mind. [1]

I am curious to read through the details of your heuristics and work
out how to streamline the process.

--
David Barr

[1] http://thread.gmane.org/gmane.comp.version-control.git/158375
