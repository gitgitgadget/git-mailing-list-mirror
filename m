From: Jeff King <peff@peff.net>
Subject: Re: Topics currently in the Stalled category
Date: Tue, 27 Nov 2012 22:22:45 -0500
Message-ID: <20121128032245.GD27772@sigill.intra.peff.net>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
 <7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
 <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
 <CAMP44s30cbH5+HUxRBByk5sZGq=j_MdqLSnNzREozEk40_zbOw@mail.gmail.com>
 <20121128025928.GA27772@sigill.intra.peff.net>
 <20121128031118.GB27772@sigill.intra.peff.net>
 <CAMP44s3ZtCNsedJtsHDJx5d4Myjbbp+D6yT-rO-CmKOTtt91VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:23:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYEq-0004P2-17
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab2K1DWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:22:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58939 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab2K1DWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:22:48 -0500
Received: (qmail 1883 invoked by uid 107); 28 Nov 2012 03:23:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 22:23:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 22:22:45 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s3ZtCNsedJtsHDJx5d4Myjbbp+D6yT-rO-CmKOTtt91VQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210686>

On Wed, Nov 28, 2012 at 04:15:12AM +0100, Felipe Contreras wrote:

> > We could improve the test in t5801, but it is nice to let people on such
> > systems test it, as well. And the infrastructure might be useful if we
> > ever acquire more bash scripts.
> >
> > There's a fair bit of boilerplate, but I think this squashable patch
> > would do it:
> 
> Yeah, but I wonder what's the point of installing this script, it's
> mostly for testing and reference, and to add a whole category for that
> seems like overkill.

There's no point in installing it; I just didn't make the effort to
avoid doing so (note that testpy and testsvn are also installed, which
are in the same boat; it might make sense to split them all out like we
do for $TEST_PROGRAMS).

I agree it's an annoying amount of boilerplate, but it seems simpler
cognitively to me for it to behave as the other SCRIPT_* builds than to
do something simple but inconsistent.

I do not care enough to argue about it. We need to do something to fix
the impending test breakage on systems like Solaris. I have posted the
patch to handle BASH_PATH, so do what you want.

-Peff
