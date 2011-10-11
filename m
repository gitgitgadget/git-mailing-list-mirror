From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 6/6] Retain caches of submodule refs
Date: Tue, 11 Oct 2011 19:41:01 +0200
Message-ID: <20111011174101.GC2647@sandbox-rc>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
 <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu>
 <7v4o1hgemp.fsf@alter.siamese.dyndns.org>
 <4E918194.5060102@alum.mit.edu>
 <20111010195325.GA5981@sandbox-rc>
 <4E93C232.9090400@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 19:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDgKH-0002h1-Bj
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 19:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236Ab1JKRlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 13:41:05 -0400
Received: from darksea.de ([83.133.111.250]:56348 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755148Ab1JKRlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 13:41:04 -0400
Received: (qmail 32339 invoked from network); 11 Oct 2011 19:41:01 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Oct 2011 19:41:01 +0200
Content-Disposition: inline
In-Reply-To: <4E93C232.9090400@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183311>

Hi,

On Tue, Oct 11, 2011 at 06:12:34AM +0200, Michael Haggerty wrote:
> On 10/10/2011 09:53 PM, Heiko Voigt wrote:
> > On Sun, Oct 09, 2011 at 01:12:20PM +0200, Michael Haggerty wrote:
> > Since the setup_revision() api can currently not be used to safely
> > iterate twice over the same submodule my patch
> > 
> > 	allow multiple calls to submodule merge search for the same path
> > 
> > rewrites the search into using a child process. AFAIK the submodule ref
> > iteration api would then even be unused.
> 
> If your patch is accepted, then we should check whether anything should
> be ripped out.

I would rather like to extend the setup_revision() api so that we can
iterate multiple times. Additionally I have a feeling that this API
might be useful for further extensions of the recursive-push support of
submodules which is currently under development.

So in summary: I would like to wait with ripping anything out until we
get to a final state with submodule support.

Cheers Heiko
