From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git/spearce.git (Oct 2008, #01; Mon, 06)
Date: Mon, 6 Oct 2008 17:03:03 -0400
Message-ID: <20081006210303.GA30812@coredump.intra.peff.net>
References: <20081006165943.GG8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 23:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmxFc-0001Wk-Sf
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 23:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbYJFVDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 17:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbYJFVDI
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 17:03:08 -0400
Received: from peff.net ([208.65.91.99]:2405 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbYJFVDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 17:03:07 -0400
Received: (qmail 25304 invoked by uid 111); 6 Oct 2008 21:03:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 06 Oct 2008 17:03:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Oct 2008 17:03:03 -0400
Content-Disposition: inline
In-Reply-To: <20081006165943.GG8203@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97629>

On Mon, Oct 06, 2008 at 09:59:43AM -0700, Shawn O. Pearce wrote:

> * jk/diff-convfilter (Sun Oct 5 17:43:45 2008 -0400) 4 commits
>  - diff: add filter for converting binary to text
>  - diff: introduce diff.<driver>.binary
>  - diff: unify external diff and funcname parsing code
>  - t4012: use test_cmp instead of cmp
> 
> A general cleanup on how diff drivers are implemented.  Its still
> missing documentation updates and tests but doesn't break anything
> current as far as I can tell.  It needs more review before it can
> be slated for 'next'.

I should note, too, that this is in direct competition with Matthieu
Moy's "Implementation of a textconv filter for easy custom diff" posted
about a week ago. So if you are reviewing this series, please review
both and decide which you think is more sensible.

-Peff
