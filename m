From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] editor.c: Libify launch_editor()
Date: Fri, 25 Jul 2008 12:28:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807251226500.11976@eeepc-johanness>
References: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness> <1216380408-21671-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807181405510.3932@eeepc-johanness> <7vvdyuuzq2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 12:28:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKWs-0001Mb-P8
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbYGYK1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbYGYK1G
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:27:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:57340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753092AbYGYK1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:27:05 -0400
Received: (qmail invoked by alias); 25 Jul 2008 10:27:03 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp041) with SMTP; 25 Jul 2008 12:27:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ksYg5AhKkxWeloNUHBGui4cB/AcgSKYWpiha1io
	hFQftCiieQVppB
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vvdyuuzq2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90024>

Hi,

On Fri, 25 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 18 Jul 2008, Stephan Beyer wrote:
> >
> >> diff --git a/editor.c b/editor.c
> >> index 483b62d..5d7f5f9 100644
> >> --- a/editor.c
> >> +++ b/editor.c
> >> @@ -17,9 +17,8 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
> > ...
> > Why not "return error()"?
> >
> > Rest looks obviously correct to me!
> 
> This is a patch to an existing file editor.c???

Yes, Stephan sent the two patches unrelatedly, even if they should have 
been marked "1/2" and "2/2".  I hope he does so now.

Ciao,
Dscho
