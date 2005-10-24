From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 10:04:02 -0700
Message-ID: <435D1402.4050601@zytor.com>
References: <867jc336f4.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240901020.10477@g5.osdl.org> <86irvmzyq9.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240936450.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 19:08:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU5kG-00042p-3D
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 19:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVJXREV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 13:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVJXREV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 13:04:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:44416 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751170AbVJXREU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 13:04:20 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9OH48L4009726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Oct 2005 10:04:08 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510240936450.10477@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RISK_FREE 
	autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10548>

Linus Torvalds wrote:
> 
> I think Junio's patch (that renames things) is possibly the "cleaner" 
> alternative, but on the other hand there's a lot of advantages to just 
> using the standard names. No chance of somebody using the wrong version by 
> mistake.
> 

But there is also no risk of other unexpected dependencies.  I would 
vote for using git-specific names.

	-hpa
