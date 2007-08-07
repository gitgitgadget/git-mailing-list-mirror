From: Larry Finger <larry.finger@lwfinger.net>
Subject: Re: Problem with bisect
Date: Mon, 06 Aug 2007 21:53:41 -0500
Message-ID: <46B7DEB5.4060402@lwfinger.net>
References: <46B5F48D.7020907@lwfinger.net> <200708070350.50419.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:53:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIFCn-0006KD-PA
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933077AbXHGCxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 22:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933020AbXHGCxy
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:53:54 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:37388 "EHLO
	mtiwmhc12.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932942AbXHGCxx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 22:53:53 -0400
Received: from [192.168.1.104] (cpe-72-129-173-253.kc.res.rr.com[72.129.173.253])
          by worldnet.att.net (mtiwmhc12) with ESMTP
          id <2007080702534211200p85ehe>; Tue, 7 Aug 2007 02:53:52 +0000
User-Agent: Thunderbird 1.5.0.12 (X11/20070509)
In-Reply-To: <200708070350.50419.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55211>

Christian Couder wrote:
> 
> You use "git bisect good v2.6.22", but this is not true because the 
> tag "v2.6.22" is on the mainstream kernel branch and the driver is not 
> there.
> 
> If the v2.6.22 kernel that used to work came directly from John Linville's 
> wireless-dev git tree, not from a patch, then you should find the exact 
> commit in John Linville's tree that worked and say "git bisect good <this 
> commit>".
> 
> But if the driver that worked with a mainstream v2.6.22 kernel had been 
> patched, and now doesn't work when the same patch is applied to mainstream 
> v2.6.23-rc1 kernel, then you can perhaps use:
> 
> git bisect start
> git bisect bad v2.6.23-rc1
> git bisect good v2.6.22
> 
> and then:
> 
> 1) patch the kernel with the driver patch,
> 2) test the patched kernel,
> 3) remove the patch,
> 4) say "git bisect good" or "git bisect bad"
> 5) go to step 1) until the commit that broke the driver is found

Has the ability to use a commit hash to indicate a start point been in git for a long time? I think 
I remember trying it before when a version tag had not been downloaded and having a failure.

Larry
