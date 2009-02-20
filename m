From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Fri, 20 Feb 2009 17:34:30 -0500
Message-ID: <499F2FF6.10601@xiplink.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>	 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>	 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>	 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>	 <499D82BC.7020500@xiplink.com> <76718490902190957td40d425p6b2ae1242060114d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 23:36:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LadyZ-0007UL-Mw
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 23:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbZBTWej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 17:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbZBTWej
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 17:34:39 -0500
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:47159 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZBTWei (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 17:34:38 -0500
Received: from relay2.r2.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id 8D66744C353;
	Fri, 20 Feb 2009 17:34:37 -0500 (EST)
Received: by relay2.r2.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 46D4844C36A;
	Fri, 20 Feb 2009 17:34:37 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <76718490902190957td40d425p6b2ae1242060114d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110898>

Jay Soffian wrote:
> 
> 
>     master            merges  with remote master
>     another-branch    merges  with remote next
>     some-other-branch merges  with remote master
> 
> I could add code to detect whether all the branches merge and then not
> output the space, but, sigh. And I couldn't think of any other
> combination of words that had the same character spacing.

All valid points.  But, dang it, I really think intelligently adding that extra space the right thing to do.

It wouldn't be all that tedious -- you could detect the need for the extra space in config_read_branches() the first time type is set to REBASE, no?

> I'm somewhat confused by "w/remote" making sense to non-English
> speakers as it's English output.

Quite right.  Julian made the point better than I: it's fairly idiomatic.  I think it's reasonable to assume that many users of the English version of git aren't native English speakers.

Plus it throws the alignment with "rebases" lines way off...

>> Second, I think it would be good to also change the format of the 'git push'
>> list, for consistency:
> 
> I left that out on purpose. The only folks with push refspecs put them
> their manually, and the raw refspec is clearer and more concise than
> any English words can convey. That was my reasoning anyway.

Fair enough.

Thanks again!

		M.
