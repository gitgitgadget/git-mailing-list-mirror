From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [msysGit] [FYI][PATCH] Customizing the WinGit installer
Date: Tue, 7 Oct 2008 05:59:42 +0400
Message-ID: <20081007015942.GV21650@dpotapov.dyndns.org>
References: <20081003122727.GE10360@machine.or.cz> <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006141840.GO10360@machine.or.cz> <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de> <m3zllhpvby.fsf@localhost.localdomain> <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org> <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006201125.GI16289@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Tue Oct 07 04:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn1t8-0008SS-1A
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 04:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbYJGB7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 21:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYJGB7u
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 21:59:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:20347 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbYJGB7t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 21:59:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2152785fgg.17
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 18:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Id+ycSorDu8LgpoDkXFZUltmKay07OhPDatcwcdQ+zI=;
        b=TnwbU+swG+yDTnMvXdvgX8Cc0C4DfHLrupCEkEN9RgkyPjD5jWrPuyZRmvdqhtHS6d
         7K5zQ7dMLETrXuu65m2UJ4xGgbgGvxAZGzR7BDy4leQA97gaudxuXdRyV0JSiKq712wj
         TgrVksM8J+hJWqvrdhqWtG0NyvoR43bXc4t6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rDwp3Ylm81Z3hMpT3IuWXu+0I2O2OHoGpgHHPKqXRS1QuZ1n54q4K2GGbUPAkrgeXD
         gzHywqQjFY2e74u2PPqll8C465zWv+JBcs8NR2eFRCB+dCT5NOUNYwzDwuxblUhuaIuV
         S23vG3wndlogZ/5jSFeMn1DZ/9JFTwMjPoff0=
Received: by 10.86.57.9 with SMTP id f9mr5212289fga.66.1223344787444;
        Mon, 06 Oct 2008 18:59:47 -0700 (PDT)
Received: from localhost (ppp91-77-160-5.pppoe.mtu-net.ru [91.77.160.5])
        by mx.google.com with ESMTPS id 3sm12446388fge.3.2008.10.06.18.59.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 18:59:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081006201125.GI16289@zakalwe.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97652>

On Mon, Oct 06, 2008 at 11:11:25PM +0300, Heikki Orsila wrote:
> 
> I disagree VIOLENTLY with you. I've been utterly struck with this 
> Windows crap here.. I spent a day installing stupid trivial software 
> and answering pointless EULAs. I REALLY REALLY hate extra questions.. 

Git installer should NOT ask you whether you agree with the license,
but it merely shows you the license. (At least, it is what was decided
half a year ago).

> This is my 20th reboot..

I am pretty sure that 20th reboot has nothing to do with how many times
the license has been shown...

Dmitry
