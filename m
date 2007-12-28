From: adr3nald0s@gmail.com
Subject: Re: Anomalous conflicts during git rebase
Date: Fri, 28 Dec 2007 12:33:41 -0600
Message-ID: <m3fxxm7jp6.fsf@euroclydon.lan>
References: <m3ir2ju5ce.fsf@euroclydon.lan>
	<alpine.LNX.1.00.0712271840030.13593@iabervon.org>
	<m3k5my7r1u.fsf@euroclydon.lan>
	<alpine.LNX.1.00.0712281246330.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: adr3nald0s@gmail.com, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 19:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8Jxl-0006lp-4D
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 19:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbXL1S3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 13:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbXL1S3M
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 13:29:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:35594 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbXL1S3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 13:29:11 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1033712wxd.4
        for <git@vger.kernel.org>; Fri, 28 Dec 2007 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:cc:subject:in-reply-to:user-agent:references:from:date:message-id:mime-version:content-type;
        bh=fqre5rOlH0r1J61EIkX62ZBNu9aFL3ib5WC464FbMdc=;
        b=E0WlaNwWAr5sxftYU2KkPP6ZDBVGyHmIFxQ7G9N05VFWcuxEEPoyfQhnMhSndM60YLW0a1fdDUX/tOKue2SuACWDEkAYFgi43TfNm6f0ec1T1mFieuAMH+flCUwVzxTfpra4giCaias8UHu2cNoZkpA9khlKEP7H00MiBbi82jE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:in-reply-to:user-agent:references:from:date:message-id:mime-version:content-type;
        b=ZFyHofhZbXGyPRvlDaohIIbhzZsavuL1bnnoffc9xkedEYPFcelJ5dO7/DSLmcx5nZa+0lQziseJ+GopO3ASJy2QtT2+pBsjFaAi++7BDmGCzP4N6cPlqZ/2arfYrnGCts5//JSUsKRVz/phR0TzqXO+r6MFGkUnx+bvWjgWMm0=
Received: by 10.70.111.2 with SMTP id j2mr6451902wxc.30.1198866550182;
        Fri, 28 Dec 2007 10:29:10 -0800 (PST)
Received: from euroclydon.lan ( [66.148.187.210])
        by mx.google.com with ESMTPS id h13sm15164419wxd.1.2007.12.28.10.29.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Dec 2007 10:29:08 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0712281246330.13593@iabervon.org> (Daniel Barkalow's message of "Fri\, 28 Dec 2007 12\:58\:40 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69293>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Fri, 28 Dec 2007, adr3nald0s@gmail.com wrote:
>
>> When you say it linearizes history how is this done.
>
> Rebase takes a list of commits that are in the current branch and 
> aren't in the origin branch as what it's going to work on; these are 
> ordered in some arbitrary way such that children always follow parents. It 
> then resets to the origin branch's commit, and, in sequence, cherry-picks 
> each of the commits in the working list.

Thanks again for the clear explanation.

> In theory, of course, it could try to resolve conflicts by looking through 
> the rest of the list for merges which would have those conflicts and using 
> what that merge did.  

Given the implementation, this would be just plain ugly.  I would not
want to attempt to implement something like this, nor would I expect
anyone else to do so.
