From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/13] New output style for git remote show
Date: Mon, 23 Feb 2009 01:59:34 -0500
Message-ID: <20090223065934.GD24517@coredump.intra.peff.net>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 08:01:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbUoL-0003rD-JI
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 08:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbZBWG7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbZBWG7g
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:59:36 -0500
Received: from peff.net ([208.65.91.99]:35748 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbZBWG7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:59:36 -0500
Received: (qmail 21105 invoked by uid 107); 23 Feb 2009 06:59:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Feb 2009 01:59:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2009 01:59:34 -0500
Content-Disposition: inline
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111109>

On Mon, Feb 23, 2009 at 01:28:48AM -0500, Jay Soffian wrote:

> Jay Soffian (13):
>   remote: rename variable and eliminate redundant function call
>   remote: remove unused code in get_ref_states
>   remote: fix two inconsistencies in the output of "show <remote>"
>   remote: make get_remote_ref_states() always populate states.tracked
>   remote: name remote_refs consistently
>   string-list: new for_each_string_list() function
>   remote: new show output style
>   refactor duplicated get_local_heads() to remote.c
>   refactor duplicated ref_newer() to remote.c
>   remote.c: make match_refs() copy src ref before assigning to peer_ref
>   remote.c: don't short-circuit match_refs() when error in
>     match_explicit_refs()
>   remote.c: refactor get_remote_ref_states()
>   remote: new show output style for push refspecs

I gave these a quick read (but not any extensive apply+build+experiment
cycle), and they all look good to me. I don't know when I'll have time
to try breaking them, though. ;)

Thank you for splitting them. It made reading a lot more pleasant.

-Peff
