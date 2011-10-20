From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 00:15:03 -0400
Message-ID: <CAGZ=bqK2oVPxW3mm-WHMd1+KSiPquympJyhRqLWr1F=G74p+BA@mail.gmail.com>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net> <20111019193834.GA14168@sigill.intra.peff.net>
 <20111020025149.GA31549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 06:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGk2T-00021P-5u
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 06:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771Ab1JTEPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 00:15:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59117 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab1JTEPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 00:15:24 -0400
Received: by ywf7 with SMTP id 7so2399544ywf.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 21:15:23 -0700 (PDT)
Received: by 10.68.32.2 with SMTP id e2mr17505121pbi.68.1319084123094; Wed, 19
 Oct 2011 21:15:23 -0700 (PDT)
Received: by 10.142.77.10 with HTTP; Wed, 19 Oct 2011 21:15:03 -0700 (PDT)
In-Reply-To: <20111020025149.GA31549@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184000>

On Wed, Oct 19, 2011 at 22:51, Jeff King <peff@peff.net> wrote:
> Keep in mind that each hex character you add increases the search space
> by a factor of 16. deadbeef took about 70 seconds to find on my machine.
> I'm tempted to look for "3133700..0031337", but it would probably
> take about 4 hours.

Heh, there's one other practical downside I can think of...

If you create a bunch of commits with the same 8-hex-character prefix
then suddenly the "git describe" logic for using the first 7 commit ID
characters gets a whole lot less useful.

Cheers,
Kyle Moffett

-- 
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
