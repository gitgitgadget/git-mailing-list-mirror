From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: [PATCH 1/2] Throw IllegalStateException if DirCacheEntry has
 not been fully initialized.
Date: Tue, 11 Aug 2009 18:15:18 -0700
Message-ID: <4A8217A6.8060102@tuffmail.com>
References: <1250038581-31241-1-git-send-email-grek@tuffmail.com> <alpine.DEB.1.00.0908120303240.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Grzegorz Kossakowski <grek@google.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 12 03:15:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb2R8-0006UX-3l
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 03:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZHLBPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 21:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019AbZHLBPU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 21:15:20 -0400
Received: from mxout-08.mxes.net ([216.86.168.183]:47702 "EHLO
	mxout-08.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbZHLBPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 21:15:19 -0400
Received: from glacegreek.mtv.corp.google.com (unknown [216.239.45.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 513A6509B3;
	Tue, 11 Aug 2009 21:15:19 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <alpine.DEB.1.00.0908120303240.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125638>

Johannes Schindelin wrote:
> Hi,
>
> On Tue, 11 Aug 2009, Grzegorz Kossakowski wrote:
>
>   
>> From: Grzegorz Kossakowski <grek@google.com>
>>
>> When mode's object type of entry equals to Constants.OBJ_BAD it's a sign
>> of bad (uninitialized) state of an entry and not of problems with merging.
>>
>> Signed-off-by: Grzegorz Kossakowski <grek@google.com>
>> ---
>>  .../org/spearce/jgit/dircache/DirCacheTree.java    |    3 ++-
>>     
>
> That's great, but next time, please prefix your mail subjects with [JGIT 
> PATCH] so that people who don't speak Java know that this is not for them.
>   
Sorry for that. I'll remember about it next time.

-- 
Grzegorz Kossakowski
