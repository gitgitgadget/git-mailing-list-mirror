From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] gitk: Enable mouse horizontal scrolling in diff pane
Date: Sun, 16 Nov 2014 09:00:01 +0100
Message-ID: <1lv745j.1ypmc8r5ybicrM%lists@haller-berlin.de>
References: <1416060306-4048-1-git-send-email-gabriele.mzt@gmail.com>
Cc: paulus@samba.org
To: gabriele.mzt@gmail.com (Gabriele Mazzotta), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 09:07:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpurh-0001Nl-ED
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 09:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbaKPIHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 03:07:14 -0500
Received: from server90.greatnet.de ([178.254.50.90]:60832 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbaKPIHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 03:07:13 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Nov 2014 03:07:13 EST
Received: from [192.168.42.159] (dslb-178-000-001-228.178.000.pools.vodafone-ip.de [178.0.1.228])
	by server90.greatnet.de (Postfix) with ESMTPA id EC41960042;
	Sun, 16 Nov 2014 09:00:01 +0100 (CET)
In-Reply-To: <1416060306-4048-1-git-send-email-gabriele.mzt@gmail.com>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.10 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gabriele Mazzotta <gabriele.mzt@gmail.com> wrote:

> Currently it's required to hold Shift and scroll up and down to move
> horizontally. Listen to Button-6 and Button-7 events too to make
> horizontal scrolling handier with touchpads and some mice.

Hm, on my Macbook the diff pane already scrolls in all four directions
with two-finger scrolling on the trackpad. (Without your patch, I mean.)

In my copy of gitk I did the opposite for the commit list though; I
can't stand it that I accidentally scroll left or right with the
trackpad, so I commented out some code to restrict it to only vertical
scrolling. I never posted this patch because I bet many people like the
current behaviour. Just so you know that such a change might be
controversial.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
