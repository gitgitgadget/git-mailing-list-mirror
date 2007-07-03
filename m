From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [Quilt-dev] Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 18:03:15 +0200
Organization: SUSE Labs, Novell
Message-ID: <200707031803.15633.agruen@suse.de>
References: <20070702125450.28228edd.akpm@linux-foundation.org> <200707031534.47004.agruen@suse.de> <20070703084926.2e834aa5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: quilt-dev@nongnu.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 18:04:24 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5krX-0005wz-HP
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 18:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759613AbXGCQDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 12:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759635AbXGCQDx
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 12:03:53 -0400
Received: from ns.suse.de ([195.135.220.2]:52105 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755342AbXGCQDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 12:03:52 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id A46C212014;
	Tue,  3 Jul 2007 18:03:51 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070703084926.2e834aa5.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51512>

On Tuesday 03 July 2007 17:49, Andrew Morton wrote:
> I guess one could try `patch -p1' and if that failed, `patch -p1 -u'.

Hmm, I'll think about that, thanks.

> But the problem is that patch will get stuck in interactive mode prompting
> for a filename.  I've never actually worked how to make patch(1) just fail
> rather than going interactive, not that I've tried terribly hard.  Any
> hints there?

Patch -f will turn off those questions.

Andreas
