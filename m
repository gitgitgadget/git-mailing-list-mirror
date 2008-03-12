From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 20:59:53 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803122058430.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:00:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZX7h-00006R-Rp
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 21:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYCLT7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYCLT7r
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:59:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:47171 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751685AbYCLT7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:59:46 -0400
Received: (qmail invoked by alias); 12 Mar 2008 19:59:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 12 Mar 2008 20:59:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18m4o8Z+8QmrrQ3SUFzY4kLVMDOhCG+cL0UdLEMnv
	BV+RbtMM3IOJZM
X-X-Sender: gene099@racer.site
In-Reply-To: <47D83532.70103@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76982>

Hi,

On Wed, 12 Mar 2008, Brandon Casey wrote:

> I think git-prune is seldomly used by normal users for the reasons Dscho 
> described, and I think once the behavior implemented by his patch 
> becomes standard it will never be used by normal users (except the ones 
> who always use --prune for the reasons Geert Bosch described, and 
> they'll probably want the new behavior). So I think git-prune will sink 
> a little lower into plumbing and common users won't need to know 
> anything about pruning, and only sophisticated users will need to know 
> git-prune.

But because we are nice people, we will deprecate --prune before we remove 
it, should we go that route at all.

Ciao,
Dscho
