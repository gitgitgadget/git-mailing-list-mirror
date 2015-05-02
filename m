From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git commit --allow-empty-message -m '' fails
Date: Fri, 1 May 2015 22:29:24 -0400
Message-ID: <20150502022924.GA587@peff.net>
References: <CANuW5x0eKVAToG76rJr6+n-Fdg7E5c8mHb8NvnQUT2PBzxjjPQ@mail.gmail.com>
 <20150502010605.GA5634@peff.net>
 <CANuW5x1jeAY4KrOQez30mNp864abaYFyDDrdfM=NHCSosTSzkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Josh Hagins <hagins.josh@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 04:29:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoNBP-0002jZ-Id
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 04:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbbEBC31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 22:29:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:53186 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbbEBC31 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 22:29:27 -0400
Received: (qmail 6606 invoked by uid 102); 2 May 2015 02:29:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 21:29:27 -0500
Received: (qmail 3216 invoked by uid 107); 2 May 2015 02:29:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 22:29:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 22:29:24 -0400
Content-Disposition: inline
In-Reply-To: <CANuW5x1jeAY4KrOQez30mNp864abaYFyDDrdfM=NHCSosTSzkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268209>

On Sat, May 02, 2015 at 01:25:45AM +0000, Josh Hagins wrote:

> I have git aliased to hub, which must do some preprocessing before handing
> the command off to git.
> 
> That's likely the culprit, but I'm using iTerm as my terminal emulator,
> which might be doing something tricky, but I doubt it. I'll open an issue
> on hub's GitHub repo and see what I can find out.

Ah, yeah, it's probably hub. Looks like it's fixed already there:

  https://github.com/github/hub/pull/727

-Peff
