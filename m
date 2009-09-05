From: Jeff King <peff@peff.net>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 5 Sep 2009 04:19:16 -0400
Message-ID: <20090905081915.GA11392@coredump.intra.peff.net>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905072017.GA5152@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:19:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjqUb-0003v8-L4
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171AbZIEITT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757055AbZIEITS
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:19:18 -0400
Received: from peff.net ([208.65.91.99]:60866 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbZIEITQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:19:16 -0400
Received: (qmail 25775 invoked by uid 107); 5 Sep 2009 08:19:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 04:19:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:19:16 -0400
Content-Disposition: inline
In-Reply-To: <20090905072017.GA5152@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127793>

On Sat, Sep 05, 2009 at 03:20:17AM -0400, Jeff King wrote:

> As I mentioned above, not only is that annoying to use, but the real
> problem is that I _expect_ the other behavior and it silently does the
> opposite of what I want. You can argue that my brain is defective (for
> not remembering, I mean -- we _know_ it's defective in other ways), but
> certainly a config option would be useful to me.

Bah. Even after this long thread, I _still_ forgot. I just now typed
"git add -u" from t/ and got annoyed that my changes in the root weren't
added.

-Peff
