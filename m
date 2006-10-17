From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 06:35:49 -0400
Message-ID: <20061017063549.da130b5f.seanlkml__22659.4742890031$1161331475$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
	<Pine.LNX.4.63.0610171229160.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 10:04:31 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GapMW-0002TW-O8
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 10:04:16 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapMV-0007Wv-IX; Fri, 20 Oct 2006 09:04:15 +0100
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]
	helo=BAYC1-PASMTP11.CEZ.ICE)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GZmIa-000282-DP
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 11:35:52 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE
	over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); 
	Tue, 17 Oct 2006 03:44:34 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZlMT-0005MC-Hv; Tue, 17 Oct 2006 05:35:49 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20061017063549.da130b5f.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0610171229160.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 10:44:34.0312 (UTC)
	FILETIME=[3BFAB080:01C6F1D9]
X-Mailman-Approved-At: Fri, 20 Oct 2006 09:04:03 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29417>

On Tue, 17 Oct 2006 12:30:27 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> It would also make things slow as hell. How do you deal with something 
> like annotate in such a setup?

Some commands like annotate might not make any sense in such a set up.

But one way to get the same (perhaps even better) feature into git 
would be to support shallow clones, in which case even annotate would
continue to work even if somewhat crippled by the lack of a complete
history.

Sean
