From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: Teach "--edit" action
Date: Mon, 10 Sep 2012 14:46:25 -0400
Message-ID: <20120910184625.GA32237@sigill.intra.peff.net>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
 <1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com>
 <vpqk3w1j15v.fsf@bauges.imag.fr>
 <CADgNja=z7EDTV8_2CU9Uc7w=Dmtp90GrPkDUFSPbucfyrEsBaQ@mail.gmail.com>
 <20120910165457.GB14201@sigill.intra.peff.net>
 <504E333B.2010602@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Sep 10 20:46:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB90H-0000yQ-2J
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 20:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab2IJSq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 14:46:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39890 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab2IJSq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 14:46:28 -0400
Received: (qmail 31653 invoked by uid 107); 10 Sep 2012 18:46:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 14:46:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 14:46:25 -0400
Content-Disposition: inline
In-Reply-To: <504E333B.2010602@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205161>

On Mon, Sep 10, 2012 at 08:36:43PM +0200, Johannes Sixt wrote:

> > [1] It does preclude using "--edit" to make a note about a later commit
> >     while you are in the middle of resolving a conflict or something.
> >     You'd have to do it at the end. I don't know if anybody actually
> >     cares about that.
> 
> Yes, I do care. At times I tend to have a very short attention span. Or
> it is Windows's slowness that expires my short-term memory more often
> than not. ;)

OK, then I withdraw my proposal. :)

It sounds like it would be safe to do:

  git rebase --edit-todo
  hack hack hack
  git rebase --continue

anyway, so the restriction is not as valuable as it would otherwise have
been.

-Peff
