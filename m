From: Lea Wiemann <lewiemann@gmail.com>
Subject: Merging strategy for extending Git.pm (was: [PATCH] perl/Git.pm:
 add rev_parse method)
Date: Fri, 30 May 2008 17:15:21 +0200
Message-ID: <48401A09.6060301@gmail.com>
References: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com> <483FA6B3.4070607@gmail.com> <20080530095938.GE18781@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 17:17:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K26Ky-0003cu-8D
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 17:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbYE3PPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 11:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbYE3PPU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 11:15:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:26448 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbYE3PPS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 11:15:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so141455fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=coTIC2b6P+bISJcjYr4K2jGzO2nX2QeKthy4z7VOWGg=;
        b=a7LY2fE6a+nl+g6lQwJ9SfBYLUr555XCkr3ukm0TMTrWrzzHfadTSB4DmLoSDroCtzRVmXavZ/79uMhoS4hu0h8aI9kSuYDHMMGQDRWFoAytwcZYWWzcANzdWfHNqBSmeSBmGNES5GmE3jFEYg0ts+wYt9vxvhSBOKxZ8WzC0WI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=T6QyXxMWbJ6f6xWTgCrJqOnAjB8JhK2lfG7dnpGmTwg5u1mDDptXzmE9g4Maro983hcumdQTN6KizWMnF12I2lehWdvHW8trCl9xuv1Vw5gBZkzjgtQ6M9brvkMKAM86KyblqXND3uk32maiqrcS2iXNj+j1w+lzA1mFFcQYWiE=
Received: by 10.86.70.8 with SMTP id s8mr247454fga.79.1212160514558;
        Fri, 30 May 2008 08:15:14 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id e20sm248463fga.1.2008.05.30.08.15.12
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 08:15:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080530095938.GE18781@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83307>

Petr Baudis wrote:
> (i) Tell Junio you would like the changes to stay in pu or next for now.
> [...]
> you will be getting immediate feedback about your changes as you go and 
> your work will be useful at any point of time.

Junio, any comments on this?  Doing doing small iterations is great IMO, 
and I'll be doing it in any case.  However, right now I see three 
possible problems with merging to pu continuously (rather than keeping 
it on my branch and merging in large chunks):

1. I'm working full-time on this, so I might produce patches that 
loosely depend on one another at a peak rate of 2-3 per day.  (I can do 
other project-related stuff while my patches are waiting for review, but 
only so much of course.)  Do you have any experience with working with 
full-time developers on Git?  Do you see problems with my potentially 
high patch frequency?

2. I'll be changing my own API.  In other words, the API is really 
unstable while I work on this (with the only user of the API being 
Gitweb, which I'll update as I go).  Is that OK for the pu branch?

3. I try to be careful with my commits, but it might still cause more 
work for whoever reviews my patches, compared to reviewing larger 
chunks.  (That's because some of the stuff I write might end up being 
deleted or rewritten later.)

Apart from that, I think merging (and getting feedback) continuously is 
great.

So, comments would be much appreciated!

-- Lea
