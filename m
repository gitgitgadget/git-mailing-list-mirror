From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Mon, 09 Jan 2006 18:00:49 -0800
Message-ID: <43C31551.5010202@zytor.com>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net>	<43C2CAED.8030304@cc.jyu.fi> <7vwth9f1nk.fsf@assigned-by-dhcp.cox.net>	<43C2F7E2.4090909@cc.jyu.fi> <7v7j99exkc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: lamikr@cc.jyu.fi, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 03:01:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew8p3-0005vf-7C
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 03:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWAJCBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 21:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWAJCBO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 21:01:14 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39867 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932138AbWAJCBN
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 21:01:13 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0A20r9E017434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 Jan 2006 18:00:54 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j99exkc.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14395>

Junio C Hamano wrote:
> lamikr <lamikr@cc.jyu.fi> writes:
> 
>>Did you mean that things should work after 1.1.1 is released?
>>I tried to fresh build and install of 1.1.0 on top of the previous
>>1.1.0 build but "git --version" is still displaying me "git version 1.0.GIT"
> 
> You need to build from a git repository for these automated
> version numbers to work, and this will *not* change post 1.1.1.
> 

Tarballs really should work as-is... the easy way to deal with that is 
to have the tarball make script generate a version file which isn't part 
of the git tree.

I'll send a patch under a separate cover.

	-hpa
