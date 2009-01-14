From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] color-words: change algorithm to allow for 0-character
 word boundaries
Date: Wed, 14 Jan 2009 19:08:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141907200.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de> <200901120947.13566.trast@student.ethz.ch> <7vprisj26i.fsf@gitster.siamese.dyndns.org> <adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com>
 <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901141851030.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:10:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNAC2-0001do-42
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 19:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbZANSIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 13:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbZANSIw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 13:08:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:39761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753197AbZANSIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 13:08:50 -0500
Received: (qmail invoked by alias); 14 Jan 2009 18:08:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 14 Jan 2009 19:08:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19l3gJ7J1ZlDpPjz6+vlQpE1dbgTWoYLYi1E8C9+o
	ZuT772x21k4QuT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901141851030.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105676>

Hi,

On Wed, 14 Jan 2009, Johannes Schindelin wrote:

> +test_expect_success setup '
> +
> +	git config diff.color.old red
> +	git config diff.color.new green
> +
> +'

Oops.  This should probably go...

Ciao,
Dscho
