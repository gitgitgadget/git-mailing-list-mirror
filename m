From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Make git blame's date output format configurable,
	like git log
Date: Tue, 24 Feb 2009 00:00:28 -0500
Message-ID: <20090224050028.GB4615@coredump.intra.peff.net>
References: <1235170271-10694-1-git-send-email-eletuchy@gmail.com> <20090222230358.GA19011@coredump.intra.peff.net> <fbb390660902230109k15ed55b7le2ab08bb7dc274b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Eugene Letuchy <eugene@facebook.com>
To: Eugene Letuchy <eletuchy@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbpQc-0004Cw-MC
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 06:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbZBXFAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 00:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbZBXFAb
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 00:00:31 -0500
Received: from peff.net ([208.65.91.99]:58449 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbZBXFAb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 00:00:31 -0500
Received: (qmail 11104 invoked by uid 107); 24 Feb 2009 05:00:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Feb 2009 00:00:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2009 00:00:28 -0500
Content-Disposition: inline
In-Reply-To: <fbb390660902230109k15ed55b7le2ab08bb7dc274b6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111208>

On Mon, Feb 23, 2009 at 01:09:13AM -0800, Eugene Letuchy wrote:

> > Maybe this should be a date_format_width() library function?
> 
> I think that's a possible change, but unfortunately my next two
> patches would not apply cleanly with a date_format_width change.
> 
> I'm a n00b with respect to git contribution, but is there a procedure
> for pushing my blame_date branch remotely so that it's possible to
> track a series of patches?

Updating previous work depends on whether it has been picked up in
'next' by Junio; once patches are there, they cannot be rewritten. In
that case, you can send a follow-up patch.

In your case, though, the patch is still in 'pu', so you can repost. So
I think it makes sense to use "rebase -i" (or the tool of your choice)
to make a cleaned up series, and then repost the whole thing as a
series.

-Peff
