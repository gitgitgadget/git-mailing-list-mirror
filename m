From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/vim: simplify instructions for old vim support
Date: Thu, 10 Jan 2013 16:34:27 -0500
Message-ID: <20130110213427.GA26138@sigill.intra.peff.net>
References: <50EEA34B.7070102@gmail.com>
 <20130110113958.GA17137@sigill.intra.peff.net>
 <20130110205427.GG16532@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Manlio Perillo <manlio.perillo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtPlz-0001oz-5q
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 22:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab3AJVeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 16:34:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54315 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452Ab3AJVea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 16:34:30 -0500
Received: (qmail 12516 invoked by uid 107); 10 Jan 2013 21:35:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jan 2013 16:35:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2013 16:34:27 -0500
Content-Disposition: inline
In-Reply-To: <20130110205427.GG16532@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213153>

On Thu, Jan 10, 2013 at 12:54:27PM -0800, Jonathan Nieder wrote:

> Rely on the upstream filetype.vim instead of duplicating its rules in
> git's instructions for syntax highlighting support on pre-7.2 vim
> versions.
> 
> The result is a shorter contrib/vim/README.  More importantly, it lets
> us punt on maintenance of the autocmd rules.
> 
> So now when we fix the upstream gitsendemail rule in light of commit
> eed6ca7, new git users stuck on old vim reading contrib/vim/README can
> automagically get the fix without any further changes needed to git.
> 
> Once the world has moved on to vim 7.2+ completely, we can get rid of
> these instructions, but for now if they are this simple it's
> effortless to keep them.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jeff King wrote:
> 
> > I'd argue that we should just remove contrib/vim at this point. It has
> > no actual files in it, only pointers to vim.org for pre-7.2 vim users.
> 
> I think that's reasonable.  Of course we can still discuss enhancements
> to the vim support on this list, but ultimately it's easiest to
> distribute and document such work upstream in the usual way for vim
> plugins.
> 
> How about this patch?

Yeah, I think this makes sense. I'd be fine with removing it entirely,
but it doesn't hurt to err on the conservative side and leave it there.
It's not like it's generating a huge maintenance burden, and with your
patch, there is even less to maintain.

Acked-by: Jeff King <peff@peff.net>

-Peff
