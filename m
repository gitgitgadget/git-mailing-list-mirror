From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config
 variable
Date: Wed, 16 Jan 2008 01:40:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801160139390.17650@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de> <47893F53.2070908@gmail.com> <alpine.LSU.1.00.0801132220200.8333@wbgn129.biozentrum.uni-wuerzburg.de> <478AD5A0.50900@gmail.com> <7vabn9m30a.fsf@gitster.siamese.dyndns.org>
 <478C3CD3.6010504@gmail.com> <7vy7arhas9.fsf@gitster.siamese.dyndns.org> <478D3CD8.3040805@gmail.com> <alpine.LSU.1.00.0801160016320.17650@racer.site> <478D5D07.3030202@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:41:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExHG-000423-Gy
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbYAPBkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbYAPBkq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:40:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:49133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751353AbYAPBkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:40:45 -0500
Received: (qmail invoked by alias); 16 Jan 2008 01:40:43 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 16 Jan 2008 02:40:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aLDRYdkmavNzVCxH6XAHD5QuSmZUTy5hFUJoQGb
	+ZjFGtwNv9afdJ
X-X-Sender: gene099@racer.site
In-Reply-To: <478D5D07.3030202@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70597>

Hi,

On Tue, 15 Jan 2008, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> 
> > There's got to be a way to fix this _without_ affecting other users.
>   I believe the only normally visible change from my proposal is that 
> git-submodule update will follow top-level's branch from 
> branch.<name>.remote, which is a good thing. The other changes are only 
> visible if using clone -o or otherwise explicitly asking that "origin" 
> not be used or defined, which again is actually following the user's 
> request.
> 
> If you know of other effects, please explain them.

Do I really have to explain this late in the game for 1.5.4 how such 
intrusive changes can affect stability of code paths which would be 
otherwise unaffected by submodules?  I think not.

Ciao,
Dscho
