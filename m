From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add test case for ls-files --with-head
Date: Wed, 3 Oct 2007 16:21:58 -0400
Message-ID: <20071003202157.GA28043@coredump.intra.peff.net>
References: <1191390255.16292.2.camel@koto.keithp.com> <7vtzp8g2s2.fsf@gitster.siamese.dyndns.org> <87y7ekr86e.wl%cworth@cworth.org> <47038669.30302@viscovery.net> <Pine.LNX.4.64.0710031634300.28395@racer.site> <87myv0qj2u.wl%cworth@cworth.org> <85ejgcrx6r.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 22:22:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAjk-000883-5p
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbXJCUWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbXJCUWB
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:22:01 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1993 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711AbXJCUWA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:22:00 -0400
Received: (qmail 20340 invoked by uid 111); 3 Oct 2007 20:21:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Oct 2007 16:21:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2007 16:21:58 -0400
Content-Disposition: inline
In-Reply-To: <85ejgcrx6r.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59880>

On Wed, Oct 03, 2007 at 06:15:56PM +0200, David Kastrup wrote:

> for i in {1,2,3,4,5}{0,1,2,3,4,5,6,7,8,9}
> do
>   ...
> done

$ dash
$ for i in {1,2,3,4,5}{0,1,2,3,4,5,6,7,8,9}; do echo $i; done
{1,2,3,4,5}{0,1,2,3,4,5,6,7,8,9}
$

-Peff
