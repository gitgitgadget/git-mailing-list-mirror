From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysGit on FAT32 (was: What's cooking in git.git (topics))
Date: Tue, 4 Dec 2007 13:30:35 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712041329230.27959@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
 <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
 <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
 <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <47552084.3070601@viscovery.net>
 <m3hciyvklt.fsf_-_@roke.D-201>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 14:31:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzXrt-0006P3-Kz
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 14:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbXLDNbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 08:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbXLDNbB
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 08:31:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:45382 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752867AbXLDNbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 08:31:00 -0500
Received: (qmail invoked by alias); 04 Dec 2007 13:30:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 04 Dec 2007 14:30:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183UyFqGZU3B4fwx0NiIzQyXaOFelsAzWFFfk4liC
	6XvWTfPxROcAkx
X-X-Sender: gene099@racer.site
In-Reply-To: <m3hciyvklt.fsf_-_@roke.D-201>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67043>

Hi,

On Tue, 4 Dec 2007, Jakub Narebski wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > BTW, we do use hardlinks on Windows; even the MsysGit installer 
> > creates them (as long as the filesystem is NTFS). So, the fallout you 
> > are expecting/hoping for will not be in the first round of MinGW port 
> > patches. ;)
> 
> Would it be possible to add option to an installer to _not_ install 
> git-cmd form for builtins when installing on FAT28^W FAT32?

It is the InnoSetup based installer that does that.  MSys has no way (yet) 
to create hard links (at least that's the state of my knowledge).

Ciao,
Dscho
