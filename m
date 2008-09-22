From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from git-gui.
Date: Mon, 22 Sep 2008 13:01:51 +0400
Message-ID: <20080922090151.GJ21650@dpotapov.dyndns.org>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <bb6f213e0809190538m5bbfeb38o5510d06fa6757dd1@mail.gmail.com> <48D3A376.30905@viscovery.net> <200809212252.35769.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 11:03:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhhJx-0006FM-VB
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 11:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbYIVJB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 05:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbYIVJB6
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 05:01:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:45304 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbYIVJB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 05:01:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1296998fgg.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Cun81zqjHewVjy5WmyKc0VDreICQSfWm2wOsAOXaops=;
        b=KScr6tMCdvcSG32if60OjfjupqfRMo53nxnPXflmYTTantPW+l1RxLoMWZmTDpaISw
         ta2UCQEGf0Ll4Qrg8UrOqiV1VjMAfirSrxPriFpJBCR1qIessrryBiiobAhYK53ZPx+6
         SOo6xnltfVttZB6GaidJX352rIpkP+Y7dR5Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ng0rUXCizIKA9mXeHw67D4JE8SrOYvqCK7lWoDkbpLEgIkVYjgV6IgFn04jJxUjeiz
         INnJRc7EU9UQKuEI4mfePugnif2gdsOSEZzWm30UOdVRLLH+06PiqRIMyAciTQZisBun
         wONj3tRKiVGcf3juxlFN8ErZ1Cv1wvV1Ac+mQ=
Received: by 10.86.80.17 with SMTP id d17mr4537043fgb.24.1222074115959;
        Mon, 22 Sep 2008 02:01:55 -0700 (PDT)
Received: from localhost (ppp85-140-171-157.pppoe.mtu-net.ru [85.140.171.157])
        by mx.google.com with ESMTPS id l19sm5078715fgb.7.2008.09.22.02.01.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 02:01:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809212252.35769.angavrilov@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96462>

On Sun, Sep 21, 2008 at 10:52:35PM +0400, Alexander Gavrilov wrote:
> 
> I made a patch to optimize attribute lookup. I'm afraid that further optimization
> is impossible without interface changes in git-check-attr, or reimplementing
> the attribute parser in Tcl.

I wonder would not make sense to add --stdin-paths option to git
check-attr in the same way as we have for git hash-object?

Dmitry
