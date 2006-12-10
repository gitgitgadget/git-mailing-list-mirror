X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 13:01:50 -0800
Message-ID: <457C75BE.1010805@zytor.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612101402.51363.jnareb@gmail.com> <457C0F8F.7030504@garzik.org> <200612102011.52589.jnareb@gmail.com> <Pine.LNX.4.64.0612101129190.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 21:02:22 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff Garzik <jeff@garzik.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612101129190.12500@woody.osdl.org>
X-Virus-Scanned: ClamAV 0.88.6/2313/Sun Dec 10 07:01:32 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33927>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtVoQ-00026D-4X for gcvg-git@gmane.org; Sun, 10 Dec
 2006 22:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762603AbWLJVCP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762599AbWLJVCP
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 16:02:15 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58764 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1762603AbWLJVCO (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 16:02:14 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net
 [67.180.238.27]) (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7)
 with ESMTP id kBAL1oWa004482 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA
 bits=256 verify=NO); Sun, 10 Dec 2006 13:01:52 -0800
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> Now, hopefully some of it will be in the disk cache, but when the 
> mirroring happens, it will basically blow the disk caches away totally 
> (when using the "--checksum" option), and then you literally have tens of 
> seconds to generate that one top-level page. 
> 

If that was the only time that happened, it would be a non-issue, since 
that only happens once every 96 hours.  However, the problem is that we 
now have lots of large datasets that blow out the caches on a much more 
frequent basis.

