From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Index/hash order
Date: Wed, 13 Apr 2005 13:07:43 -0700
Message-ID: <425D7C0F.2050109@zytor.com>
References: <20050412230027.GA21759@elte.hu> <20050412230729.GA22179@elte.hu> <20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com> <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com> <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 22:07:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLo74-0004gD-8u
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 22:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDMUIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVDMUIM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 16:08:12 -0400
Received: from terminus.zytor.com ([209.128.68.124]:27858 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261159AbVDMUIB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 16:08:01 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3DK7mCc021869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Apr 2005 13:07:48 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050413200237.GA26635@elte.hu>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar wrote:
> 
> that's what i loosely meant under 'manageability problems'.
> 
> I mentioned one solution earlier: to make the repository object an 
> immutable file (the +i flag on the inode) - it really wants to be 
> immutable after all. That would solve a whole range of 'accidental 
> corruption' issues.
> 

I think abusing the immutable bit quickly will decend into the same 
rathole which makes u-w often useless.  u-w will actually be preserved 
by more tools -- simply because they know about it -- than +i.

Either which way, it feels to me that this idea has already been ruled 
out, so it's probably pointless to keep debating just exactly what we're 
not actually going to do.

	-hpa
