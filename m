From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 14:04:24 -0700
Message-ID: <426FFE58.4050901@zytor.com>
References: <aec7e5c305042608095731d571@mail.gmail.com>	<200504261138.46339.mason@suse.com>	<aec7e5c305042609231a5d3f0@mail.gmail.com>	<20050426135606.7b21a2e2.akpm@osdl.org>	<Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>	<20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com>	<871x8wb6w4.fsf@deneb.enyo.de>	<20050427151357.GH1087@cip.informatik.uni-erlangen.de>	<426FDFCD.6000309@zytor.com>	<20050427190144.GA28848@cip.informatik.uni-erlangen.de> <874qds5489.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	magnus.damm@gmail.com, mason@suse.com, mike.taht@timesys.com,
	mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 23:00:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtdN-0001iW-9G
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVD0VFD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 17:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVD0VFD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 17:05:03 -0400
Received: from terminus.zytor.com ([209.128.68.124]:64445 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262012AbVD0VE6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 17:04:58 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3RL4Up2012175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 14:04:30 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <874qds5489.fsf@deneb.enyo.de>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Florian Weimer wrote:
> 
> Benchmarks are actually a bit tricky because as far as I can tell,
> once you hash the directories, they are tainted even if you mount your
> file system with ext2.

That's what fsck -D is for.

	-hpa
