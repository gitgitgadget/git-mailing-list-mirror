From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Tue, 9 Apr 2013 12:27:36 -0400
Message-ID: <20130409162735.GA21972@sigill.intra.peff.net>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
 <1365416809-4396-1-git-send-email-artagnon@gmail.com>
 <20130408213006.GD9649@sigill.intra.peff.net>
 <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 18:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPbOf-0003wY-As
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 18:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936296Ab3DIQ1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 12:27:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36380 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936287Ab3DIQ1o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 12:27:44 -0400
Received: (qmail 23574 invoked by uid 107); 9 Apr 2013 16:29:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Apr 2013 12:29:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2013 12:27:36 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220581>

On Tue, Apr 09, 2013 at 02:49:24PM +0530, Ramkumar Ramachandra wrote:

> On the wording issue, a submodule is a submodule whether in-index or
> otherwise.  I would write two different tests: one for in-worktree
> submodule and another for in-index submodule, and name them
> appropriately.  Does that make sense?

Yeah, that makes perfect sense to me.

-Peff
