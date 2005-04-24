From: Dan Weber <dan@mirrorlynx.com>
Subject: Re: Git cancel work
Date: Sun, 24 Apr 2005 08:59:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504240859210.27230@mirrorlynx.com>
References: <Pine.LNX.4.62.0504240033230.1980@mirrorlynx.com>
 <20050424124930.GE1507@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 14:53:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPgbz-0007Gi-6p
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 14:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVDXM6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 08:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVDXM6N
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 08:58:13 -0400
Received: from outbound.mailhop.org ([63.208.196.171]:37134 "EHLO
	outbound.mailhop.org") by vger.kernel.org with ESMTP
	id S262316AbVDXM6I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 08:58:08 -0400
Received: from pool-68-238-240-238.phlapa.fios.verizon.net ([68.238.240.238] helo=mirrorlynx.com)
	by outbound.mailhop.org with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.44)
	id 1DPgga-000NSF-7B; Sun, 24 Apr 2005 08:58:08 -0400
Received: from dan (helo=localhost)
	by mirrorlynx.com with local-esmtp (Exim 4.34)
	id 1DPghv-0007HC-E1; Sun, 24 Apr 2005 08:59:32 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050424124930.GE1507@pasky.ji.cz>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: pasky@ucw.cz, git@vger.kernel.org
X-SA-Exim-Mail-From: dan@mirrorlynx.com
X-Spam-Checker-Version: SpamAssassin 3.0.0 (2004-09-13) on mirrorlynx.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=unavailable version=3.0.0
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mirrorlynx.com)
X-Mail-Handler: MailHop Outbound by DynDNS.org
X-Originating-IP: 68.238.240.238
X-Report-Abuse-To: abuse@dyndns.org (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: DanWeber1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Why does it take so ridiculously long then?

Dan

On Sun, 24 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sun, Apr 24, 2005 at 06:34:44AM CEST, I got a letter
> where Dan Weber <dan@mirrorlynx.com> told me that...
>> I noticed that git cancel was always doing a full checkout.  So I figured,
>> "what about just checking out the modified files?".  Attached is a patch
>> to do so.
>
> But that is what checkout-cache -f -a does:
>
>        if (!stat(path, &st)) {
>                unsigned changed = cache_match_stat(ce, &st);
>                if (!changed)
>                        return 0;
>
> in checkout_entry().
>
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
>
