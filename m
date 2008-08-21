From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2008, #06; Wed, 20)
Date: Wed, 20 Aug 2008 21:18:11 -0400
Message-ID: <20080821011811.GA13915@coredump.intra.peff.net>
References: <7vabf7mcpz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 03:19:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVypc-0005Ob-0W
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 03:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbYHUBSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 21:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbYHUBSP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 21:18:15 -0400
Received: from peff.net ([208.65.91.99]:1547 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbYHUBSO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 21:18:14 -0400
Received: (qmail 31855 invoked by uid 111); 21 Aug 2008 01:18:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Aug 2008 21:18:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 21:18:11 -0400
Content-Disposition: inline
In-Reply-To: <7vabf7mcpz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93082>

On Wed, Aug 20, 2008 at 05:30:16PM -0700, Junio C Hamano wrote:

> * js/parallel-test (Mon Aug 18 12:25:40 2008 -0400) 4 commits
>  + Update t/.gitignore to ignore all trash directories
>  + Enable parallel tests
>  + tests: Clarify dependencies between tests, 'aggregate-results' and
>    'clean'
>  + t9700: remove useless check

I really liked this the first time I ran "make -j4 test". However, it
now cleans up the trash directory automagically after a successful run.
This bit me today when I added a test that should have failed but
accidentally passed. I wanted to look at the output, but it was gone.

Probably it's not worth worrying about, since that is certainly the less
common case, and I can work around it by editing the passing test script
to provoke failure. And I can't think of a more sane behavior. But I
wanted to register my slight "this new thing annoyed me" feeling.

-Peff
