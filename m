From: Larry Finger <larry.finger@lwfinger.net>
Subject: Re: Problem with bisect
Date: Mon, 06 Aug 2007 13:37:51 -0500
Message-ID: <46B76A7F.3000103@lwfinger.net>
References: <46B5F48D.7020907@lwfinger.net>	<20070805145234.554bf671.seanlkml@sympatico.ca>	<46B623D6.7070809@lwfinger.net> <20070806141233.3d8a43cc.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Aug 06 20:38:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II7Sx-0007Va-C0
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 20:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757124AbXHFSiD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 14:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbXHFSiC
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 14:38:02 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:40469 "EHLO
	mtiwmhc13.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751077AbXHFSiA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 14:38:00 -0400
Received: from [192.168.1.104] (cpe-72-129-173-253.kc.res.rr.com[72.129.173.253])
          by worldnet.att.net (mtiwmhc13) with ESMTP
          id <20070806183759113008uiide>; Mon, 6 Aug 2007 18:37:59 +0000
User-Agent: Thunderbird 1.5.0.12 (X11/20070509)
In-Reply-To: <20070806141233.3d8a43cc.seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55165>

Sean wrote:
> 
> The directory "drivers/net/wireless/bcm43xx-mac80211" is only introduced in
> commit v2.6.23-rc1-1621-gd05daff.   It didn't exist in v2.6.22.
> 
> You can see this with the command:
> 
>   $ git log -- drivers/net/wireless/bcm43xx-mac80211
> 
> Where the last listed commit is d05daff.  So of course there will be many
> bisection points back to v2.6.22 where that directory just doesn't exist.
> A bit of digging with Git shows this history for most of the files in
> that directory:
> 
>   renamed in v2.6.23-rc1-1621 as bcm43xx-mac80211
>   renamed in v2.6.21-rc1-809 as mac80211
>   renamed in v2.6.17-rc2-357 as d80211/bcm43xx
>  Imported in v2.6.16-1725 as bcm43xx-d80211

Thanks for the response. Obviously the  difficulties were due to the structure of the tree. This 
chunk of code has had a varied history.

Larry
