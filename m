From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/12] git-clone: support --path to do sparse clone
Date: Thu, 24 Jul 2008 13:19:52 -0400
Message-ID: <20080724171952.GB21043@sigill.intra.peff.net>
References: <20080723145718.GA29134@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:21:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM4Up-0000t0-Q2
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYGXRTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbYGXRTz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:19:55 -0400
Received: from peff.net ([208.65.91.99]:4568 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbYGXRTy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:19:54 -0400
Received: (qmail 26303 invoked by uid 111); 24 Jul 2008 17:19:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 24 Jul 2008 13:19:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2008 13:19:52 -0400
Content-Disposition: inline
In-Reply-To: <20080723145718.GA29134@laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89918>

On Wed, Jul 23, 2008 at 09:57:18PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> +		if (option_sparse_prefix) {
> +			git_config_set("core.sparsecheckout", option_sparse_prefix);
> +			set_sparse_prefix(option_sparse_prefix);
> +		}
> +

As a user, I would expect "sparse clone" to also be sparse on the
fetching. That is, to not even bother fetching tree objects that we are
not going to check out. But that is a whole other can of worms from
local sparseness, so I think it is worth saving for a different series.

So instead I would suggest that this be mentioned in the documentation
for --path, but there doesn't seem to be any.

-Peff
