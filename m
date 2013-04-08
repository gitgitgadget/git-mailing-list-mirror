From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] transport-helper: report errors properly
Date: Mon, 8 Apr 2013 15:30:43 -0400
Message-ID: <20130408193043.GD7337@sigill.intra.peff.net>
References: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
 <CAGdFq_h9o+oMriF52Bh2e60eJfLM7F9GTbwcSE1mD3Leyt76Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:30:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHmH-0002GF-2S
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935588Ab3DHTas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:30:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34172 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935467Ab3DHTar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:30:47 -0400
Received: (qmail 14381 invoked by uid 107); 8 Apr 2013 19:32:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 15:32:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 15:30:43 -0400
Content-Disposition: inline
In-Reply-To: <CAGdFq_h9o+oMriF52Bh2e60eJfLM7F9GTbwcSE1mD3Leyt76Yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220501>

On Mon, Apr 08, 2013 at 11:20:15AM -0700, Sverre Rabbelier wrote:

> On Mon, Apr 8, 2013 at 7:40 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > +               die("Reading from remote helper failed");
> 
> Does the user know what a remote helper is? Could we point them at
> some helpful docs in case they don't?

That's a good point. I wonder if it would be enough to say:

  fatal: Reading from helper git-remote-X failed

That might make it more clear what the helper's role is, and showing the
command name gives the user a starting point for running "man".

-Peff
