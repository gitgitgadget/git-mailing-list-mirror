From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Mon, 26 Nov 2012 17:28:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211261726260.7256@s15462909.onlinehome-server.info>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com> <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com> <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com> <7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
 <20121121041735.GE4634@elie.Belkin> <7vfw43pmp7.fsf@alter.siamese.dyndns.org> <20121121194810.GE16280@sigill.intra.peff.net> <CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com> <7v7gp9udsl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 17:28:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td1Y0-0003Lp-J5
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 17:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab2KZQ2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 11:28:24 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:60531 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754697Ab2KZQ2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 11:28:24 -0500
Received: (qmail invoked by alias); 26 Nov 2012 16:28:22 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp034) with SMTP; 26 Nov 2012 17:28:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ml+E1Pf0mI+Tc/OMCZ4ymFGVDx1AffhD5vMHGiF
	WuVYfNVeWpdH3x
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7v7gp9udsl.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210456>

Hi Junio,

On Sun, 25 Nov 2012, Junio C Hamano wrote:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
> Date: Fri, 2 Nov 2012 16:17:14 +0100 (CET)
> Message-ID: <alpine.DEB.1.00.1211021612320.7256@s15462909.onlinehome-server.info>
> 
> (which is $gmane/208946) that says:
> 
> 	Note that
> 
> 		$ git branch foo master~1
> 		$ git fast-export foo master~1..master
> 
> 	still does not update the "foo" ref, but a partial fix is better
> 	than no fix.

If you changed your stance on the patch Sverre and I sent to fix this, we
could get a non-partial fix for this. You wanted a fix for a bigger
problem, though, which I am unwilling to fix because it is not my itch to
scratch and I have to balance my time.

Ciao,
Johannes
