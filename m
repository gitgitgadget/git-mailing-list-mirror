From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] push: add 'prune' option
Date: Tue, 21 Feb 2012 12:35:48 -0500
Message-ID: <20120221173548.GB32376@sigill.intra.peff.net>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8ACoF=2dEUoFvT8bQDmUsjJA2_VWvTSJV6fakqyCLBCYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 18:35:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rztd6-000289-A4
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 18:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557Ab2BURfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 12:35:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45308
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523Ab2BURfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 12:35:50 -0500
Received: (qmail 17349 invoked by uid 107); 21 Feb 2012 17:35:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Feb 2012 12:35:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2012 12:35:48 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8ACoF=2dEUoFvT8bQDmUsjJA2_VWvTSJV6fakqyCLBCYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191170>

On Tue, Feb 21, 2012 at 10:30:31PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Sat, Feb 18, 2012 at 2:12 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > As an example I put my use-case; I want to backup *all* my local branches to a
> > personal repository, and I want to remove branches that I have removed from my
> > local repository. git push personal 'refs/heads/*' mostly does the job, but it
> > doesn't remove anything, and that's where 'prune' comes from.
> 
> Yeah, may I have "fetch --prune" too, please? Looking at diffstat
> gives me a feeling that you only need to add maybe four lines to
> builtin/fetch.c and my dream would come true.

Huh? Don't we already have "fetch --prune"?

-Peff
