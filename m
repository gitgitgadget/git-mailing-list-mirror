From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 15/29] Produce legal patch names in
 guilt-import-commit.
Date: Thu, 15 May 2014 19:21:12 -0400
Message-ID: <20140515232112.GD1334@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-16-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri May 16 01:21:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4xb-0000oA-4K
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbaEOXVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:21:07 -0400
Received: from josefsipek.net ([64.9.206.49]:1631 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbaEOXVG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:21:06 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 4412B55654;
	Thu, 15 May 2014 19:21:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-16-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249267>

On Tue, May 13, 2014 at 10:30:51PM +0200, Per Cederqvist wrote:
> Try harder to create patch names that adhere to the rules in
> git-check-ref-format(1) when deriving a patch name from the commit
> message.  Verify that the derived name using "git check-ref-format",
> and as a final fallback simply use the patch name "x" (to ensure that
> the code is future-proof in case new rules are added in the future).
> 
> Always append a ".patch" suffix to the patch name.
> 
> Added test cases.

Also very nice.

Thanks,

Jeff.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

-- 
We have joy, we have fun, we have Linux on a Sun...
