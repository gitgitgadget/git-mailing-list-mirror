From: Jeff King <peff@peff.net>
Subject: Re: Is there any efficient way to track history of a piece of code?
Date: Thu, 8 May 2014 03:00:51 -0400
Message-ID: <20140508070051.GA4532@sigill.intra.peff.net>
References: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jianyu Zhan <nasa4836@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 09:01:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiIKB-0007N2-Et
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 09:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbaEHHAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 03:00:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:47263 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751513AbaEHHAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 03:00:54 -0400
Received: (qmail 18015 invoked by uid 102); 8 May 2014 07:00:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 May 2014 02:00:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2014 03:00:51 -0400
Content-Disposition: inline
In-Reply-To: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248409>

On Thu, May 08, 2014 at 02:54:56PM +0800, Jianyu Zhan wrote:

> Usually, a trivial change(like coding style fix) may bury a
> original change of the code, and thus git blame is of less
> help. And to address this situation, I have to do like this:
> 
>    git blame -s REF^ <file-in-question> > temp
> 
> to dig into the history recursively by hand, to find out
> the original change.
> 
> Here, REF is commit-id that git blame reports.
> 
> git log -L is a good alternative option, but sometimes it seems
> too cubersome, as I care only one line of code.
> 
> Is there any current solution or suggestion?

Try "tig blame"[1]; from the blame view, the "," command will restart
the blame at REF^ automatically.  If you don't mind a more graphical
interface, I think "git gui blame" can also reblame from the parent from
the right-click context menu.

-Peff

[1] http://jonas.nitro.dk/tig/
