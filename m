From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Fri, 16 Jan 2009 17:29:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-314686534-1232123395=:3586"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNraX-0003TC-02
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760767AbZAPQ3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 11:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760118AbZAPQ3D
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:29:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:51901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758899AbZAPQ3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 11:29:00 -0500
Received: (qmail invoked by alias); 16 Jan 2009 16:28:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 16 Jan 2009 17:28:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XGNkJsQfXHOcAmbQddIjFDp3xdGT5o1SR4D1CSS
	H3XNMi0xBqQ/TK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105973>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-314686534-1232123395=:3586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 16 Jan 2009, SZEDER Gábor wrote:

>   I'm not sure about setting an absolut path instead of a relative one 
>   (hence the RFC), although I think it should not make any difference. 
>   Of course I could have count the number of chdir("..") calls and then 
>   construct a "../../..", but that would have been more intrusive than 
>   this two-liner.

IIRC the absolute paths were shot down already... for performance reasons.

So we try very hard to keep relative paths instead of absolute ones.

Ciao,
Dscho

--8323328-314686534-1232123395=:3586--
