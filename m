From: Bruce Momjian <bruce@momjian.us>
Subject: Re: test -L usage
Date: Tue, 21 Sep 2010 20:37:30 -0400 (EDT)
Message-ID: <201009220037.o8M0bUT29845@momjian.us>
References: <20100922003559.GB23931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 22 02:37:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyDL5-0003Ew-Pa
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 02:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578Ab0IVAhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 20:37:31 -0400
Received: from momjian.us ([70.90.9.53]:57497 "EHLO momjian.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754961Ab0IVAha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 20:37:30 -0400
Received: (from bruce@localhost)
	by momjian.us (8.11.6/8.11.6) id o8M0bUT29845;
	Tue, 21 Sep 2010 20:37:30 -0400 (EDT)
In-Reply-To: <20100922003559.GB23931@sigill.intra.peff.net>
X-Mailer: ELM [version 2.4ME+ PL124 (25)]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156777>

Jeff King wrote:
> On Tue, Sep 21, 2010 at 08:11:15PM -0400, Bruce Momjian wrote:
> 
> > git-1.7.3/contrib/workdir/git-new-workdir uses 'test -L' to test for
> > symlinks.  I suggest using 'test -h' because it is more portable, and
> > would have avoided a problem on my BSD machine.
> 
> Yeah, we generally do, but the stuff in contrib/ doesn't get exercised
> as much. There are also a few occurences in the svn tests. All cleaned
> up with the patch below.

Thanks.

-- 
  Bruce Momjian  <bruce@momjian.us>        http://momjian.us
  EnterpriseDB                             http://enterprisedb.com

  + It's impossible for everything to be true. +
