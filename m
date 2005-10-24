From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 11:03:10 -0700
Message-ID: <435D21DE.6080404@zytor.com>
References: <867jc336f4.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240901020.10477@g5.osdl.org> <86irvmzyq9.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240936450.10477@g5.osdl.org> <Pine.LNX.4.64.0510241002180.10477@g5.osdl.org> <435D1963.8070205@zytor.com> <Pine.LNX.4.64.0510241054480.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 20:05:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU6gg-0000X6-PQ
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 20:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVJXSDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 14:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJXSDn
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 14:03:43 -0400
Received: from terminus.zytor.com ([192.83.249.54]:41681 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751218AbVJXSD1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 14:03:27 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9OI3F3g015488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Oct 2005 11:03:16 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510241054480.10477@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10552>

Linus Torvalds wrote:
> 
> Btw, nobody ever replied to my question whether we might be using 
> something else that is locale-specific. I'm not actually locate-aware 
> enough to even know what else than <ctype.h> might be dangerous to use..
> 

Regexxen are probably the single most problematic thing.

	-hpa
