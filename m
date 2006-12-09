X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 08 Dec 2006 16:51:56 -0800
Message-ID: <457A08AC.8030100@zytor.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>  <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>  <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>  <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>  <45798FE2.9040502@zytor.com>  <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>  <457998C8.3050601@garzik.org>  <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org> <f2b55d220612081546u1ffa98e5q75be55d31da82a2f@mail.gmail.com> <Pine.LNX.4.64.0612081648160.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 00:52:24 +0000 (UTC)
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
	Jeff Garzik <jeff@garzik.org>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612081648160.3516@woody.osdl.org>
X-Virus-Scanned: ClamAV 0.88.6/2308/Fri Dec  8 08:10:24 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33782>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsqRx-0005df-7Q for gcvg-git@gmane.org; Sat, 09 Dec
 2006 01:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947607AbWLIAwS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 19:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947609AbWLIAwS
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 19:52:18 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58225 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1947607AbWLIAwR (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 19:52:17 -0500
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
 (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id
 kB90pxZd006124 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Fri, 8 Dec 2006 16:52:00 -0800
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 8 Dec 2006, Michael K. Edwards wrote:
>> In Squid 2.6:
>>    collapsed_forwarding on
>>    refresh_stale_window <seconds>
>> (apply the latter only to stanzas where you want "readahead" of
>> about-to-expire cache entries)
> 
> Yeah, those look like the Right Thing (tm) to do.
> 
> That said, I'm not personally convinced that there is much point to using 
> netfilter for transparent proxying. Why not just use separate ports for 
> squid and for apache?
> 

Yeah, this is pretty trivial since one can just do redirects.  However, 
I still think a backend cache is better, since it can detach itself from 
Apache when appropriate (e.g. the background refresh scenario, or timeout.)

