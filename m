From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t7500-commit.sh: do not call test_set_editor unnecessarily,
 it's confusing
Date: Tue, 30 Dec 2008 13:04:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812301250210.30769@pacific.mpi-cbg.de>
References: <1230542658-9758-1-git-send-email-dato@net.com.org.es> <7vmyefco11.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1382677403-1230638687=:30769"
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 13:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHdME-0003Jb-HL
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 13:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbYL3MEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 07:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYL3MEC
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 07:04:02 -0500
Received: from mail.gmx.net ([213.165.64.20]:49212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751303AbYL3MEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 07:04:00 -0500
Received: (qmail invoked by alias); 30 Dec 2008 12:03:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 30 Dec 2008 13:03:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Pvu0TZfaPkqx6bnbB/RALCGqUkQzom0/RLUieIL
	8BQdsDsOk16zmw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vmyefco11.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104175>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1382677403-1230638687=:30769
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 29 Dec 2008, Junio C Hamano wrote:

> Adeodato Simó <dato@net.com.org.es> writes:
> 
> > I was reading this test case, and it took a small bit to figure out 
> > the editor was not being used at all. I hope there was no hidden 
> > reason for it to be there, and it can go away.
> 
> That 'zort' came from 1320857 (builtin-commit: fix --signoff, 
> 2007-11-11), and I _think_ it is trying to make sure that presense of 
> "-F -" makes the editor not to trigger.
> 
> Dscho?

Hmm.  Obviously, I failed to document properly why I tested the editor, 
but I think it makes sense to assume that -F still triggered an 
interactive editor at some stage in the development of builtin commit.

I do not have anything against separating that issue into another test 
case, but I am strongly opposed to simply removing it.

Ciao,
Dscho

--8323328-1382677403-1230638687=:30769--
