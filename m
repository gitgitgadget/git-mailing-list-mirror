From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message
 configurable
Date: Mon, 7 Sep 2009 09:40:51 +0200
Message-ID: <20090907074051.GC1698@glandium.org>
References: <20090906064454.GA1643@coredump.intra.peff.net>
 <20090906064816.GC28941@coredump.intra.peff.net>
 <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
 <20090906072322.GA29949@coredump.intra.peff.net>
 <7vzl98fr22.fsf@alter.siamese.dyndns.org>
 <20090907094457.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, Git <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:00:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZ9h-000520-Gq
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbZIGIAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbZIGIAn
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:00:43 -0400
Received: from vuizook.err.no ([85.19.221.46]:60888 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbZIGIAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:00:43 -0400
X-Greylist: delayed 1181 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2009 04:00:42 EDT
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1MkYqG-0005cY-Pt; Mon, 07 Sep 2009 09:40:51 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1MkYqK-0000Rp-0B; Mon, 07 Sep 2009 09:40:52 +0200
Content-Disposition: inline
In-Reply-To: <20090907094457.6117@nanako3.lavabit.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127897>

On Mon, Sep 07, 2009 at 09:44:57AM +0900, Nanako Shiraishi wrote:
> Quoting Junio C Hamano <gitster@pobox.com>
> 
> > Speaking of which, has anybody felt annoyed by this message?
> >
> >     $ git reset --hard HEAD^^
> >     HEAD is now at 3fb9d58 Do not scramble password read from .cvspass
> >
> > This is not "maybe you should try this", but I would consider that it
> > falls into the same "I see you are trying to be helpful, but I know what I
> > am doing, and you are stealing screen real estate from me without helping
> > me at all, thank you very much" category.
> 
> You may be fixated at the sha1 part of the message when you find this message annoying, but I disagree strongly. I always appreciate the assurance this message gives me that I counted the number of commits correctly, whether I say HEAD^^^^ or HEAD~7.
> 
> Showing the subject of the commit you are now at is very useful and I will be equally irritated as you do if it starts showing the subject of the commit I was at.

I'd say both are equally interesting information.

Mike
