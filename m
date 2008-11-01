From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 21:26:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811012124250.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl> <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org> <20081101001300.GE14786@spearce.org> <alpine.LFD.2.00.0810312106310.13034@xanadu.home>
 <20081101011910.GH14786@spearce.org> <alpine.LFD.2.00.0810312135190.13034@xanadu.home> <20081101015217.GJ14786@spearce.org> <alpine.DEB.1.00.0811010320370.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081101110120.GA3819@artemis.corp>
 <alpine.LFD.2.00.0811010944000.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 21:20:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwMwu-0004Ni-Gn
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 21:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbYKAUSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbYKAUSn
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 16:18:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:46274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752448AbYKAUSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 16:18:42 -0400
Received: (qmail invoked by alias); 01 Nov 2008 20:18:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 01 Nov 2008 21:18:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190+JNL/+V0SGW0hK/GbzKjED4ikX5xDABhshojIo
	IgsCob+5ZeJ8Sc
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0811010944000.13034@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99770>

Hi,

On Sat, 1 Nov 2008, Nicolas Pitre wrote:

> Again, please have a look at include/linux/err.h.  The pointer range 
> from 0xffffffff (or 0xffffffffffffffff on 64-bit machines) down to the 
> range you want is for errors, and the top of the address range is almost 
> certain to never be valid in user space either.

How certain may I be of that assumption?  Because an assumption it is.

Ciao,
Dscho
