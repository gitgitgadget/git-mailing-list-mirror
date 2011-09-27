From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 20:34:02 -0600
Message-ID: <3539dab7-0fb2-4759-baaf-8e22efab2904@email.android.com>
References: <4DF6A8B6.9030301@op5.se> <201109261552.04946.mfick@codeaurora.org> <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk> <201109261812.31738.mfick@codeaurora.org> <97c45128ddeb8269273a4431b3941478@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 27 04:57:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8NrL-0001lC-49
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 04:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab1I0C5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 22:57:22 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:18207 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab1I0C5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 22:57:21 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6481"; a="121651108"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 19:57:21 -0700
Received: from [192.168.1.190] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 2591E10004BE;
	Mon, 26 Sep 2011 19:57:21 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <97c45128ddeb8269273a4431b3941478@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182206>



> Julian Phillips <julian@quantumfyre.co.uk> wrote:
>On Mon, 26 Sep 2011 18:12:31 -0600, Martin Fick wrote:
>That sounds a lot better.  Hopefully other commands should be faster 
>now too.

Yeah, I will try this in a few other places to see.

>> Thanks way much!!!
>
>No problem.  Thank you for all the time you've put in to help chase 
>this down.  Makes it so much easier when the person with original 
>problem mucks in with the investigation.
>Just think how much time you've saved for anyone with a large number of
>
>those Gerrit change refs ;)

 Perhaps this is a naive question, but why are all these refs being put into a list to be sorted, only to be discarded soon thereafter anyway?  After all, git branch knows that it isn't going to print these, and the refs are stored precategorized, so why not only grab the refs which matter upfront?

-Martin 
