From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 10:27:05 +0200
Organization: At home
Message-ID: <ehclkf$v3e$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<200610171345.32313.jnareb@gmail.com>
	<20061017080702.615a3b2f.seanlkml__27953.817000571$1161408618$gmane$org@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 10:28:29 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbCDU-0001yr-2k
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 10:28:28 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbCDF-00081n-2M; Sat, 21 Oct 2006 09:28:13 +0100
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1GbCC9-0007xp-FB
	for bazaar-ng@lists.canonical.com; Sat, 21 Oct 2006 09:27:05 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GbCC8-0001qP-3K
	for bazaar-ng@lists.canonical.com; Sat, 21 Oct 2006 10:27:04 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Sat, 21 Oct 2006 10:27:04 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Sat, 21 Oct 2006 10:27:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bazaar-ng@lists.canonical.com
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29590>

Sean wrote:

> On Tue, 17 Oct 2006 13:45:31 +0200
> Jakub Narebski <jnareb@gmail.com> wrote:
> 
>> Git cannot do that remotely (with exception of git-tar-tree/git-archive 
>> which has --remote option), yet. But you can get contents of a file 
>> (with "git cat-file -p [<revision>:|:<stage>:]<filename>"), list 
>> directory (with "git ls-tree <tree-ish>") and compare files or 
>> directories (git diff family of commands) without need for working 
>> directory.
> 
> Interesting, I didn't know about the --remote option.  So in fact as long
> as the remote has enabled upload-tar then anyone can do a "light
> checkout". 

Not exactly. "Light checkout" (aka "lazy one-branch clone") in bzr
contains also info about the repository it came from, and has some
metadata that you can commit to it locally. git tar-tree --remote
just gets snapshot. 

> However, it appears that kernel.org for instance doesn't enable this
> feature. 

One can get snapshot from gitweb... if gitweb is new enough and
has this feature enabled (it is enabled by default). Again not
the case of kernel.org
