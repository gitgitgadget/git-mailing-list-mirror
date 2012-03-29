From: Jeff King <peff@peff.net>
Subject: Re: better way to find Git.pm officially?
Date: Thu, 29 Mar 2012 02:13:36 -0400
Message-ID: <20120329061336.GE27604@sigill.intra.peff.net>
References: <86r4wc9f6j.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 08:13:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD8cF-0005kd-QK
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 08:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab2C2GNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 02:13:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36820
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839Ab2C2GNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 02:13:42 -0400
Received: (qmail 28190 invoked by uid 107); 29 Mar 2012 06:13:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 02:13:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 02:13:36 -0400
Content-Disposition: inline
In-Reply-To: <86r4wc9f6j.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194234>

On Wed, Mar 28, 2012 at 09:58:12PM -0700, Randal L. Schwartz wrote:

> As in, find the git-svn binary (via git --exec-path), parse its second
> line to see where the git installer put the GITPERLLIB, and then add
> that myself.
> 
> Is there a simpler way?  Can we get "git --perl-path" added to the
> binary or something?

I always assumed that it was the responsibility of the user or the
packager to put Git.pm into a sane place that is found by perl's normal
lookup (possibly via the user's PERL5LIB if it is a per-user
installation). Doesn't our use of MakeMaker generally pick such a
suitable directory?

-Peff
