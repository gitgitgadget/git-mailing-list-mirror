From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config
 variable
Date: Sat, 12 Jan 2008 21:24:43 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 21:25:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDmv4-0003QI-Li
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 21:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759461AbYALUYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 15:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759065AbYALUYr
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 15:24:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:35529 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757497AbYALUYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 15:24:45 -0500
Received: (qmail invoked by alias); 12 Jan 2008 20:24:44 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp039) with SMTP; 12 Jan 2008 21:24:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Wu7RwWwrWjw9hUY8xZr910on6EMXwVXf/jrqL3Y
	0KVcqrx5xzC2Db
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <47891658.3090604@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70358>

Hi,

On Sat, 12 Jan 2008, Mark Levedahl wrote:

> Junio C Hamano wrote:
> > Ahh.
> > 
> > Does that suggest the new configuration thing is only about the 
> > "submodule update" command, not "remotes.default" that affects how the 
> > non-submodule merge and fetch works?
>
> Yes - this patch set was inspired by the single question of "how do I 
> avoid needing to define origin as opposed to a server-specific nickname 
> now that I am using sub-modules?"

Why is your patch then not about git-submodule?

And I still fail to see -- even for submodules -- how you begin to tackle 
that lookup problem.

Ciao,
Dscho
