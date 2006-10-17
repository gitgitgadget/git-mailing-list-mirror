From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 18:00:51 -0400
Message-ID: <20061017180051.5453ba90.seanlkml__46087.8169666559$1161336406$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 11:26:43 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gaqe7-0001X9-HZ
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 11:26:31 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapNK-0007lN-Tj; Fri, 20 Oct 2006 09:05:06 +0100
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]
	helo=BAYC1-PASMTP07.CEZ.ICE)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GZwzX-00084T-E8
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 23:00:55 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE
	over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); 
	Tue, 17 Oct 2006 15:06:39 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZw3Q-0007L3-5s; Tue, 17 Oct 2006 17:00:52 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061017180051.5453ba90.seanlkml@sympatico.ca>
In-Reply-To: <45354AD0.1020107@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 22:06:39.0671 (UTC)
	FILETIME=[8564E470:01C6F238]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29430>

On Tue, 17 Oct 2006 17:27:44 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

> Bzr has plugin autoloading, Protocol plugins, Repository format plugins,
> and more.  Because Python supports monkey-patching, a plugin can change
> absolutely anything.

But really why does any of that matter?  This is the open source world.
We don't need plugins to extend features, we just add the feature to
the source.  The example I asked about earlier is a case in point. 
Apparently in bzr "bisect" was implemented as a plugin, yet in Git it
was implemented as a command without any issue at all, no plugins
needed, and its compiled and runs at machine speed.

Sean
