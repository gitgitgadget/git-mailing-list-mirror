From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] Teach git-fetch to exploit server side automatic
 tag following
Date: Wed, 5 Mar 2008 12:21:54 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803051220360.18836@racer.site>
References: <20080304032740.GC16462@spearce.org> <alpine.LSU.1.00.0803041512040.22527@racer.site> <20080305055659.GD8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 12:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWrhq-0005NY-MA
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 12:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbYCELWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 06:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbYCELWD
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 06:22:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:46763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752355AbYCELWB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 06:22:01 -0500
Received: (qmail invoked by alias); 05 Mar 2008 11:21:58 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp043) with SMTP; 05 Mar 2008 12:21:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7j3EyrXa7t5J+GBhLa9K4+XjGigAedwjH/dmRcB
	luXW/AMcg7Qf9e
X-X-Sender: gene099@racer.site
In-Reply-To: <20080305055659.GD8410@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76210>

Hi,

On Wed, 5 Mar 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  
> > - should followtags not be the default?
> 
> No.  Absolutely not.
> 
> The client may not want tag objects from this remote.  It might not want 
> those tags for all sorts of reasons.  Maybe they are doing a one-shot 
> pull.  Maybe they don't trust this remote.  Maybe they trust this remote 
> but this remote is famous for 192M tags containing PDFs of photo images 
> of build logs printed out on paper, then photographed on a wood table 
> and finally scanned in at 600 dpi.

Sorry, I meant to say: "should the followtags feature not be on by default 
in the circumstances where we would follow tags anyway"...

Maybe you do that, but I did not see it.

> So it should only be enabled *if* we were willing to open a second 
> connection to this remote to followtags from it.  And that's not a 
> change from prior behavior either, its just faster.

Thanks,
Dscho

