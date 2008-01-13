From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config
 variable
Date: Sun, 13 Jan 2008 22:27:22 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 22:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEAMz-0005xv-Lt
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 22:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbYAMV10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 16:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbYAMV10
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 16:27:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:34064 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754083AbYAMV1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 16:27:25 -0500
Received: (qmail invoked by alias); 13 Jan 2008 21:27:23 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp039) with SMTP; 13 Jan 2008 22:27:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kYpVklo9kCoZ0O1ui8YIMou+7XmMjLimuGDrKpU
	jYoteD3ag+6qwO
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70415>

Hi,

On Sat, 12 Jan 2008, Junio C Hamano wrote:

> Mark Levedahl <mlevedahl@gmail.com> writes:
> 
> > Basically, I think an important (but not complete) test of the design
> > is that
> >
> >    git clone -o frotz git://frotz.foo.bar/myproject.git
> >    cd myproject
> >    git submodule init
> >    git submodule update
> >
> > work, with origin = frotz throughout the submodules, and with the
> > whole project correctly checked out even if the entire project was
> > rehosted onto a different server.
> 
> I like that.  This is a very good argument, especially because it 
> clarifies very well that the issue is not about "'submodule init' 
> misbehaves" but "fetch/pull/merge does not play well with clone -o".

FWIW I disagree.

I never understood why people want to complicate things by being able to 
name default _keys_ differently.  Why not letting "origin" being the 
default being pulled from, and be done with it?

Besides, I _really_ do not understand why we have such a discussion in rc 
phase.  There are _many_ more interesting discussions now that _also_ do 
not belong into a freeze phase.

Ciao,
Dscho
