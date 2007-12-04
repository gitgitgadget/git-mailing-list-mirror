From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysGit on FAT32
Date: Tue, 4 Dec 2007 14:37:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712041413450.27959@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
 <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
 <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
 <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <47552084.3070601@viscovery.net>
 <m3hciyvklt.fsf_-_@roke.D-201> <Pine.LNX.4.64.0712041329230.27959@racer.site>
 <47555A9E.3090902@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 15:40:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzYx5-00073m-6E
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 15:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbXLDOiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 09:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbXLDOiD
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 09:38:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:34031 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754259AbXLDOh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 09:37:57 -0500
Received: (qmail invoked by alias); 04 Dec 2007 14:37:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 04 Dec 2007 15:37:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186I6I81C86O0gqtngubA5nZOw6amfpk8Ul5R9RJx
	p5gDN+uA09ZjHD
X-X-Sender: gene099@racer.site
In-Reply-To: <47555A9E.3090902@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67048>

Hi,

On Tue, 4 Dec 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Tue, 4 Dec 2007, Jakub Narebski wrote:
> > 
> > > Johannes Sixt <j.sixt@viscovery.net> writes:
> > > 
> > > > BTW, we do use hardlinks on Windows; even the MsysGit installer creates
> > > > them (as long as the filesystem is NTFS). So, the fallout you are
> > > > expecting/hoping for will not be in the first round of MinGW port
> > > > patches. ;)
> > > Would it be possible to add option to an installer to _not_ install
> > > git-cmd form for builtins when installing on FAT28^W FAT32?
> > 
> > It is the InnoSetup based installer that does that.  MSys has no way (yet)
> > to create hard links (at least that's the state of my knowledge).
> 
> I don't know about MSys, the runtime, but MSys's 'ln' and 'cp -l' both create
> hardlinks on NTFS. And for this reason, 'git clone -l' does, too.

Does it?  *goestocheck* Indeed it works!  (The hardest part was to verify 
it; seems like you have to use MSys' stat.exe, as regular Windows seems to 
have _no_ tool to find that out.)

Thanks,
Dscho
