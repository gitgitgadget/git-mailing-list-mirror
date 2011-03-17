From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] commit, status: #comment diff output in verbose mode
Date: Thu, 17 Mar 2011 15:41:22 -0400
Message-ID: <20110317194122.GE20508@sigill.intra.peff.net>
References: <1299787140-21472-1-git-send-email-icomfort@stanford.edu>
 <20110310225233.GH15828@sigill.intra.peff.net>
 <7vvczq1o4l.fsf@alter.siamese.dyndns.org>
 <20110311012318.GB15377@sigill.intra.peff.net>
 <20110311053107.GB16605@sigill.intra.peff.net>
 <4D79E21A.3040007@drmicha.warpmail.net>
 <20110317073719.GJ11931@sigill.intra.peff.net>
 <4D81BFDD.7050009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ian Ward Comfort <icomfort@stanford.edu>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:41:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0J4e-0001MM-3z
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393Ab1CQTl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:41:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54858
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970Ab1CQTl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:41:26 -0400
Received: (qmail 26651 invoked by uid 107); 17 Mar 2011 19:41:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 15:41:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 15:41:22 -0400
Content-Disposition: inline
In-Reply-To: <4D81BFDD.7050009@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169263>

On Thu, Mar 17, 2011 at 09:01:33AM +0100, Michael J Gruber wrote:

> > Yuck. You may be literally feeding different charsets into a single
> > buffer of the editor. The best you could do is something like:
> > 
> >   au BufNewFile,BufRead COMMIT_EDITMSG set fenc=utf-8
>
> [...]
>
> Though I'm wondering whether we should do something about it in general
> (we assume utf8 commit messages, don't we), at least in doc. Your
> suggestion above does make things safer (so that you don't screw up the
> commit message accidentally) and would make a good patch to vim's
> filetype.vim

Being perfectly content with ASCII for my native language, I am not a
good person to judge. But I wonder how common your situation is. That
is, your files are all in latin1, but you continue to use utf8 for your
commit messages. Perhaps an easier solution would just be to tell git
that you want to make commit messages in latin1?

-Peff
