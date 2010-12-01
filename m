From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add: introduce add.ignoreerrors synonym for
 add.ignore-errors
Date: Wed, 1 Dec 2010 13:46:59 -0500
Message-ID: <20101201184659.GA9147@sigill.intra.peff.net>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
 <20101201160503.GB26120@burratino>
 <m3aakp4g5o.fsf@localhost.localdomain>
 <20101201163406.GD26120@burratino>
 <20101201175517.GA7774@sigill.intra.peff.net>
 <20101201183615.GA27024@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 19:47:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrht-0005Md-4A
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183Ab0LASrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:47:03 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54485 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756095Ab0LASrB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:47:01 -0500
Received: (qmail 6469 invoked by uid 111); 1 Dec 2010 18:47:00 -0000
Received: from 129-79-255-226.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.226)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 01 Dec 2010 18:47:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Dec 2010 13:46:59 -0500
Content-Disposition: inline
In-Reply-To: <20101201183615.GA27024@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162570>

On Wed, Dec 01, 2010 at 12:36:15PM -0600, Jonathan Nieder wrote:

> It was a bad idea, so let's do the simple thing.  Like this?
> 
>  Documentation/config.txt |    1 +
>  builtin/add.c            |    3 ++-

Yes, looks good to me. You could potentially drop the old one from the
config:

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -553,6 +553,7 @@ core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>  	linkgit:git-read-tree[1] for more information.
>  
> +add.ignoreErrors::
>  add.ignore-errors::
>  	Tells 'git add' to continue adding files when some files cannot be
>  	added due to indexing errors. Equivalent to the '--ignore-errors'

which may be less confusing to new users (who might ask "is there a
difference between the two?").

But I don't have a strong feeling on it, so either way:

Acked-by: Jeff King <peff@peff.net>

-Peff
