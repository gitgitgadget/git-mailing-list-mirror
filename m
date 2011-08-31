From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess,iffy] Re: [spf:guess] Re: [PATCH] Teach dcommit --mergeinfo
 to handle multiple lines
Date: Wed, 31 Aug 2011 15:15:09 -0700
Message-ID: <4E5EB26D.8030004@vilain.net>
References: <20110831124839.69c70486@robyn.woti.com> <20110831202131.GA27307@dcvr.yhbt.net> <4E5E9CFB.4060600@vilain.net> <20110831165109.0ca6373f@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 00:15:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyt43-0000tu-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 00:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756627Ab1HaWPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 18:15:14 -0400
Received: from uk.vilain.net ([92.48.122.123]:48172 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab1HaWPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 18:15:13 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 073F4824E; Wed, 31 Aug 2011 23:15:12 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.112.205] (unknown [64.125.143.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id C01FB807A;
	Wed, 31 Aug 2011 23:15:09 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.1) Gecko/20110830 Thunderbird/6.0.1
In-Reply-To: <20110831165109.0ca6373f@robyn.woti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180508>

On 8/31/11 1:51 PM, Bryan Jacobs wrote:
> ...I didn't create the original --mergeinfo interface. I was very 
> surprised when I first discovered it clobbered instead of integrating 
> - it's easy to nuke your SVN repo's ability to merge with one careless 
> use of this option. See below.
>> But so long as it makes something previously impossible possible, it
>> is a good change - my feeling is that it should be called something
>> like --mergeinfo-raw or --mergeinfo-set to leave room for a possible
>> --mergeinfo-add which knows how the lists work and adds them (which
>> is what I'd expect a plain --mergeinfo switch to do).
> I completely agree. I think there should at least be a
> --mergeinfo-update which fetches the current revision, merges that with
> the provided set using the branch paths as keys (and compacts using
> svn:mergeinfo rules), and sets the property to the final result.
>
> I actually do this currently with external scripts, which is why I
> wanted to make --mergeinfo capable of delivering my final payload. It
> would make my life easier if all the logic were part of git-svn instead.
>
> That said, this change is really small. That change would be larger.
> So I submitted this first.
>

Ok, well I guess this is a useful intermediate feature then.  Feel free 
to copy in any further changes you may come up with in this area to me, 
if you decide to do that.

Cheers,
Sam
