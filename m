From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 16:52:51 -0400
Message-ID: <20120328205251.GB10174@sigill.intra.peff.net>
References: <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328203758.GA10104@sigill.intra.peff.net>
 <20120328205133.GF8982@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:53:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzrW-0000FL-PM
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853Ab2C1Uwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:52:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36381
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847Ab2C1Uwx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:52:53 -0400
Received: (qmail 21873 invoked by uid 107); 28 Mar 2012 20:53:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 16:53:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 16:52:51 -0400
Content-Disposition: inline
In-Reply-To: <20120328205133.GF8982@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194195>

On Wed, Mar 28, 2012 at 03:51:33PM -0500, Jonathan Nieder wrote:

> > Hmm, this should check for (*file == '/') to handle absolute paths
> > properly.
> 
> Or rather for "strchr(file, '/')", because "path/to/cmd" does not mean to
> append that string to each term of $PATH.

Yes, thanks for a sanity check.

-Peff
