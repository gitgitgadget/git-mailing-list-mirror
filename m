From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH 0/3] Git::Repo API and gitweb caching
Date: Fri, 11 Jul 2008 21:57:52 +0530
Message-ID: <20080711162752.GA5456@toroid.org>
References: <4876B223.4070707@gmail.com> <200807111133.11662.jnareb@gmail.com> <4877691E.1010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLUL-0001uM-L2
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 18:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbYGKQ1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbYGKQ1z
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:27:55 -0400
Received: from fugue.toroid.org ([85.10.196.113]:41583 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbYGKQ1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:27:54 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 316E75584D8;
	Fri, 11 Jul 2008 18:27:53 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id B3877ADC364; Fri, 11 Jul 2008 21:57:52 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <4877691E.1010000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88142>

At 2008-07-11 16:07:26 +0200, lewiemann@gmail.com wrote:
>
> > 'If-Not-Modified-Since', 'If-Match' (by caches)
> 
> Wait, are you sure caches would use those headers (I believe only the
> latter actually exists BTW), or did you fall prey to a thinko? ;)

If-Not-Modified-Since should really be If-Unmodified-Since.

But where's the thinko? To send If-Modified-Since or similar with a
request, you would need to have a cached copy of the resource and use
its Last-Modified, for example. Sure, you could do it without one, but
what would be the point?

-- ams
