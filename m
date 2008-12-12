From: Jeff King <peff@peff.net>
Subject: Re: git-doc CSS dependent, breaks down in text browsers
Date: Thu, 11 Dec 2008 22:33:48 -0500
Message-ID: <20081212033348.GA29663@coredump.intra.peff.net>
References: <87ej0qf3gx.fsf@jidanni.org> <87wse6zc9x.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, 507475@bugs.debian.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 12 04:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAyo4-0006g7-9O
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 04:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782AbYLLDdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 22:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755654AbYLLDdw
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 22:33:52 -0500
Received: from peff.net ([208.65.91.99]:4997 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755566AbYLLDdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 22:33:51 -0500
Received: (qmail 32141 invoked by uid 111); 12 Dec 2008 03:33:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 11 Dec 2008 22:33:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Dec 2008 22:33:48 -0500
Content-Disposition: inline
In-Reply-To: <87wse6zc9x.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102885>

On Fri, Dec 12, 2008 at 04:29:14AM +0800, jidanni@jidanni.org wrote:

> E.g., pages look like
> 
> SYNOPSIS
> 
> git-config [<file-option>] [type] [-z|--null] name [value [value_regex]] git-config [<file-option>] [type] --add name
> value git-config [<file-option>] [type] --replace-all name [value [value_regex]] git-config [<file-option>] [type] [-z|
> --null] --get name [value_regex] git-config [<file-option>] [type] [-z|--null] --get-all name [value_regex] git-config...

I think this is another asciidoc issue, as git merely specifies "verse"
format for this section. Probably the most friendly thing to do would be
to use

  <pre class="verseblock-content">

instead of

  <div class="verseblock-content">

so that non-CSS browsers fall back to preserving the line boundaries
(which is what is making it look so unbearable in your text browser).
But it is definitely something to be fixed in asciidoc, not in the git
documentation.

-Peff
