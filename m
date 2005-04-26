From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 15:50:12 -0700
Message-ID: <426EC5A4.2090107@zytor.com>
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com> <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Magnus Damm <magnus.damm@gmail.com>,
	mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:46:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYoV-0005aS-HA
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVDZWvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVDZWvD
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:51:03 -0400
Received: from terminus.zytor.com ([209.128.68.124]:34447 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261830AbVDZWu5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 18:50:57 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3QMoJMX019083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Apr 2005 15:50:20 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 26 Apr 2005, Andrew Morton wrote:
> 
>>Mounting as ext2 is a useful technique for determining whether the fs is
>>getting in the way.
> 
> 
> What's the preferred way to try to convert a root filesystem to a bigger
> journal? Forcing "rootfstype=ext2" at boot and boot into single-user, and
> then the appropriate magic tune2fs? Or what?
> 

Boot single-user, "remount -o ro,remount /", "tune2fs -J size=xxxM" and 
reboot.

	-hpa
