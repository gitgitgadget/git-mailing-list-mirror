From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] for-each-ref: refactor refname handling
Date: Wed, 8 Apr 2009 02:27:17 -0400
Message-ID: <20090408062717.GA26929@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net> <20090407070651.GB2924@coredump.intra.peff.net> <7vprfnr7es.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 08:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRHt-0003NR-5I
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761783AbZDHG1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758659AbZDHG1k
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:27:40 -0400
Received: from peff.net ([208.65.91.99]:33061 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758098AbZDHG1j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 02:27:39 -0400
Received: (qmail 14757 invoked by uid 107); 8 Apr 2009 06:27:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 08 Apr 2009 02:27:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Apr 2009 02:27:17 -0400
Content-Disposition: inline
In-Reply-To: <7vprfnr7es.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116043>

On Tue, Apr 07, 2009 at 11:22:51PM -0700, Junio C Hamano wrote:

> > The diff is scary, but it is mostly reindentation.
> ... and an introduction of a bug ;-)

Oops. 

> > +				die("unknown %.*s format %s",
> > +					formatp - name, name, formatp);
> 				die("unknown %.*s format %s",
>                                     (int)(formatp - name), name, formatp);

Hey, it's all 32 bits, right? ;)

Thanks for spotting it.

-Peff
