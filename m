From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command line
Date: Thu, 09 Jul 2009 10:43:03 +0200
Message-ID: <200907091043.03263.johan@herland.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <200907081801.36901.johan@herland.net>
 <7vws6j6qed.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:43:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpDm-0002GF-9P
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187AbZGIInI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbZGIInH
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:43:07 -0400
Received: from mx.getmail.no ([84.208.15.66]:41566 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755509AbZGIInG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 04:43:06 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI00AC9AVSXKB0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 10:43:04 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI00LX3AVRMA50@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 10:43:04 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.9.83323
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <7vws6j6qed.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122946>

On Wednesday 08 July 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Maybe I need to do something to the close() call as well? What happens
> > on close() after EPIPE?
>
> You should be OK (you could try this).
>
> -- >8 --

Thanks! The programs works well on my Linux box (close() succeeds), but it 
does not run at all in Windows/MSYS (lacks pipe() and fork()).

Does anybody with Windows/MSYS experience know how this scenario (write() to 
a terminated process, followed by close()) would play out in msysGit?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
