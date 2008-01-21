From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Also use unpack_trees() in do_diff_cache()
Date: Mon, 21 Jan 2008 00:19:38 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801210017580.5731@racer.site>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LSU.1.00.0801201515060.5731@racer.site> <alpine.LSU.1.00.0801201519320.5731@racer.site> <alpine.LFD.1.00.0801201144300.2957@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801201338140.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801202331380.5731@racer.site> <alpine.LFD.1.00.0801201550550.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 01:20:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGkOl-0002Lw-4A
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 01:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbYAUATy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 19:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755402AbYAUATy
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 19:19:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:49327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755211AbYAUATx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 19:19:53 -0500
Received: (qmail invoked by alias); 21 Jan 2008 00:19:51 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp052) with SMTP; 21 Jan 2008 01:19:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oMkBPctDoQr7D2exFI3lDkR4k/YTl6FV5e2zEQH
	aLyN2PlIh2EsDd
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801201550550.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71206>

Hi,

On Sun, 20 Jan 2008, Linus Torvalds wrote:

> On Sun, 20 Jan 2008, Johannes Schindelin wrote:
> > 
> > Note: "git diff HEAD" as it is now still holds value;
> 
> Oh, absolutely.
> 
> It's not "git diff HEAD" that is broken.
> 
> It's "git diff --cached HEAD" that doesn't work. The "--cached" means 
> that it's supposed to diff the index against HEAD, but since it cannot 
> handle unmerged entries, instead of getting a diff, you get just a line 
> saying
> 
> 	* Unmerged path xyzzy
> 
> and no diff at all.

Silly me.  Unmerged paths can only have problems when you look at the 
index, of course.

Sorry for the noise,
Dscho
