From: Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: [JGIT] Request for help
Date: Thu, 03 Sep 2009 15:09:35 -0600
Organization: Code Aurora Forum
Message-ID: <4AA0308F.9@codeaurora.org>
References: <4A9EFFB1.9090501@codeaurora.org> <20090903012315.GG1033@spearce.org> <4AA01D08.3060400@codeaurora.org> <20090903194955.GL1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 23:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjJYw-0001sf-TR
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 23:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbZICVJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 17:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbZICVJf
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 17:09:35 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:40471 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbZICVJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 17:09:35 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5730"; a="23083576"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 03 Sep 2009 14:09:37 -0700
Received: from [129.46.10.111] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 1542B10004C9;
	Thu,  3 Sep 2009 14:11:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <20090903194955.GL1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127667>

Shawn O. Pearce wrote:
> Nasser Grainawi <nasser@codeaurora.org> wrote:
>> Shawn O. Pearce wrote:
>>> Hmm, maybe a method on Patch is reasonable.
>> Going down this route, I'd add a few things to Patch.
>> patchId would be a private field (of type ObjectId?)
>> getPatchId would be a public method that returns patchId
>> and then likely a private method (computePatchId?) that actually  
>> generates the patchId
> 
> Sure, but getPatchId can compute it on demand on the first call,
> and anyone who modifies the Patch would just need to clear out
> the cached patchId value so the next call (if it ever comes) to
> getPatchId would force it to recompute.
> 
> Most users of Patch won't want the patchId, so there is no reason
> to compute it.
> 
Works for me, that's even easier. I'll get to work on implementing this,
but between (re-)learning Java and our legal dept, don't know when I'll
have a finished product to share...

I'll continue to post questions as I get them.
Thanks everyone for their help thus far :)
