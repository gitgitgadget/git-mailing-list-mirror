From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2008, #04; Sat, 18)
Date: Sun, 19 Oct 2008 08:01:24 -0400
Message-ID: <20081019120124.GA1457@coredump.intra.peff.net>
References: <7viqrpabep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 07:43:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrX0y-0001Vz-ST
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 14:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbYJSMB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 08:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbYJSMB1
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 08:01:27 -0400
Received: from peff.net ([208.65.91.99]:2488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbYJSMB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 08:01:26 -0400
Received: (qmail 7168 invoked by uid 111); 19 Oct 2008 12:01:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 19 Oct 2008 08:01:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Oct 2008 08:01:24 -0400
Content-Disposition: inline
In-Reply-To: <7viqrpabep.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98616>

On Sat, Oct 18, 2008 at 01:36:14PM -0700, Junio C Hamano wrote:

> ----------------------------------------------------------------
> [Actively Cooking]
[...]
> * jk/diff-convfilter (Sun Oct 5 17:43:45 2008 -0400) 4 commits
>  + diff: add filter for converting binary to text
>  + diff: introduce diff.<driver>.binary
>  + diff: unify external diff and funcname parsing code
>  + t4012: use test_cmp instead of cmp
> 
> A general cleanup on how diff drivers are implemented.  Its still
> missing documentation updates and tests but doesn't break anything
> current as far as I can tell.

Hmm, I was planning on re-rolling this before it hit next to deal with
the issues brought up about the binary option, but I guess it is too
late now (yes, I was being slow about it...). I think I can salvage it
with some patches on top, though.

-Peff
