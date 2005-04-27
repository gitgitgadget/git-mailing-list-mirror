From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 11:47:36 -0700
Message-ID: <426FDE48.1050700@zytor.com>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org> <426FD3EE.5000404@zytor.com> <20050427183239.GE19011@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:45:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQrWD-0005L3-5m
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 20:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVD0St1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 14:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVD0St0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 14:49:26 -0400
Received: from terminus.zytor.com ([209.128.68.124]:35514 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261951AbVD0Sr7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 14:47:59 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3RIlfb5010042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 11:47:41 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050427183239.GE19011@redhat.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dave Jones wrote:
> 
> That actually broke one of my first git scripts when one of the
> changelog texts started a line with 'tree '.  I hacked around it
> by making my script only grep in the 'head -n4' lines, but this
> seems somewhat fragile having to make assumptions that the field
> I want to see is in the first 4 lines.
> 

You have the delimiter for that; there is an empty line between the 
header and the free-form body, similar as for RFC822.

	-hpa
