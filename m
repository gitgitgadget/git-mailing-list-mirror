From: Daniel Drake <dsd@gentoo.org>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Mon, 03 Apr 2006 19:28:28 +0100
Message-ID: <4431694C.4000007@gentoo.org>
References: <443146EC.7060704@gentoo.org> <7virpqefp1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 20:17:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQTc6-0003yo-Na
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 20:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWDCSRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 14:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWDCSRM
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 14:17:12 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:61682 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964840AbWDCSRK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 14:17:10 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060403181709.BXVI29343.mtaout01-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Mon, 3 Apr 2006 19:17:09 +0100
Received: from [192.168.0.2] (really [86.14.216.162])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060403181706.TMMI19763.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 3 Apr 2006 19:17:06 +0100
User-Agent: Mail/News 1.5 (X11/20060401)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virpqefp1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18346>

Junio C Hamano wrote:
> client$ wget http://dsd.object4.net/git/zd1211.git/info/refs

Ah, should have known. I am behind a (lame) transparent proxy on port 80.

I opened that file in my web browser and it showed the old heads. After 
a force-refresh (ctrl+F5, which sends some additionally http headers to 
refresh the page from the real server), the old heads disappeared, and 
git now clones successfully.

git-http-fetch should probably send those extra headers too. I'll try to 
find some time to look at this next week.

Thanks!
Daniel
