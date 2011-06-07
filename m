From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] t5800: document some non-functional parts of remote
 helpers
Date: Tue, 7 Jun 2011 13:55:21 -0400
Message-ID: <20110607175520.GC23465@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
 <20110607172030.GC22111@sigill.intra.peff.net>
 <BANLkTinx0F7nfpmqx7AWChab3g-4MNnswQ@mail.gmail.com>
 <20110607172832.GA23224@sigill.intra.peff.net>
 <BANLkTimAngV2BxODJ6gCn4zGh7+p+MnhZQ@mail.gmail.com>
 <20110607175110.GB22216@sigill.intra.peff.net>
 <BANLkTimWZ03FWaZ=Oit2gWSOeUF66cbEkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:55:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0Uz-0007tp-Cb
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846Ab1FGRzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:55:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49837
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab1FGRzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:55:24 -0400
Received: (qmail 18500 invoked by uid 107); 7 Jun 2011 17:55:31 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:55:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:55:21 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimWZ03FWaZ=Oit2gWSOeUF66cbEkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175242>

On Tue, Jun 07, 2011 at 07:53:01PM +0200, Sverre Rabbelier wrote:

> On Tue, Jun 7, 2011 at 19:51, Jeff King <peff@peff.net> wrote:
> > Thanks. I'm not sure of some details, though. In particular, we also use
> > the staging area during push to know which parts of the history we
> > _don't_ have to send. So where will the remote helper store that state
> > if not in this staging repo?
> 
> Oh, I didn't mean the staging _repo_. I meant the refs/testgit namespace.

Oh. :) Then yeah, I think that would be more elegant.

-Peff
