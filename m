From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 06:01:12 -0400
Message-ID: <20061017060112.2d036f96.seanlkml__10841.6940704503$1161331464$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	<200610170119.09066.jnareb@gmail.com>
	<1161077866.9020.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 10:04:22 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GapMV-0002TS-Sg
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 10:04:15 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapMO-0007VG-07; Fri, 20 Oct 2006 09:04:08 +0100
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]
	helo=BAYC1-PASMTP07.CEZ.ICE)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GZll5-0000v7-Td
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 11:01:18 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE
	over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); 
	Tue, 17 Oct 2006 03:06:59 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZkoz-0005Ft-2i; Tue, 17 Oct 2006 05:01:13 -0400
To: Robert Collins <robertc@robertcollins.net>
Message-Id: <20061017060112.2d036f96.seanlkml@sympatico.ca>
In-Reply-To: <1161077866.9020.69.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 10:06:59.0843 (UTC)
	FILETIME=[FC360530:01C6F1D3]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29414>

On Tue, 17 Oct 2006 19:37:45 +1000
Robert Collins <robertc@robertcollins.net> wrote:

> Precisely how does this rebase operate in git ? 
> Does it preserve revision ids for the existing work, or do they all
> change?
> 
> bzr has a graft plugin which walks one branch applying all its changes
> to another preserving the users metadata but changing the uuids for
> revisions. 

git rebase does exactly the same as you describe, including changing
the sha1 for each commit it moves.

Sean
