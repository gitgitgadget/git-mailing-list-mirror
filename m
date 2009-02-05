From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] valgrind: do not require valgrind 3.4.0 or newer
Date: Thu, 5 Feb 2009 21:51:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902052150230.7491@intel-tinevez-2-302>
References: <cover.1233858507u.git.johannes.schindelin@gmx.de> <b204f01577584835f1c0252c77ffbfab33442a79.1233858507u.git.johannes.schindelin@gmx.de> <7vzlh0bp6f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVBDS-0000cP-Pz
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbZBEUv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbZBEUv1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:51:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:36267 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751937AbZBEUv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:51:27 -0500
Received: (qmail invoked by alias); 05 Feb 2009 20:51:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp058) with SMTP; 05 Feb 2009 21:51:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UAOx9m3JUqBUWDu/xkNafSHmcnwZS9UUyk8DYh2
	yF3vBLSVAwDcM0
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vzlh0bp6f.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108616>

Hi,

On Thu, 5 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Valgrind 3.4.0 is pretty new, and even if --track-origins is a nice
> > feature, it is not the end of the world if that is not available.  So
> > play nice and use that option only when only an older version of
> > valgrind is available.
> 
> s/older/newer/?

s/only an older/a newer/  even.

> > +TRACK_ORIGINS=
> > +case "$(valgrind --version)" in
> > +valgrind-{3.[4-9],3.[1-3][0-9],[4-9],[1-3][0-9]}*)
> > +	TRACK_ORIGINS=--track-origins=yes
> > +esac
> 
> What kind of case pattern is that?

A non-working one.

Grumbles,
Dscho
