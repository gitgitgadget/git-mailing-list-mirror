From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] editor.c: Libify launch_editor()
Date: Fri, 25 Jul 2008 16:15:17 +0200
Message-ID: <20080725141517.GB18198@leksak.fem-net>
References: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness> <1216380408-21671-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807181405510.3932@eeepc-johanness> <7vvdyuuzq2.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807251226500.11976@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 16:16:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMO63-0000kj-OM
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 16:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYGYOP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 10:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYGYOP1
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 10:15:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:45759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752817AbYGYOP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 10:15:26 -0400
Received: (qmail invoked by alias); 25 Jul 2008 14:15:24 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp016) with SMTP; 25 Jul 2008 16:15:24 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18Ie7pdC5UIjy0p9Wy34pcHTPmhSC9W48H3v3ya8r
	khZfJH660XfRrp
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMO4j-0005M8-HT; Fri, 25 Jul 2008 16:15:17 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807251226500.11976@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90053>

Hi,

Johannes Schindelin wrote:
> On Fri, 25 Jul 2008, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Fri, 18 Jul 2008, Stephan Beyer wrote:
> > >
> > >> diff --git a/editor.c b/editor.c
> > >> index 483b62d..5d7f5f9 100644
> > >> --- a/editor.c
> > >> +++ b/editor.c
> > >> @@ -17,9 +17,8 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
> > > ...
> > > Why not "return error()"?
> > >
> > > Rest looks obviously correct to me!
> > 
> > This is a patch to an existing file editor.c???
> 
> Yes, Stephan sent the two patches unrelatedly,

Yes, because when I've sent 1/2, I didn't knew that 2/2 will exist.
So I've just sent the second patch "into this thread" and hoped it would
be clear how it is meant. :)

So, to summarize:
[PATCH 1/2] http://thread.gmane.org/gmane.comp.version-control.git/88940/focus=88940
[PATCH 2/2] http://thread.gmane.org/gmane.comp.version-control.git/88940/focus=89035

They still apply cleanly to current master.

> even if they should have been marked "1/2" and "2/2".
> I hope he does so now.

This means I should send them again?

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
