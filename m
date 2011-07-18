From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/23] remote-helper improvements
Date: Sun, 17 Jul 2011 23:28:29 -0400
Message-ID: <20110718032829.GA2468@sigill.intra.peff.net>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 05:28:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QieVZ-0008D0-F1
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 05:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738Ab1GRD2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 23:28:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59831
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899Ab1GRD2b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 23:28:31 -0400
Received: (qmail 17559 invoked by uid 107); 18 Jul 2011 03:28:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Jul 2011 23:28:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jul 2011 23:28:29 -0400
Content-Disposition: inline
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177332>

On Sat, Jul 16, 2011 at 03:03:20PM +0200, Sverre Rabbelier wrote:

> Incorperated feedback from Junio, Johannes and Peff. I also included
> Dmitry's patch that adds GITDIR, which I modified to just remove the
> support for a gitdir command.

I read through these, and with the giant disclaimer that:

  1. The entirety of my remote helper knowledge is from working on the
     patches in this series that are mine.

  2. I don't really know anything about writing good-looking python
     code.

The patches up to 21 (i.e., not the RFD ones) all made sense to me. At
least, the goals from the commit messages looked sane, and the patches
seemed to implement the goals reasonably.

-Peff
