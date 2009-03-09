From: John Tapsell <johnflux@gmail.com>
Subject: Re: Help designing work flow
Date: Mon, 9 Mar 2009 13:22:49 +0000
Message-ID: <43d8ce650903090622j51b73801gb4be62a7f50029a4@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F07D30@EXCHANGE.trad.tradestation.com>
	 <49B4F5A9.5060304@op5.se>
	 <43d8ce650903090444n352f310fs9cd4b8b0184be010@mail.gmail.com>
	 <49B50B3C.50700@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Dlugosz <JDlugosz@tradestation.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 09 14:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgfSr-0000ai-Dd
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 14:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbZCINWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 09:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbZCINWw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 09:22:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:11527 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZCINWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 09:22:51 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1658091rvb.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qm3VK2JoRbsv7T4paG0zvbgjPjrdYu2jU1gbdx48zoM=;
        b=FrKdR4pRdSnWqTTjmVNGoWgGZIV/gUxXdxaT8qoXKOCDwxRYUz6yy8RoHaJAPkIPoQ
         1p9XwkUviCMWKFKRQbB48/qY8/fOP5ZbyXti9LvR/dqIzI9f0YEjG5fbdp99vGtu5H1y
         bw3rI5WPjNQwBCQQAWWWVPoG4cBI8m+06/wbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bFcqMXz/TaGdGycWEt3x1hYknqn3XTAXW1rx2Hsd0f/wQACcxuE2zuOCUYB+MbCVBp
         +qqmuxKB2yGWt0ZGGD8/CRDTTIAkK88HLRLwhI43V5rjUvqBl/CmZunGkRKFrjQvx0P4
         Nf1+UDlbPFv2cPRXrgOLpUrVg4gsXC3SMb74s=
Received: by 10.142.148.19 with SMTP id v19mr2294711wfd.164.1236604969359; 
	Mon, 09 Mar 2009 06:22:49 -0700 (PDT)
In-Reply-To: <49B50B3C.50700@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112694>

2009/3/9 Andreas Ericsson <ae@op5.se>:
> John Tapsell wrote:

> Not really. If bugs are in "unrelated" areas (if the topic changed some
> API without changing its' other callers, fe), you can backstep between
> each commit on the merged branch, remerge that commit (instead of the
> tip) and then run the tests again.

Doing that manually?  Sounds really complicated, especially if the
merge is nontrivial.

> But really, such bugs should have
> been detected prior to merging the branch, and in any case "git bisect"
> will find the commit that introduced the bug for you either way.

How will you detect bugs that arise from merging two trees, before you
merge them?

> For next time, please cut away those parts of the email you didn't
> reply to. I had to scroll down to the bottom to make sure you hadn't
> written more.

I'll try sorry.  Most email clients will hide the quoted text - there
might be an option for that in your client?

John
