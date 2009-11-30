From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Update $GIT_DIR/remotes to $GIT_DIR/refs/remotes in
 docs
Date: Mon, 30 Nov 2009 00:03:33 -0500
Message-ID: <20091130050333.GA26585@coredump.intra.peff.net>
References: <1259552316-20088-1-git-send-email-ayiehere@gmail.com>
 <1259552316-20088-2-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: ayiehere@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 30 06:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEyQF-0008V8-MT
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 06:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbZK3FD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 00:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbZK3FD1
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 00:03:27 -0500
Received: from peff.net ([208.65.91.99]:33066 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbZK3FD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 00:03:27 -0500
Received: (qmail 9354 invoked by uid 107); 30 Nov 2009 05:07:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 30 Nov 2009 00:07:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Nov 2009 00:03:33 -0500
Content-Disposition: inline
In-Reply-To: <1259552316-20088-2-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134047>

On Mon, Nov 30, 2009 at 11:38:36AM +0800, ayiehere@gmail.com wrote:

>  DESCRIPTION
>  -----------
>  This script is included in various scripts to supply
> -routines to parse files under $GIT_DIR/remotes/ and
> +routines to parse files under $GIT_DIR/refs/remotes/ and
>  $GIT_DIR/branches/ and configuration variables that are related
>  to fetching, pulling and pushing.

Er, what? $GIT_DIR/remotes/ and $GIT_DIR/refs/remotes/ are not even
remotely the same thing. The former holds information about how to
contact remotes (but that information is usually held in the config file
these days).  The latter holds any tracking refs we have fetched from
the remotes.

-Peff
