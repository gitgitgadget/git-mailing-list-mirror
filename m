From: Teemu Likonen <tlikonen@iki.fi>
Subject: hooks/post-update does not run
Date: Fri, 30 May 2008 15:58:14 +0300
Message-ID: <20080530125814.GA8584@mithlond.arda.local>
References: <3a6159d2-e1ff-4aa8-bfeb-806af2bc82c8@8g2000hse.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 14:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K24CM-0004C9-J2
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 14:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYE3M6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 08:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbYE3M6S
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 08:58:18 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:52971 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750885AbYE3M6S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 08:58:18 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F1000FEF39; Fri, 30 May 2008 15:58:18 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K24BS-0002Ez-N2; Fri, 30 May 2008 15:58:14 +0300
Content-Disposition: inline
In-Reply-To: <3a6159d2-e1ff-4aa8-bfeb-806af2bc82c8@8g2000hse.googlegroups.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83293>

davetron5000 wrote (2008-05-30 05:42 -0700):

> There's a few issues:
[...]
> 4. I made post-update executable, but it never runs (it echos a
> message to a file)

I have experienced this too. I never got post-update to do anything
- even if the repository lies on the same computer and filesystem I'm
pushing from. I wrote about this issue two ago but it didn't get any
replies: 

http://thread.gmane.org/gmane.comp.version-control.git/82351
