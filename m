From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in
 ~/.config/git/config file
Date: Sat, 26 May 2012 17:49:04 -0400
Message-ID: <20120526214904.GB29463@sigill.intra.peff.net>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
 <vpq62bjnx14.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>,
	git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat May 26 23:49:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYOrH-0002S6-U9
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 23:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab2EZVtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 17:49:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56802
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab2EZVtG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 17:49:06 -0400
Received: (qmail 24539 invoked by uid 107); 26 May 2012 21:49:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 May 2012 17:49:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 May 2012 17:49:04 -0400
Content-Disposition: inline
In-Reply-To: <vpq62bjnx14.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198570>

On Sat, May 26, 2012 at 10:53:27AM +0200, Matthieu Moy wrote:

> NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr> writes:
> 
> > +			sprintf(config_path, "%s/.config/git/config", home);
> 
> It's not terribly important, but if we are to use something that looks
> like XDG, I'd rather have a real support for it. ~/.config/ is the
> default, but the spec
> http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
> also define $XDG_CONFIG_HOME that may override the default and we may
> want to support $XDG_CONFIG_DIRS too.

I agree. This series is much less appealing as "put the config in some
other place" and much more appealing as "conform to an existing standard
about dot-file locations". And if we are going to follow the standard,
then we should do all parts of it.

-Peff
