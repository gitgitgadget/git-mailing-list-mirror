From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Fix git stash apply
Date: Tue, 21 Jul 2009 22:56:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907212253440.3155@pacific.mpi-cbg.de>
References: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:54:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTMLx-00064E-4e
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbZGUUyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754332AbZGUUyR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:54:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:59065 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751625AbZGUUyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:54:16 -0400
Received: (qmail invoked by alias); 21 Jul 2009 20:54:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 21 Jul 2009 22:54:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rHrVtzS/rQrdMfFk4slqFQ35ARxEuy1dB2wURxl
	lsAnFIc8rRHyUE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123715>

Hi,

On Tue, 21 Jul 2009, Martin Koegler wrote:

> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>

As "git stash" is run through the Git wrapper, which appends the libexec 
path to PATH, this is no "fix".

Apart from that, it is a nice patch, though, except maybe your leaving 
only white space between the commit subject and the sign-off: you could 
have _said_ that this is converting a dashed command to a non-dashed one, 
instead of sending everybody who is interested enough on a hunt where 
exactly those two lines differ (was not easy to spot, let me tell you 
this).

Hth,
Dscho
