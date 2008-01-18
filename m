From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 13:09:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181308080.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7E3714CE-0073-4E42-A455-36D595946A6C@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 14:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFqz6-0001eZ-Qd
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 14:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759518AbYARNJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 08:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759441AbYARNJj
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 08:09:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:51123 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759277AbYARNJj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 08:09:39 -0500
Received: (qmail invoked by alias); 18 Jan 2008 13:09:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp006) with SMTP; 18 Jan 2008 14:09:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/O+nBw5FjOkiIvktfxhv14ofvkO1MgdCL9LoCGg5
	UA7fYbMUt+Sxos
X-X-Sender: gene099@racer.site
In-Reply-To: <7E3714CE-0073-4E42-A455-36D595946A6C@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71015>

Hi,

On Fri, 18 Jan 2008, Steffen Prohaska wrote:

> 
> On Jan 18, 2008, at 11:40 AM, Junio C Hamano wrote:
> 
> >  * crlf (Steffen Prohaska and Dmitry Potapov)
> 
> I am working on an alternative to the patch I sent last week. I hope I 
> can present the two approaches soon.
> 
> The first approach is a lazy check in crlf_to_git() that warns about an 
> irreversible conversion; or dies if safecrlf=true.  This is relatively 
> simple code but at least for git-add a workaround is needed to suppress 
> printing a warning twice.  The runtime overhead is negligible.
> 
> The second approach adds a new machinery is_worktree_crlfsafe()
> that could be run independently of the crlf_to_git() conversion.

>From the sound of it, I like the first approach much better.

> I do not expect that this topic will be ready for 1.5.4.

What with our ongoing discussion when to go out of preview phase for 
msysGit, I think this makes sense.

Ciao,
Dscho
