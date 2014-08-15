From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [ANNOUNCE] Git v2.1.0
Date: Fri, 15 Aug 2014 19:18:22 -0400
Message-ID: <20140815231822.GM10808@thunk.org>
References: <xmqqd2c1z7zu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 01:18:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIQlX-0000fr-UH
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 01:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaHOXS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 19:18:27 -0400
Received: from imap.thunk.org ([74.207.234.97]:34310 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbaHOXS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 19:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=t0GpxOm1TRaqmP5l20n/T//Abvp+pYJvxmDwAtHTyR0=;
	b=HJ10APB+eMtxyxcDwiyc/wEWn5rd9r9Gmh7TfA1sDFg6E27OfyiI0IziBZTmUqT7nQWW6eeLX52MN8tW4UZPB7IrwNteUN5rjn8IFUwd8rHzFgirrQEx37b2oT+CM+p656ts7dYVN8w9DYc2OxmHohVbcm/XoM7e76+cT0s5sI4=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1XIQlL-0004f0-76; Fri, 15 Aug 2014 23:18:23 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 3C0A05843C8; Fri, 15 Aug 2014 19:18:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqd2c1z7zu.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255309>

On Fri, Aug 15, 2014 at 03:46:29PM -0700, Junio C Hamano wrote:
> The latest feature release Git v2.1.0 is now available at the
> usual places.

I pulled down git v2.1.0, and when I tried to build it via:

   make prefix=/usr/local profile-fast

The build died with this:

cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 77.
Makefile:7: recipe for target 'perf' failed
make[2]: *** [perf] Error 2
make[2]: Leaving directory '/usr/projects/git/git/t/perf'

Not a big deal, but I thought I would mention it.

Cheers,

					- Ted
