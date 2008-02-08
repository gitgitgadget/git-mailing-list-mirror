From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH (repost)] Improve bash prompt to detect merge / rebase in progress
Date: Fri, 8 Feb 2008 12:26:01 +0100
Message-ID: <F19A1227-3803-4C23-BEA2-26F23824ACF5@zib.de>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <200802062314.39440.robin.rosenberg.lists@dewire.com> <7vodatu37m.fsf@gitster.siamese.dyndns.org> <200802070123.43109.robin.rosenberg.lists@dewire.com> <20080207063412.GQ24004@spearce.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Stephen Sinclair <radarsat1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 12:26:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNRN9-00067B-K4
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 12:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbYBHLZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 06:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbYBHLZw
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 06:25:52 -0500
Received: from mailer.zib.de ([130.73.108.11]:48554 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932201AbYBHLZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 06:25:51 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m18BP4Em016829;
	Fri, 8 Feb 2008 12:25:08 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m18BP2LP020578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 8 Feb 2008 12:25:03 +0100 (MET)
In-Reply-To: <20080207063412.GQ24004@spearce.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73075>


On Feb 7, 2008, at 7:34 AM, Shawn O. Pearce wrote:

> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>> I sent a patch and Shawn modified it somewhat and posted the full  
>> modified
>> patch. Here is the same patch again (to make sure you get the  
>> right one). It
>> has a better comment than the one I sent recently.
>>
>> -- robin
>>
>> From 82a5b8d5b043ffc7c1950b391ec7ae69d575640b Mon Sep 17 00:00:00  
>> 2001
>> From: Robin Rosenberg <robin.rosenberg@dewire.com>
>> Date: Sun, 30 Sep 2007 02:20:45 +0200
>> Subject: [PATCH] Improve bash prompt to detect various states like  
>> an unfinished merge
>>
>> This patch makes the git prompt (when enabled) show if a merge or a
>> rebase is unfinished. It also detects if a bisect is being done as
>> well as detached checkouts.
>>
>> An uncompleted git-am cannot be distinguised from a rebase (the
>> non-interactive version). Instead of having an even longer prompt
>> we simply ignore that and hope the power users that use git-am knows
>> the difference.
>>
>> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
>
> For what it's worth:
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

This improved prompt is great.  I already miss it each time I switch
back from next to master.

	Steffen
