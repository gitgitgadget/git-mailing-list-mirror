From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] gitweb - Use <description> instead of <content:encoded>.
Date: Thu, 18 Aug 2005 18:01:09 +0200
Message-ID: <20050818160109.GA7237@vrfy.org>
References: <87ll2zwc4u.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 18:02:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5mpV-0000i9-FM
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 18:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVHRQBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 12:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVHRQBL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 12:01:11 -0400
Received: from soundwarez.org ([217.160.171.123]:41140 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932270AbVHRQBL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 12:01:11 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 5AA3A57E29; Thu, 18 Aug 2005 18:01:09 +0200 (CEST)
To: Yasushi SHOJI <yashi@atmark-techno.com>
Content-Disposition: inline
In-Reply-To: <87ll2zwc4u.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2005 at 11:30:41PM +0900, Yasushi SHOJI wrote:
> Use <description> instead of <content:encoded>.
> 
> RSS 2.0 Specification doesn't have <content:encoded>.
> see http://blogs.law.harvard.edu/tech/rss

See here:
  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ

  The <description> element is designed to contain plain text ONLY. When
  the content of your items contains anything other than plain text i.e.
  HTML or XHTML the <content:encoded> element should be used.

Hmm, there was a request to change it to "encoded" and the mentioned page
sounded reasonable to me. I will happily change it to the "correct"
format, if you provide _authoritative_ information that we can trust.
"It works in XY-reader" does not count. :)

Thanks,
Kay
