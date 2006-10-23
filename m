From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 21:12:26 +0200
Message-ID: <200610232112.27066.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610231134450.3962@g5.osdl.org>
	<1161629801.27312.22.camel@charis.lan.vernstok.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: James Henstridge <james@jamesh.id.au>, bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Mon Oct 23 21:13:45 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc5Dz-0004I2-8S
	for gcvbg-bazaar-ng@m.gmane.org; Mon, 23 Oct 2006 21:12:39 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gc5Dh-0006DK-9C; Mon, 23 Oct 2006 20:12:21 +0100
Received: from ug-out-1314.google.com ([66.249.92.174])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1Gc5DW-0006DD-So
	for bazaar-ng@lists.canonical.com; Mon, 23 Oct 2006 20:12:11 +0100
Received: by ug-out-1314.google.com with SMTP id 22so1143960uga
	for <bazaar-ng@lists.canonical.com>;
	Mon, 23 Oct 2006 12:12:10 -0700 (PDT)
Received: by 10.67.89.5 with SMTP id r5mr7874176ugl;
	Mon, 23 Oct 2006 12:12:10 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
	by mx.google.com with ESMTP id 53sm276674ugn.2006.10.23.12.12.09;
	Mon, 23 Oct 2006 12:12:09 -0700 (PDT)
To: Jelmer Vernooij <jelmer@samba.org>
User-Agent: KMail/1.9.3
In-Reply-To: <1161629801.27312.22.camel@charis.lan.vernstok.nl>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29864>

Jelmer Vernooij wrote:

> There are no requirements on what a revid is in bzr. It's a unique
> identifier, nothing more. It can be whatever you like, as long as it's
> unique for that specific commit. The committer+date+random_number is
> just what bzr uses at the moment to create those unique identifiers.

In unpacked git repository commit-id is also commit address. Pack files
adds another level of indirection via pack index file. And functions
as checksum.

P.S. I'm interested what are bzr equivalents of git different types
of objects: commits (revision info) and what is stored in there besides
commit message and "snapshot"; trees/manifest i.e. how files are 
gathered together to form given revision; blob i.e. what is the storage 
format and how it is divided: changeset-like of Arch or file "buckets" 
of Mercurial and CVS, or something yet different together. Is there 
equivalent of git tags and tags objects?
