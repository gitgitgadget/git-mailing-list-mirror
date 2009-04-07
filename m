From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Add configuration variable for sign-off to
	format-patch
Date: Tue, 7 Apr 2009 03:23:27 -0400
Message-ID: <20090407072327.GA5239@coredump.intra.peff.net>
References: <20090331185018.GD72569@macbook.lan> <20090331200457.GA23879@coredump.intra.peff.net> <20090331204338.GA88381@macbook.lan> <20090401102610.GC26181@coredump.intra.peff.net> <20090401175153.GA90421@macbook.lan> <7veiw69p26.fsf@gitster.siamese.dyndns.org> <49D9E040.40007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Andreas Ericsson <exon@op5.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:25:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5gF-00071j-EX
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbZDGHXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbZDGHXk
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:23:40 -0400
Received: from peff.net ([208.65.91.99]:45698 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbZDGHXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:23:39 -0400
Received: (qmail 541 invoked by uid 107); 7 Apr 2009 07:23:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 03:23:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 03:23:27 -0400
Content-Disposition: inline
In-Reply-To: <49D9E040.40007@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115915>

On Mon, Apr 06, 2009 at 12:58:08PM +0200, Andreas Ericsson wrote:

> How about:
> "Some projects (notably the Linux kernel and git itself) put special
> meaning in a 'Signed-off-by' line while other's dont. Please refer
> to your project's documentation for appropriate behaviour."

I think that is fine, with some typo fixups:

  s/other's/others/
  s/dont/don't/

And of course being American, I would spell it behavior. :)

> Optionally with the following amendment:
>
> "In general, you should refrain from signing off on a patch containing
> material that you're not sure can be legally spread under the project's
> license."

I don't think that makes sense. That is what signing-off is about for
the kernel and for git, but I don't think there is any reason another
project might not want to use the convenient signoff options to mean
something totally unrelated (like we use Acked-by).

-Peff
