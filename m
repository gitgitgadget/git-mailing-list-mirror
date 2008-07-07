From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-rerere: fix conflict markers parsing
Date: Mon, 7 Jul 2008 15:06:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071505470.18205@racer>
References: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr> <alpine.DEB.1.00.0807071400180.18205@racer> <48722038.1010203@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-302286557-1215439592=:18205"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:09:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFrPB-00072N-Qs
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbYGGOI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbYGGOI2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:08:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:59170 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753300AbYGGOI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:08:27 -0400
Received: (qmail invoked by alias); 07 Jul 2008 14:08:25 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp057) with SMTP; 07 Jul 2008 16:08:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hCEFzzIEhdODLYDPzxFNJRaidrJMpvZxiArZShQ
	/WtWxuDQ4uKVTh
X-X-Sender: gene099@racer
In-Reply-To: <48722038.1010203@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87609>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-302286557-1215439592=:18205
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 7 Jul 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> > 
> > So what about
> > 
> > 	<<<<<<< This hunk contains =====
> > 	anythin
> > 	=======
> > 
> > 	Hello
> > 	=======
> > 	somethin else
> > 	>>>>>>> problem!
> > 
> > 
> > If you fix it, I think you should do it properly, and analyze the index.
> 
> If I read the code correctly, this case is not a problem at all because what
> is important is the content between <<< and >>> : even if you match the wrong
> === marker, you will match the first one only, then parsing will success and
> preimage file will be OK. Also because we always match in the same order the
> sha1 will be the same.
> 
> Anyway, I do not know how to match the right === marker.

Okay, but then the obvious question is: what do you do about "<<<<<<" 
lines that are not a marker?

Same remark as before: if you fix rerere, why not do it properly?

Ciao,
Dscho

--8323329-302286557-1215439592=:18205--
