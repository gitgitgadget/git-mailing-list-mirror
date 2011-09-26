From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 11:47:56 -0600
Organization: CAF
Message-ID: <201109261147.56607.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109251443.28243.mfick@codeaurora.org> <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 19:48:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8FHh-0003JH-OO
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 19:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab1IZRr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 13:47:59 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:53268 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab1IZRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 13:47:59 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6480"; a="121508368"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 10:47:57 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 7E07B10004BE;
	Mon, 26 Sep 2011 10:47:57 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182139>

On Monday, September 26, 2011 06:41:04 am Christian Couder 
wrote:
> On Sun, Sep 25, 2011 at 10:43 PM, Martin Fick 
<mfick@codeaurora.org> wrote:
> > A coworker of mine pointed out to me that a simple
> > 
> >  git checkout
> > 
> > can also take rather long periods of time > 3 mins when
> > run on a repo with ~100K refs.
> 
> Are all these refs packed?

I think so, is there a way to find out for sure?

-Martin
