From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Thu, 29 Jan 2009 00:06:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901290005200.3586@pacific.mpi-cbg.de>
References: <4980D9FF.7020307@gmail.com> <7vvdrzjb80.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 00:08:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSJVI-0004sc-JR
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 00:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbZA1XGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 18:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbZA1XGA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 18:06:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:60580 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751524AbZA1XF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 18:05:59 -0500
Received: (qmail invoked by alias); 28 Jan 2009 23:05:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 29 Jan 2009 00:05:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zs4A1eF4zg9krXmdgzSQm3uXqJJ9VRiN1fskIEQ
	GZaZaeHq48OnBw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdrzjb80.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107593>

Hi,

On Wed, 28 Jan 2009, Junio C Hamano wrote:

> I thought at least you did not have these overlong lines in your earlier 
> attempts, and Dscho may have acked one of those, but I doubt he would 
> give his Ack to this one.  I certainly wouldn't Ack it myself.

My understanding is that the ACK is sent to the mailing list by the Acker 
and in response to the particular patch she is Acking.

> The refactoring looked sane otherwise, but I think we would want to opt 
> for safety by keeping an extra string around.

Yep.  Better safe 'n sorry.

Ciao,
Dscho
