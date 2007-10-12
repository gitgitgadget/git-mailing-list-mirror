From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: yet another workflow question...
Date: Fri, 12 Oct 2007 08:25:57 +0100
Message-ID: <200710120825.58235.andyparkins@gmail.com>
References: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com> <200710111610.55364.andyparkins@gmail.com> <20071011164019.3n4l3rayckck8c4w@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jing Xue <jingxue@digizenstudio.com>,
	Patrick Doyle <wpdster@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 09:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgEuX-0002N8-KY
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 09:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbXJLH0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 03:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757055AbXJLH0G
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 03:26:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:65297 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757073AbXJLH0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 03:26:05 -0400
Received: by nf-out-0910.google.com with SMTP id g13so691462nfb
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=uv6Tr01LYz18u08A2120fH4xScrl08iNRFgrF2M2sGQ=;
        b=ktxVtEL9q49Y8IVdPhYRLbQD+21l9MC7XjfikGZic1j+v46j/G8dvrz5c1H6IyRaMjCRhtEXP6ZXgRlSMPwT6BXJBSsGr5BC00ft3WA5otCq4yLYBmBptUdLHcCFhJ8LmiOl4qPdCG66yyZN1wnm5CqLLSYTnxzJbKu4KV7q9sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WJ9lPBU77lmL3SGzXWR/G7G6NBMymTHqDwMzFKazxiNwEWl9Hhi+vI2amX2rlWEscBAxIGx4NNq24Sfa5ujqhju9Zxk/0drgTZzPKhtu6HnHRjMmvVLB5pa2ekjAhGhP6Vm26ylGXIN5rpa2bWevBVbkjKpwF0TxIx3cgpq37e8=
Received: by 10.78.170.6 with SMTP id s6mr2007988hue.1192173961793;
        Fri, 12 Oct 2007 00:26:01 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id k5sm366667nfd.2007.10.12.00.26.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Oct 2007 00:26:00 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20071011164019.3n4l3rayckck8c4w@intranet.digizenstudio.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60660>

On Thursday 2007 October 11, Jing Xue wrote:
> Quoting Andy Parkins <andyparkins@gmail.com>:
> >  - Mobility.  This one is a bit distributed, but I hope you'll let
> > me have it.
> >    I often do work on my desktop at home, my desktop at work and my
> > laptop. By setting my remotes up correctly in git it's really easy to
> > walk to another system and pick up exactly where I left off from the
> > other computer.  More importantly though, when you accidentally make
> > changes in two places, there is no danger of data loss.
>
> To extend on this point, after picking up the randomly checked-in save
> point on another computer, the save point itself can be easily
> git-reset'ed.  So there won't be commits like "it's utter broken but i
> got to go home" polluting the history.  I find that extremely handy.

Absolutely; in fact I've had times when I've done things like this:

 git merge laptop-branch
 git merge home-branch
 git reset HEAD^^

That is to say, I'm not interested in documenting the merges, I just want to 
bring a set of changes from different places together ready for some proper 
commits, which of course can be done really easily with git add -i.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
