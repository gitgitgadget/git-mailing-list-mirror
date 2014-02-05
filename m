From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Teach diff_tree_sha1() to accept NULL sha1 for empty
 trees
Date: Wed, 5 Feb 2014 12:25:40 -0500
Message-ID: <20140205172540.GB7268@sigill.intra.peff.net>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Wed Feb 05 18:25:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6EM-0006R8-FK
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbaBERZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:25:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:45109 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753043AbaBERZm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:25:42 -0500
Received: (qmail 6171 invoked by uid 102); 5 Feb 2014 17:25:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:25:41 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:25:40 -0500
Content-Disposition: inline
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241614>

On Wed, Feb 05, 2014 at 08:57:08PM +0400, Kirill Smelkov wrote:

> Kirill Smelkov (4):
>   tree-diff: allow diff_tree_sha1 to accept NULL sha1
>   tree-diff: convert diff_root_tree_sha1() to just call diff_tree_sha1
>     with old=NULL
>   line-log: convert to using diff_tree_sha1()
>   revision: convert to using diff_tree_sha1()
> 
>  line-log.c  | 26 ++------------------------
>  revision.c  | 12 +-----------
>  tree-diff.c | 27 +++++----------------------
>  3 files changed, 8 insertions(+), 57 deletions(-)

Yay, I like the diffstat. All of the patches look good to me.

-Peff
