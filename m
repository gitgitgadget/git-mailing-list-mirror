From: Stephen Bash <bash@genarts.com>
Subject: Re: git version statistics
Date: Thu, 31 May 2012 11:20:46 -0400 (EDT)
Message-ID: <981b755b-ca86-4320-a4fc-8aa28caa099d@mail>
References: <20120531114801.GA21367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 17:21:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa7BU-0003dO-Oh
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 17:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458Ab2EaPU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 11:20:58 -0400
Received: from hq.genarts.com ([173.9.65.1]:35092 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932327Ab2EaPU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 11:20:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 41A49BE2701;
	Thu, 31 May 2012 11:20:55 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vlVzIKX2BAXz; Thu, 31 May 2012 11:20:46 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id DCB01BE26FF;
	Thu, 31 May 2012 11:20:46 -0400 (EDT)
In-Reply-To: <20120531114801.GA21367@sigill.intra.peff.net>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC19 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198921>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> Sent: Thursday, May 31, 2012 7:48:02 AM
> Subject: git version statistics
> 
> Just for fun, I've assembled a few statistics on git client versions
> that hit github.com.

Certainly an interesting read...  Thanks!

> The interesting thing to me is how spiky it is, and where the spikes
> fall. I would expect to see a spike around the highest maint release
> of each major version (so v1.7.8.6, for example, with many fewer
> installs of v1.7.8.5, v1.7.8.4, and so forth). But that's not what
> happens.  The most popular v1.7.8.x versions are .3 and .2, and hardly
> anybody bothered to move to v1.7.8.6.

I wonder if the spikes correlate with time between releases?  For open source projects I tend to download the most recent when setting up a new machine (or after encountering a nasty bug), and then not upgrade for a while.  So in that mode of operation, releases that are "the newest" for the longest would get more users... (though at least on my Mac the homebrew project is helping me break the habit and stay more up-to-date)
 
> I can only assume these are skewed by some widely-used binary
> distribution being locked onto particular versions (e.g., the spike at
> v1.7.2.5 represents Debian stable).

... but then again, that's probably a better reason for large swaths of users to have a fixed version...

Thanks again for the interesting read.

Stephen
