From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Document ls-files -t as semi-obsolete.
Date: Tue, 27 Jul 2010 17:06:38 -0400
Message-ID: <20100727210638.GA12052@coredump.intra.peff.net>
References: <1280162391-18701-1-git-send-email-Matthieu.Moy@imag.fr>
 <20100727195832.GA11717@coredump.intra.peff.net>
 <vpqeieoy9bb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrMN-0004oz-13
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab0G0VGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:06:42 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52989 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470Ab0G0VGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:06:41 -0400
Received: (qmail 18111 invoked by uid 111); 27 Jul 2010 21:06:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 27 Jul 2010 21:06:40 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jul 2010 17:06:38 -0400
Content-Disposition: inline
In-Reply-To: <vpqeieoy9bb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151987>

On Tue, Jul 27, 2010 at 10:11:04PM +0200, Matthieu Moy wrote:

> > Isn't "git diff-files --name-status" the closest plumbing analogue? Git
> > status actually does a lot of extra work.
> 
> git diff-files --name-status won't show untracked files, while "git
> ls-files -t -o" will for example. I agree that "git status" does extra
> work, but that's what you usually want when you want to know the
> status of files. We already mention "git diff --name-status", so
> people looking for "git diff-tree --name-status" should be able to
> find it.

Good point. I was thinking of "ls-files -t" by itself, but you are
likely to ask for other things anyway.

> > Shouldn't one of them be marked "C"hanged (I think file2, but that was
> > what I was double-checking)?
> 
> You should ask "git ls-files -t -m" if you want to see modified files.

OK, that makes sense, I guess.

> I'm afraid we have another proof that we should discourage the use of
> this feature ;-).

I think we all agree on that bit. :)

-Peff
