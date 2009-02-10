From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Spending time in PS1, was Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 11:22:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101120460.10279@pacific.mpi-cbg.de>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <7vr627qd4p.fsf@gitster.siamese.dyndns.org> <slrngp1u4h.i22.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 11:23:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWpm9-0004Rq-Kp
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 11:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbZBJKWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 05:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZBJKWF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 05:22:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:55588 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752705AbZBJKWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 05:22:03 -0500
Received: (qmail invoked by alias); 10 Feb 2009 10:22:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 10 Feb 2009 11:22:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18M3j8lfBAMiidBn9RtyEiuaMqglXBlHDqzYx1Td8
	g3A6hsjO4A5d7J
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <slrngp1u4h.i22.sitaramc@sitaramc.homelinux.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109195>

Hi,

On Tue, 10 Feb 2009, Sitaram Chamarty wrote:

> I wonder if I could ask people opinions on a trick I pulled, which is 
> basically maintain a state of the value of $SECONDS each time the user 
> is shown a bash prompt.  If the value is the same as last time (meaning 
> he hit enter twice in a row very quickly), it runs the extra stuff.

As you know, I am a big fan of consistency.  In this light, I do not like 
it when I am shown something at times, and at other times not.

Besides, I agree with Junio that even a single second spent to calculate 
PS1 is too much.  I use my command line extensively (some claim I live in 
it).  An slow PS1 would drive me to madness.

Ciao,
Dscho
