From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 13:24:40 +0200
Organization: At home
Message-ID: <ehablj$bm4$1@sea.gmane.org>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org>
	<45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org>
	<20061019091045.GV75501@over-yonder.net>
	<45375E56.4090106@op5.se> <vpqirigqzpd.fsf@ecrins.imag.fr>
	<20061019123349.GE20017@pasky.or.cz>
	<vpqr6x4pghp.fsf@ecrins.imag.fr> <87ac3s2syi.wl%cworth@cworth.org>
	<vpq1wp42rd4.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8Bit
Cc: git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 13:26:51 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GasWN-0002Eb-KL
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 13:26:39 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GasWB-0000oi-3U; Fri, 20 Oct 2006 12:26:27 +0100
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1GasVA-0000nk-5E
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 12:25:26 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GasUt-0001pV-PX
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 13:25:09 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Fri, 20 Oct 2006 13:25:07 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <bazaar-ng@lists.canonical.com>; Fri, 20 Oct 2006 13:25:07 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29449>

Matthieu Moy wrote:

> Then, one other difference is in the UI. bzr shows you commits in a
> kind of hierarchical maner, like (fictive example, that's not the real
> exact format).
> 
> $ bzr log
> commiter: upstream@maintainer.com
> message:
>   merged the work on a feature
>   ------
>   commiter: contributor@site.com
>   message:
>     prepared for feature X
>   ------
>   commiter: contributor@site.com
>   message:
>     implemented feature X
>   ------
>   commiter: contributor@site.com
>   message:
>     added testcase for feature X
> ------
> commiter: upstream@maintainer.com
> message:
>   something else
> 
> No big difference in the model either, but it probably reveals a
> different vision of what "history" means.

We have in GIT git-show-branch command for that (although it
has quite strange UI, and shows only title of commit), we
can do "git log | git name-rev --stdin", or better use graphical
history viewers like gitk (Tcl/Tk) or qgit (Qt). Graphical history
viewers are a must with more complicated history. 

Bazaar-NG has bzr-gtk.
