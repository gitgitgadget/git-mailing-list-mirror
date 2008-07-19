From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-clone: Use is_dir_sep() instead of '/'
Date: Sat, 19 Jul 2008 13:35:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807191334560.3305@eeepc-johanness>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at> <1216366485-12201-3-git-send-email-johannes.sixt@telecom.at> <7vk5fi67dx.fsf@gitster.siamese.dyndns.org> <200807191132.45648.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jul 19 13:36:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKAjU-0004pO-5G
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 13:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYGSLfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 07:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbYGSLfN
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 07:35:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:50527 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751980AbYGSLfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 07:35:12 -0400
Received: (qmail invoked by alias); 19 Jul 2008 11:35:10 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp016) with SMTP; 19 Jul 2008 13:35:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Qz5JipQJQgynvJYprkANsqTOTH44xARgiYwKQme
	7bs9LZnE2yL+yg
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807191132.45648.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89107>

Hi,

On Sat, 19 Jul 2008, Johannes Sixt wrote:

> On Samstag, 19. Juli 2008, Junio C Hamano wrote:
> > Ok, but the surrounding code in this function look very suspicious.
> 
> How about this then?

I like it.  Very clear, very nice.  Shorter code (if you look at the 
diffstat modulo documentation).

Ciao,
Dscho
