From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 09:49:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610190948540.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca>
	<200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
	<20061019161319.GA75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Thu Oct 19 18:50:44 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gab61-0003a5-Va
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 19 Oct 2006 18:50:18 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gab5s-0004IF-OC; Thu, 19 Oct 2006 17:50:08 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1Gab5f-0004HP-7t
	for bazaar-ng@lists.canonical.com; Thu, 19 Oct 2006 17:49:57 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9JGnlaX014730
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Oct 2006 09:49:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9JGnkYR016420;
	Thu, 19 Oct 2006 09:49:47 -0700
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061019161319.GA75501@over-yonder.net>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29371>



On Thu, 19 Oct 2006, Matthew D. Fuller wrote:

> On Thu, Oct 19, 2006 at 08:25:26AM -0700 I heard the voice of
> Linus Torvalds, and lo! it spake thus:
> > 
> > The biggest difference seems to be that in bzr, the final checksum
> > is 64-bit,
> 
> Actually, as best I know, it's not a checksum, just random bits (a
> quick glance at the code seems to agree with me).

Ahh. They may be that even in BK. I know BK had various 16-bit CRC 
checksums, but they were probably on the actual _file_ contents, not in 
the key itself.

		Linus
