From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 10:38:34 -0600
Organization: CAF
Message-ID: <201109261038.34527.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109260948.25312.mfick@codeaurora.org> <CAGdFq_hRmSif4=V+9h8=S1fWfPCj+meRY8xGyfgv=SWk+DrBQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 18:38:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ECa-0002LR-1b
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 18:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab1IZQik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 12:38:40 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:21493 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab1IZQij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 12:38:39 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6480"; a="121626743"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 09:38:35 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 8F4B010004BE;
	Mon, 26 Sep 2011 09:38:35 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CAGdFq_hRmSif4=V+9h8=S1fWfPCj+meRY8xGyfgv=SWk+DrBQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182129>

On Monday, September 26, 2011 09:56:50 am Sverre Rabbelier 
wrote:
> Heya,
> 
> On Mon, Sep 26, 2011 at 17:48, Martin Fick 
<mfick@codeaurora.org> wrote:
> > Hmm, I was thinking that too, and I just did a test.
> > 
> > Instead of storing the changes under refs/changes, I
> > fetched them under refs/heads/changes and then ran git
> > 1.7.6 and it took about 3 mins.  Then, I ran the
> > 1.7.7.rc0.73 with
> > c774aab98ce6c5ef7aaacbef38da0a501eb671d4 reverted and
> > it only took 13s!  So, if this indeed tests what you
> > were suggesting, I think it shows that even in the
> > intended case this change slowed things down?
> 
> And if you run 1.7.7 without that commit reverted?

Sorry, I probably confused things by mentioning 1.7.6, the 
bad commit was way before that early 1.5 days...  

As for 1.7.7, I don't think that exists yet, so did you mean 
the 1.7.7.rc0.73 version that I mentioned above without the 
revert?  Strangely enough, that ends up being 
1.7.7.rc0.72.g4b5ea.  That is also slow with 
refs/heads/changes > 3mins.

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
