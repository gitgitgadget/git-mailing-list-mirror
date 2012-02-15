From: Jeff King <peff@peff.net>
Subject: Re: git-subtree Ready #2
Date: Wed, 15 Feb 2012 00:08:55 -0500
Message-ID: <20120215050855.GB29902@sigill.intra.peff.net>
References: <877gztmfwy.fsf@smith.obbligato.org>
 <8739acra5j.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 06:09:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxX70-0003Bh-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 06:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab2BOFI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 00:08:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36199
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454Ab2BOFI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 00:08:57 -0500
Received: (qmail 16356 invoked by uid 107); 15 Feb 2012 05:16:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Feb 2012 00:16:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2012 00:08:55 -0500
Content-Disposition: inline
In-Reply-To: <8739acra5j.fsf@smith.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190811>

On Tue, Feb 14, 2012 at 10:30:16PM -0600, David A. Greene wrote:

> This is also available at:
> 
> git clone git://sources.obbligato.org/git/git.git

Hmm. So it seems like a pretty straightforward subtree merge of
git-subtree. I can't say I'm super excited about having copied bits like
contrib/subtree/t/Makefile that are basically replicas of git's
t/Makefile.  But there's not that much of it, the cruft lives in
contrib, and there's really not a good solution short of actually making
git-subtree a first-class git command.

But more important than the physical layout is the maintenance plan
going forward.  Is Avery going to keep maintaining git-subtree, and we
will just occasionally pull? Are you maintaining it? Where will patches
go? To a github repo? To git@vger?

-Peff
