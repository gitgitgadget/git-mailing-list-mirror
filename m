From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Tue, 23 Oct 2007 00:21:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710230017120.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>
  <4719B655.90204@op5.se>  <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> 
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> 
 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> 
 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> 
 <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> 
 <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> 
 <Pine.LNX.4.64.0710221558230.25221@racer.site>  <471CBEB1.2030008@op5.se>
 <1193081785.4522.181.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Federico Mena Quintero <federico@novell.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 01:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6ab-0000ly-UP
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 01:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbXJVXV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 19:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbXJVXV3
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 19:21:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:34271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751394AbXJVXV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 19:21:28 -0400
Received: (qmail invoked by alias); 22 Oct 2007 23:21:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 23 Oct 2007 01:21:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cn1JXTRPcB5Gqb3hiRne4B9/YQAYXeOMW6NtlXJ
	hWcQk93Y7B8voE
X-X-Sender: gene099@racer.site
In-Reply-To: <1193081785.4522.181.camel@cacharro.xalalinux.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62055>

Hi,

On Mon, 22 Oct 2007, Federico Mena Quintero wrote:

> On Mon, 2007-10-22 at 17:16 +0200, Andreas Ericsson wrote:
> 
> > To me, it's more along the lines of "let git help me not make the 
> > mistake of hacking on a six-week old codebase when I've explicitly asked 
> > it to merge these and those remote tracking branches into these and 
> > those local branches". Not updating those branches when there *are* 
> > changes on them is something users can understand and will probably also 
> > appreciate, but the reason for not allowing even fast-forwards escape me.
> 
> I'd love this behavior, FWIW.
> 
> The "branches should not track their origin by default" seems suited
> only to Linux kernel maintainers who frequently pull from many different
> people, not to "random hacker who wants to keep track of a project he
> doesn't maintain" :)

The problem I see here is not that the kernel folks would suffer, but that 
the behaviour would not be easy to explain.  Which is a sure way to not 
only give people rope, but put their heads in the noose.

Not having clear semantics is prone to lead to misunderstandings, and 
mistakes.

IOW while I trust you when you say it would make things easier for you, I 
am quite certain it would make things much harder for a substantial part 
of the rest of humanity.

Ciao,
Dscho
