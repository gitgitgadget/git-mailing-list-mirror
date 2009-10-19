From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git push: say that --tag can't be used with --all or
 --mirror in help text
Date: Mon, 19 Oct 2009 00:14:01 -0400
Message-ID: <20091019041401.GC7170@coredump.intra.peff.net>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
 <4ADB4AE8.5070007@hartwork.org>
 <20091018235240.GU6115@genesis.frugalware.org>
 <20091019115412.6117@nanako3.lavabit.com>
 <7vpr8kcc00.fsf@alter.siamese.dyndns.org>
 <20091019125701.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Sebastian Pipping <webmaster@hartwork.org>,
	git@vger.kernel.org, Bjorn Gustavsson <bgustavsson@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 06:14:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzjdK-0000qD-1D
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 06:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbZJSEN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 00:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbZJSEN7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 00:13:59 -0400
Received: from peff.net ([208.65.91.99]:34424 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbZJSEN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 00:13:59 -0400
Received: (qmail 14309 invoked by uid 107); 19 Oct 2009 04:17:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Oct 2009 00:17:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Oct 2009 00:14:01 -0400
Content-Disposition: inline
In-Reply-To: <20091019125701.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130647>

On Mon, Oct 19, 2009 at 12:57:01PM +0900, Nanako Shiraishi wrote:

> -		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
> +		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all nor --mirror"),

Grammar nit: I believe it should be "or" and not "nor".

There is an implicit "either", as in "can't be used with either --all or
--mirror". Saying "can't be used with neither --all nor --mirror" would
be a double-negative. The alternative correct single-negation would be
"can be used with neither --all nor --mirror".

-Peff
