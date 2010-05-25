From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Tue, 25 May 2010 03:22:41 -0400
Message-ID: <20100525072240.GA20408@coredump.intra.peff.net>
References: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com>
 <20100505050640.GC8779@coredump.intra.peff.net>
 <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com>
 <20100512133537.GA28956@coredump.intra.peff.net>
 <AANLkTilkFHK1UIvSLEstXFIOJTsit02EZe1Wsoj_zRRX@mail.gmail.com>
 <20100523092348.GA16811@coredump.intra.peff.net>
 <4BFB79F6.5070501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Knittl <knittl89@googlemail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 25 09:23:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGoTd-0005Vd-Dd
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099Ab0EYHWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 03:22:53 -0400
Received: from peff.net ([208.65.91.99]:35740 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab0EYHWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 03:22:45 -0400
Received: (qmail 16461 invoked by uid 107); 25 May 2010 07:22:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 03:22:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 03:22:41 -0400
Content-Disposition: inline
In-Reply-To: <4BFB79F6.5070501@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147675>

On Tue, May 25, 2010 at 09:19:18AM +0200, Michael J Gruber wrote:

> I'm really wondering what the problem is with git-send-email + GMail's
> smtp. I'm not saying there is none: I'm just observing that we seem to
> attract a lot of new contributors lately and that the email-inline-patch
> requirement seems to be a hurdle to quite a few. I've created a mob
> branch at

I don't use gmail, but my impression was that the problem is one of:

  1. pushing to gmail's drafts folder via imap, and then using the web
     interface to send the email

  2. cutting and pasting into the web interface

I would hope that sending directly via SMTP with git-send-email would
not get munged. That is pretty broken otherwise.

-Peff
