From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Re: PATCH[2/4]: Allow tree-id to return the ID of a tree object
Date: Sun, 01 May 2005 22:46:53 -0700
Message-ID: <4275BECD.7070407@mindspring.com>
References: <426FBBE7.1090806@mindspring.com> <20050427232223.GM22956@pasky.ji.cz> <42708D8E.10003@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 07:41:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSTfv-0000Ey-SM
	for gcvg-git@gmane.org; Mon, 02 May 2005 07:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVEBFq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 01:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVEBFq7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 01:46:59 -0400
Received: from smtpauth07.mail.atl.earthlink.net ([209.86.89.67]:49826 "EHLO
	smtpauth07.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261741AbVEBFq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 01:46:57 -0400
Received: from [68.164.169.208] (helo=[172.16.1.11])
	by smtpauth07.mail.atl.earthlink.net with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.34)
	id 1DSTle-0001F2-CF; Mon, 02 May 2005 01:46:54 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <42708D8E.10003@mindspring.com>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4d2010e176a11bbe0044db220889e50465350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Philip Pokorny wrote:

> Convert commit-id to use the new cg-Xnormid internal script
>
> Signed-off-by: Philip Pokorny <ppokorny@mindspring.com>


Were these patches accepted??  I ask because while I do seem to see the 
addition of the new cg-Xnormid, I don't see that tree-id and friends 
have been updated to use the new file.

But then again, I seem to be having trouble getting my git working 
directory to track or match the current head.  That would be:
    49612c471eebd26efe926a71752e254c1cdc382d
right?

Wait...  Perhaps I'm seeing cg-Xnormid because it was an "other" file 
and therefore left in my directory.  But that still doesn't explain why 
my checkedout cache doesn't show the results of the latest changes to 
cg-help...  Even after running 'cg-update origin'

I'm so confused.  It seems difficult to know exactly what the state of 
your cache actually *is* at any given time.  Shouldn't cg-status tell 
you that you have modified, but uncommited files in your cache?  Is 
there any way to know what the tree-id/commit-id your cache is an 
instance of?  Do you have to 'cat .git/blocked' and 'ls -l .git/HEAD' to 
know?

In clearcase, I could 'ct lsview' and 'ct catcs' to see what my current 
view/cache was.  I can't find the equivalent in cogito...

:v)
