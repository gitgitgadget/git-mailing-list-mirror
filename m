From: Jeff King <peff@peff.net>
Subject: Re: Removing duplicated code between builtin-send-pack.c and
	transport.c
Date: Wed, 22 Apr 2009 15:14:39 -0400
Message-ID: <20090422191439.GA13646@coredump.intra.peff.net>
References: <09511913-0ED3-41C0-A4F0-9F2D452C00D7@petdance.com> <alpine.LNX.1.00.0904221407160.10753@iabervon.org> <20090422190337.GA13424@coredump.intra.peff.net> <FF499E4E-B2F1-4795-B9F9-AD73CDDE417A@petdance.com> <20090422191044.GC13424@coredump.intra.peff.net> <ADA21A9C-96E3-4441-B925-5B623433F42E@petdance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:17:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwhx1-000302-Jo
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbZDVTOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbZDVTOo
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:14:44 -0400
Received: from peff.net ([208.65.91.99]:51223 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbZDVTOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:14:43 -0400
Received: (qmail 17478 invoked by uid 107); 22 Apr 2009 19:14:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 15:14:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 15:14:39 -0400
Content-Disposition: inline
In-Reply-To: <ADA21A9C-96E3-4441-B925-5B623433F42E@petdance.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117236>

On Wed, Apr 22, 2009 at 02:13:28PM -0500, Andy Lester wrote:

>> I don't know if that is quite appropriate. I think the point of moving
>> many of the duplicated functions into transport.c is that they are used
>> by other transports, like http. So probably the transport-agnostic ones
>> should stay in transport.c, and they should all get called in the same
>> way, no matter what the transport.
>
> My mistake.  I'll remove the code from builtin-send-pack.c, improve it, 
> and builtin-send-pack.c can get deprecated when/if anyone wants.

That makes sense. Thanks.

-Peff
