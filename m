From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The big git command renaming..
Date: Fri, 29 Apr 2005 16:09:16 -0700
Message-ID: <4272BE9C.7090906@zytor.com>
References: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org> <20050429213540.GA1691@redhat.com> <4272AE05.2070202@zytor.com> <Pine.LNX.4.58.0504291511410.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dave Jones <davej@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:04:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DReX4-0006Kd-5v
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 01:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVD2XKB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 19:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVD2XKB
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 19:10:01 -0400
Received: from terminus.zytor.com ([209.128.68.124]:33214 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263053AbVD2XJq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 19:09:46 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3TN9MG0016973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2005 16:09:23 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504291511410.18901@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> Sure. 
> 
> Just a quick question: what are the "rules" for /pub/scm/git? 
> 
> Should I put just git in it, or is it meant for any "git project", and
> should I also copy the 2.6.x kernel home from
> 
> 	/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> to
> 
> 	/pub/scm/git/linux-2.6.git
> 
> or what?
> 
> Me, I can do either or both, I just don't know what the intent was..

/pub/scm/git I created for your git project; don't move the kernel in there.

If you have any other non-kernel git projects, just let me know and I'll 
make directories for them.

	-hpa

P.S. Are you still updating the trees in 
/pub/linux/kernel/people/torvalds/?  They still show up on our change 
reports, and cause problems for the mirrors.  Perhaps you could replace 
those trees with symlinks into /pub/scm.

	-hpa


