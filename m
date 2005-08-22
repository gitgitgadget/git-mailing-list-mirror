From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Multi-head pulling series
Date: Mon, 22 Aug 2005 18:35:31 +0200
Message-ID: <200508221835.31275.Josef.Weidendorfer@gmx.de>
References: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net> <200508181245.58250.Josef.Weidendorfer@gmx.de> <7vfyt4l9q9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 22 22:46:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7J9k-0006SI-9x
	for gcvg-git@gmane.org; Mon, 22 Aug 2005 22:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVHVUnk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 16:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVHVUnk
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 16:43:40 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:37095 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751143AbVHVUnj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2005 16:43:39 -0400
Received: from mailout1.informatik.tu-muenchen.de (mailout1.informatik.tu-muenchen.de [131.159.0.18])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7MGb1N6029451
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 09:37:01 -0700
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vfyt4l9q9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Saturday 20 August 2005 20:54, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> >> 	$ cat $GIT_DIR/remotes/www
> >> 	URL: http://www.kernel.org/pub/scm/git/git.git/
> >>	Pull: master:ko-master pu:ko-pu
> >>	Push: master:master pu:pu foo:bar
> >
> > Isn't this mixing two kinds of information:
> > 1) Some default/persistent mapping of local to remote heads
> > 2) The default heads which are pulled/pushed when only giving the remote
>
> I am not convinced myself that default/persistent mapping makes
> much sense,

I think that both, default and non-default persistant mappings, are only a 
handy convenience issue for less typing. If GIT core is not doing this, some 
(most?) porcelains will invent their own way for storing these mappings (like 
Cogito is doing with branches/). I think it is better if this is 
"standardized".

Currently missing here is automatic detection of the remote repository for a 
given head to be pulled/pushed. But this is no format issue.

> and updating the stored mappings dynamically when 
> the user uses non-default mappings in push/pull as a one-shot
> operation does not make any sense at all at least to me.

Yes, you are right.

Josef
