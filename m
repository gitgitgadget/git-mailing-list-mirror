From: David Rothenberger <daveroth@acm.org>
Subject: Re: [PATCH 0/2] allow git-svn fetching to work using serf
Date: Sat, 06 Jul 2013 00:17:17 -0700
Message-ID: <51D7C47D.5070700@acm.org>
References: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 06 09:17:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvMkQ-00079L-DW
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 09:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab3GFHRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 03:17:30 -0400
Received: from plane.gmane.org ([80.91.229.3]:45026 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667Ab3GFHR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 03:17:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UvMkK-00075I-Ri
	for git@vger.kernel.org; Sat, 06 Jul 2013 09:17:28 +0200
Received: from c-24-16-16-7.hsd1.wa.comcast.net ([24.16.16.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 09:17:28 +0200
Received: from daveroth by c-24-16-16-7.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 09:17:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-16-7.hsd1.wa.comcast.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229696>

On 7/5/2013 8:41 PM, Kyle McKay wrote:
> This patch allows git-svn to fetch successfully using the
> serf library when given an https?: url to fetch from.

Thanks, Kyle. I confirm this is working for my problem cases as
well.

> Daniel Shahaf has suggested also setting
> "servers:global:http-bulk-updates=on".

I have a patch that does this, but since turning on bulk updates has
a possible performance penalty, I prefer your approach. 

Please let me know if anyone wants to see the patch.

-- 
David Rothenberger  ----  daveroth@acm.org

What to do in case of an alien attack:

    1)   Hide beneath the seat of your plane and look away.
    2)   Avoid eye contact.
    3) If there are no eyes, avoid all contact.

                -- The Firesign Theatre, _Everything you know is Wrong_
