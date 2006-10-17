From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 08:07:02 -0400
Message-ID: <20061017080702.615a3b2f.seanlkml__27953.817000571$1161408618$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<200610171345.32313.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 07:30:15 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb9Qy-0006n4-Ap
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 07:30:12 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapMp-0007i3-01; Fri, 20 Oct 2006 09:04:36 +0100
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GZnir-0007Gg-I6
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 13:07:06 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by
	BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Tue, 17 Oct 2006 05:07:04 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZmmk-0005Yn-MB; Tue, 17 Oct 2006 07:07:02 -0400
To: Jakub Narebski <jnareb@gmail.com>
Message-Id: <20061017080702.615a3b2f.seanlkml@sympatico.ca>
In-Reply-To: <200610171345.32313.jnareb@gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 12:07:04.0288 (UTC)
	FILETIME=[C2651600:01C6F1E4]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29582>

On Tue, 17 Oct 2006 13:45:31 +0200
Jakub Narebski <jnareb@gmail.com> wrote:

> Git cannot do that remotely (with exception of git-tar-tree/git-archive 
> which has --remote option), yet. But you can get contents of a file 
> (with "git cat-file -p [<revision>:|:<stage>:]<filename>"), list 
> directory (with "git ls-tree <tree-ish>") and compare files or 
> directories (git diff family of commands) without need for working 
> directory.

Interesting, I didn't know about the --remote option.  So in fact as long
as the remote has enabled upload-tar then anyone can do a "light checkout".
However, it appears that kernel.org for instance doesn't enable this feature.

Sean
  
