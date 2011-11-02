From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Wed, 02 Nov 2011 08:34:18 +0100
Message-ID: <4EB0F27A.1040908@lyx.org>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org> <7vd3dcq4s5.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1110311908240.1930@bonsai2> <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com> <alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info> <CAAH6HY8WfOQQ4g54y7mriq6BKoJCWYsVPrQUTMndqpKdniLAtw@mail.gmail.com> <CABNJ2G+Km4wob4_uNYQLkQUL61-ohZg5cL2yu7j1cngoL9W7Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 08:34:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLVLC-0000ud-0G
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 08:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab1KBHeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 03:34:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44704 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1KBHeY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 03:34:24 -0400
Received: by eye27 with SMTP id 27so6838595eye.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 00:34:23 -0700 (PDT)
Received: by 10.213.28.145 with SMTP id m17mr1720858ebc.0.1320219263468;
        Wed, 02 Nov 2011 00:34:23 -0700 (PDT)
Received: from [145.94.168.80] (wlan-145-94-168-080.wlan.tudelft.nl. [145.94.168.80])
        by mx.google.com with ESMTPS id t6sm3984949eeb.11.2011.11.02.00.34.22
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Nov 2011 00:34:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CABNJ2G+Km4wob4_uNYQLkQUL61-ohZg5cL2yu7j1cngoL9W7Cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184613>

Op 2-11-2011 1:48, Pat Thoyts schreef:
> On 1 November 2011 22:32, Vincent van Ravesteijn<vfr@lyx.org>  wrote:
>>> Maybe if someone donates Jenkins resources, we could make an automatic
>>> branch in the future that has git.sln in it (similar to the 'html' branch
>>> in git.git).
>>>
>> As long as this means to just run a not so complicated perl script, this
>> Could even be done in a commit hook.
>>
>> Just another question. How does the (msys)git community feel about adding
>> CMake support ? I can probably do that quite easily.
>>
>> Vincent
>>
> -1. We have a make. We don't need two of them.

Make won't offer anything if you want to support MSVC. So, if you want 
to support MSVC, there has to be some sort of alternative.

Vincent
