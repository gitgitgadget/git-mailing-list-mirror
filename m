From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Support "\" in non-wildcard exclusion entries
Date: Thu, 12 Feb 2009 11:44:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902121143560.10279@pacific.mpi-cbg.de>
References: <20090210121149.GA1226@pvv.org> <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de> <20090210125800.GA14800@pvv.org> <alpine.DEB.1.00.0902101402230.10279@pacific.mpi-cbg.de> <20090210142017.GA16478@pvv.org> <alpine.DEB.1.00.0902101525380.10279@pacific.mpi-cbg.de>
 <20090210143742.GB16478@pvv.org> <7vab8upb5v.fsf@gitster.siamese.dyndns.org> <7v7i3ynt1z.fsf@gitster.siamese.dyndns.org> <20090212093250.GA9623@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 11:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXZ49-0005TN-DC
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 11:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853AbZBLKni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 05:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbZBLKni
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 05:43:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:56560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756739AbZBLKng (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 05:43:36 -0500
Received: (qmail invoked by alias); 12 Feb 2009 10:43:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 12 Feb 2009 11:43:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tDtw3YiotjvRQ5aVE0aFS3mmu7p2aOgvXymF7ir
	xRCdeDm8TzSPfq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090212093250.GA9623@pvv.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109598>

Hi,

On Thu, 12 Feb 2009, Finn Arne Gangstad wrote:

> @@ -82,6 +88,7 @@ test_expect_success \
>  cat > excludes-file << EOF
>  *.[1-8]
>  e*
> +\#*
>  EOF

You addressed all comments, except the \EOF comment, I guess.

Thanks,
Dscho
