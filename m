From: Jeff King <peff@peff.net>
Subject: Re: [GSoC] Week 1: Unification of 'for-each-ref', 'tag -l' and
 'branch -l'
Date: Wed, 3 Jun 2015 17:08:34 -0400
Message-ID: <20150603210833.GA32181@peff.net>
References: <556DDC21.5050801@gmail.com>
 <vpqh9qoepv1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:09:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Fu6-0005bc-F1
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 23:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbbFCVIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 17:08:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:40768 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751647AbbFCVIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 17:08:36 -0400
Received: (qmail 17039 invoked by uid 102); 3 Jun 2015 21:08:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 16:08:36 -0500
Received: (qmail 25335 invoked by uid 107); 3 Jun 2015 21:08:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 17:08:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 17:08:34 -0400
Content-Disposition: inline
In-Reply-To: <vpqh9qoepv1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270738>

On Wed, Jun 03, 2015 at 06:08:50PM +0200, Matthieu Moy wrote:

> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > Matthieu Moy suggested that I work on the unification of these
> > commands let both the implementations stay where the user can select
> > the implementation to be used
> 
> Just to be clear: my advice is the above with "user" = "caller of the
> API", not "human being using Git". In other words, "git branch
> --contains" and "git tag --contains" would still be using two different
> algorithms, but the user wouldn't notice (except for performance).

Yeah, I think that is sensible. It should be a "feature" of the
ref-filter that can hopefully go away one day (when we have a sensible
implementation that works for both; this is something I've been meaning
to push forward, but Karthik should not have to wait on me).

-Peff
