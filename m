From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 9 May 2014 10:54:53 -0400
Message-ID: <20140509145453.GA18197@sigill.intra.peff.net>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
 <536c7f9089b77_182dd0d31084@nysa.notmuch>
 <20140509081507.GA26494@dcvr.yhbt.net>
 <536c939781d8b_2bf0e952f08@nysa.notmuch>
 <20140509085937.GA29347@dcvr.yhbt.net>
 <536c9de8f07ae_39ea14ab310f9@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 16:55:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WimCV-0008Aa-OG
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 16:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983AbaEIOy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 10:54:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:48267 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756952AbaEIOy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 10:54:57 -0400
Received: (qmail 24838 invoked by uid 102); 9 May 2014 14:54:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 May 2014 09:54:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2014 10:54:53 -0400
Content-Disposition: inline
In-Reply-To: <536c9de8f07ae_39ea14ab310f9@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248563>

On Fri, May 09, 2014 at 04:20:40AM -0500, Felipe Contreras wrote:

> Eric Wong wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > > As a minimal token that anybody might possibly be using it, I would like
> > > to see it work at least once. Since you said you have arch repos, can
> > > you confirm that it does something?
> > 
> > Those repos are in offline/offsite storage and I do not have time to
> > retrieve them.
> 
> Then we have no reason to believe they still work, and therefore, no
> reason to believe anybody is using this.

Do you have any reason to believe they do NOT work? If not, and they are
not causing any problems, then what is the benefit to getting rid of
them?

> > I've forgotten how to use tla to get a public repo, even.

I haven't used tla in quite a long time, but:

  tla register-archive http://www.atai.org/archarchives/atai@atai.org--public/
  tla my-default-archive atai@atai.org--public
  mkdir repo
  cd repo
  git archimport atai@atai.org--public

seemed to work (that archive is straight off the tla homepage's
instructions). Looks like the commit messages could use some cleanup,
but certainly it's better than nothing.

-Peff
