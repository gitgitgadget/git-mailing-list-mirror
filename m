From: Eric Raible <raible@nextest.com>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Thu, 10 Nov 2011 10:18:39 -0800
Message-ID: <4EBC157F.7040601@nextest.com>
References: <4EB9C7D1.30201@nextest.com> <20111109220128.GA31535@sigill.intra.peff.net> <20111109222032.GB31535@sigill.intra.peff.net> <4EBB8596.6040507@nextest.com> <20111110080851.GA28342@sigill.intra.peff.net> <buok4785j8v.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 19:19:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROZDL-0000jn-7j
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 19:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab1KJSSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 13:18:42 -0500
Received: from mail.nextest.com ([12.96.234.114]:57066 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753687Ab1KJSSl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2011 13:18:41 -0500
Received: from [131.101.151.102] (131.101.151.102) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Thu, 10 Nov 2011 10:18:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <buok4785j8v.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185243>

On 11/10/2011 3:06 AM, Miles Bader wrote:
> I think there's already confusion in this area, e.g., with @{...} using
> reflog dates, but "git log --since" using commit dates.  This can be an
> easy trap to fall into because _often_ the two have similar granularity
> (when you're mostly pushing changes), but not _always_ (when you pull a
> big batch of changes).
> 
> Soooo, being really really explicit about using reflog dates vs. commit
> dates -- and e.g., having option names like "--since" _always_ refer to
> commit dates -- would be a good thing, I think...
> 
> -Miles

Surely you agree that my original example shows that the current behavior
is confusing, yes?

So you're advocating --reflog-since (or some such)?
Or to disable the early --since early exit when walking the reflog?
Or for something else?

- Eric
