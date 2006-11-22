X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Kir Kolyshkin <kir@openvz.org>
Subject: Re: [PATCH] gitweb: make HTML links out of http/https URLs in changelogs
Date: Wed, 22 Nov 2006 12:00:05 +0300
Message-ID: <45641195.2000804@openvz.org>
References: <4563777C.4050108@openvz.org> <20061122000655.GJ7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 09:00:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
In-Reply-To: <20061122000655.GJ7201@pasky.or.cz>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0rc6 (sacred.ru [62.205.161.221]); Wed, 22 Nov 2006 11:57:37 +0300 (MSK)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32071>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmnxr-0002Jk-Bw for gcvg-git@gmane.org; Wed, 22 Nov
 2006 10:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161982AbWKVJAP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 04:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161998AbWKVJAO
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 04:00:14 -0500
Received: from [62.205.161.221] ([62.205.161.221]:19400 "EHLO sacred.ru") by
 vger.kernel.org with ESMTP id S1161995AbWKVJAN (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 04:00:13 -0500
Received: from [10.1.11.22] (darnet.ru [213.152.157.70] (may be forged))
 (authenticated bits=0) by sacred.ru (8.13.7/8.13.7) with ESMTP id
 kAM8vZIx032663 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Wed, 22 Nov 2006 11:57:36 +0300
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:
> On Tue, Nov 21, 2006 at 11:02:36PM CET, Kir Kolyshkin wrote:
>   
>> Slightly tested on http://git.openvz.org/. Applicable to git-1.4.4.
>>     
>
> ...but in git's gitweb view it will make this <a
> href="http://git.openvz.org/.">http://git.openvz.org/.</a>. :-)
Not a problem actually since "." means "current directory", so it will 
work fine (and I have checked that) :)
Sure there is a room for improvement for this regex -- and I am 
collecting those.

