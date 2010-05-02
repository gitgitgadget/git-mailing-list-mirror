From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/5] pretty: add aliases for pretty formats
Date: Sun, 2 May 2010 00:47:26 -0400
Message-ID: <20100502044726.GB14776@coredump.intra.peff.net>
References: <7vaasjyozt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, raa.lkml@gmail.com, jrnieder@gmail.com
To: Will Palmer <wmpalmer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 06:47:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8R5a-0001Fh-JW
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 06:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab0EBEr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 00:47:28 -0400
Received: from peff.net ([208.65.91.99]:48975 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab0EBEr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 00:47:27 -0400
Received: (qmail 3561 invoked by uid 107); 2 May 2010 04:47:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 02 May 2010 00:47:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 May 2010 00:47:26 -0400
Content-Disposition: inline
In-Reply-To: <7vaasjyozt.fsf@alter.siamese.dyndns.org>
 <1272656128-2002-6-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146132>

On Sat, May 01, 2010 at 08:13:58PM -0700, Junio C Hamano wrote:

> I didn't follow the config namespace discussions, though.  Is everybody
> happy with the naming used in this patch?

Yes, I am happy with pretty.*. But:

On Fri, Apr 30, 2010 at 08:35:28PM +0100, Will Palmer wrote:

> +pretty.<name>::
> +	Alias for a --pretty= format string, as specified in
> +	linkgit:git-log[1]. Any aliases defined here can be used just
> +	as the built-in pretty formats could. For example, defining
> +	"format.pretty.hash = format:%H" would cause the invocation
> +	"git log --pretty=hash" to be equivalent to running
> +	"git log --pretty=format:%H". Note that an alias with the same
> +	name as a built-in format will be silently ignored.

The descriptive text mentions the old "format.pretty.hash".

-Peff
