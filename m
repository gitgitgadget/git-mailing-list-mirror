From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 18:29:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0505231827430.4200@qynat.qvtvafvgr.pbz>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org>
 <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org>
 <7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net><87bcada447378d0173a3c5f165c70b38.ANY@taniwha.stupidest.org><7vhdgt1ncz.fsf@assigned-by-dhcp.cox.net>
 <046ec1d00820537103092ed264f81f65.IBX@taniwha.stupidest.org><7v64x91mfb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505231758350.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, Chris Wedgwood <cw@f00f.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 03:28:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaODU-0005HG-DH
	for gcvg-git@gmane.org; Tue, 24 May 2005 03:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVEXB3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 21:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEXB3r
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 21:29:47 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:16101 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261270AbVEXB3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 21:29:37 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Mon, 23 May 2005 18:24:31 -0700
Received: by atlexc02.diginsite.com with Internet Mail Service (5.5.2653.19)
	id <LN11NY7C>; Mon, 23 May 2005 21:29:25 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id LNM34Z30; Mon, 23 May 2005 18:29:07 -0700
To: Linus Torvalds <torvalds@osdl.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.58.0505231758350.2307@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 23 May 2005, Linus Torvalds wrote:

> On Mon, 23 May 2005, Junio C Hamano wrote:
>>
>> Embedded spaces in path is _always_ safe.
>
> For raw-diff yes, but since you'd normally end up using that name in the
> diff, it won't be safe any more.
>
> Imagine a name like "this is a file", and think about how the diff ends up
> looking:
>
> 	diff --git a/this is a file b/this is a file
>
> and realize that that can't be parsed sanely by anybody who uses the diff.

hmm, personally I would have expected it to do shell escapeing of the name

diff --git a/this\ is\ a \ file b/this\ is\ a\ file

given that diff is trying to record how it was called.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
