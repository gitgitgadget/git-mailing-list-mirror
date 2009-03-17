From: Jeff King <peff@peff.net>
Subject: Re: git confusing a submodule & subdirectory?
Date: Tue, 17 Mar 2009 04:32:26 -0400
Message-ID: <20090317083225.GI18475@coredump.intra.peff.net>
References: <135FFBD1-83C2-4538-8311-A69A0D7D7016@talkhouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Juan Zanos <juan_zanos@talkhouse.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 09:34:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjUkP-0000XM-C4
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 09:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbZCQIcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 04:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755307AbZCQIce
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 04:32:34 -0400
Received: from peff.net ([208.65.91.99]:36862 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652AbZCQIce (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 04:32:34 -0400
Received: (qmail 2944 invoked by uid 107); 17 Mar 2009 08:32:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 04:32:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 04:32:26 -0400
Content-Disposition: inline
In-Reply-To: <135FFBD1-83C2-4538-8311-A69A0D7D7016@talkhouse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113439>

On Mon, Mar 16, 2009 at 02:39:11PM -0400, Juan Zanos wrote:

> Is it possible for git to confuse a submodule with a subdirectory?  When I 
> modify my submodule git seems to think the directory has changed.   A 
> commit isn't going to add all that content to the containing repository.  
> Is it?

It's possible that git is confusing them. There was a bug where
git-status with some configurations would show submodules as untracked
files. It was fixed by 98fa473 (refactor handling of "other" files in
ls-files and status, 2008-10-16), which is in v1.6.0.4. Depending on
your git version, you may be seeing that bug.

Otherwise, it's hard to say without more information. Can you show us
what commands you're running, what output you're seeing, and how it
differs from what you expect?

-Peff
