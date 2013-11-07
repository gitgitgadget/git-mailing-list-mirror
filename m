From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] gitignore.txt: clarify recursive nature of excluded
 directories
Date: Thu, 7 Nov 2013 12:57:32 -0800
Message-ID: <20131107205732.GA16564@sigill.intra.peff.net>
References: <527BC00D.8000501@gmail.com>
 <527BC068.3040303@gmail.com>
 <xmqqa9hg59av.fsf@gitster.dls.corp.google.com>
 <xmqq61s457gd.fsf@gitster.dls.corp.google.com>
 <20131107195546.GA13456@sigill.intra.peff.net>
 <527BF7A4.6070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 21:58:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeWe3-0004JL-PQ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 21:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab3KGU5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 15:57:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:35154 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751010Ab3KGU5e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 15:57:34 -0500
Received: (qmail 13005 invoked by uid 102); 7 Nov 2013 20:57:34 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Nov 2013 14:57:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Nov 2013 12:57:32 -0800
Content-Disposition: inline
In-Reply-To: <527BF7A4.6070203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237428>

On Thu, Nov 07, 2013 at 09:27:16PM +0100, Karsten Blees wrote:

> > How about:
> > 
> >   It is not possible to re-include a file if a parent directory of that
> >   file is excluded. Once git considers a directory excluded, it does not
> >   descend into the directory to consider its contents further.
> > 
> 
> Hmm...an unsuspecting reader might still assume that it works in
> top-level .gitignore, given the precendence rules above...
> 
> How about this:
> 
>    It is not possible to re-include a file if a parent directory of that
>    file is excluded. Git doesn't list excluded directories for performance
>    reasons, so any patterns on contained files have no effect, no matter
>    where they are defined.

Yeah, I like that.

-Peff
