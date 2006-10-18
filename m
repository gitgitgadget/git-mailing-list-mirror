From: Charles Duffy <cduffy@spamcop.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 16:04:52 -0500
Message-ID: <eh64tk$rug$2@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<45349162.90001@op5.se>	<453536AE.6060601@utoronto.ca>	<200610172301.27101.jnareb@gmail.com>	<45354AD0.1020107@utoronto.ca>	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>	<45355CBB.80108@utoronto.ca>
	<BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 23:10:40 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaIgD-0004c0-8x
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 23:10:25 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GaIfw-000327-V7; Wed, 18 Oct 2006 22:10:09 +0100
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1GaIfs-00031H-Cv
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 22:10:05 +0100
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GaIfq-0004Wf-5q
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 23:10:02 +0200
Received: from 64.128.31.220 ([64.128.31.220])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Wed, 18 Oct 2006 23:10:02 +0200
Received: from cduffy by 64.128.31.220 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Wed, 18 Oct 2006 23:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bazaar-ng@lists.canonical.com
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 64.128.31.220
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
In-Reply-To: <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29266>

Sean wrote:
> Hmm.. It's pretty easy to test out Git ideas too.  People do it all
> the time, and without plugins.  Junio maintains several such trees
> for instance.  Dunno.. I just think plugs _sounds_ good to developers
> without much real benefit to users over regular ole source code.

Example time!

There's a plugin for Bzr which adds support for Cygwin-compatible 
symlink support on Windows. (IIRC, this involves monkey-patching some of 
the Python standard library bits).

Now, this is something which is *proposed* as a feature to be merged 
into upstream bzr, and it may happen at some point. That said, when I 
have a Windows-using coworker who wants to check out a repository that 
has symlinks in it (with his win32-native, no-cygwin-required bzr 
upstream binary), I don't need to tell him to go download and build bzr 
from a third party; instead, I just need to tell him to run a single 
command to check out the plugin in question into the bzr plugins folder.

 From an end-user convenience perspective, it's a pretty significant win.
