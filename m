From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 10:01:50 -0400
Message-ID: <20061017100150.b4919aac.seanlkml__6612.46223976395$1161404460$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE>
	<vpqbqob5euu.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP10E107E5EB0F7E69167F41AE0E0@CEZ.ICE>
	<vpqejt73vln.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 06:20:56 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb8Lt-0005CS-3m
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 06:20:53 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapNF-0007l0-BU; Fri, 20 Oct 2006 09:05:01 +0100
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GZpVx-0006wI-J9
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 15:01:53 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by
	BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Tue, 17 Oct 2006 07:05:30 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZoZq-0005sm-RT; Tue, 17 Oct 2006 09:01:50 -0400
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Message-Id: <20061017100150.b4919aac.seanlkml@sympatico.ca>
In-Reply-To: <vpqejt73vln.fsf@ecrins.imag.fr>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 14:05:31.0218 (UTC)
	FILETIME=[4E748B20:01C6F1F5]
X-Mailman-Approved-At: Fri, 20 Oct 2006 09:04:04 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29579>

On Tue, 17 Oct 2006 15:44:36 +0200
Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

> > How does bzr avoid a merge when you're pushing changes from 3
> > separate machines?
> 
> Err, the same way people have been doing for years ;-). If you don't
> have local commits, "bzr update" will work in the same way as "cvs
> update", it keeps your local changes, without recording history. Like
> "git pull" does if you have uncommited changes I think.

Ah, okay.  Well Git can definitely manage this.  Just means you have to
rebase any local changes before pushing.  This will keep the history
linear and make sure that no merges are needed in the case you were asking
about.

So far, it sounds to me like bazaar and git are more alike than they are
different.  Each have a few commands the other doesn't but all in all
they sound very similar.  But i'm a Git fanboy so I aint switching
now ;o)

Sean
