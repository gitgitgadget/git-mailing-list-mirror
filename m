From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according to
 git-log rules.
Date: Wed, 22 Oct 2008 22:29:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810222220410.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com> <20081022082016.GA18473@sigill.intra.peff.net> <7vd4hsv46z.fsf@gitster.siamese.dyndns.org> <20081022191415.GA31568@coredump.intra.peff.net> <20081022192253.GC31568@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 22:23:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskFF-00046c-SU
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbYJVUWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753203AbYJVUWk
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:22:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:35280 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752789AbYJVUWj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:22:39 -0400
Received: (qmail invoked by alias); 22 Oct 2008 20:22:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 22 Oct 2008 22:22:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+I2bQ526GIEdlV2hsU9mfVYg1XorHHmOOm5wAhyK
	wH+VOEJcHz4kWr
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081022192253.GC31568@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98897>

Hi,

On Wed, 22 Oct 2008, Jeff King wrote:

> submodule: fix some non-portable grep invocations
> 
> Not all greps support "-e", but in this case we can easily
> convert it to a single extended regex.

I really wonder if we cannot catch these things (unportable grep, sed, etc 
invokations) with a simple patch to the pre-commit hook.

Ciao,
Dscho
