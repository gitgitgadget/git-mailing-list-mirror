From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Sun, 22 Jul 2007 15:12:03 -0400
Message-ID: <9e4733910707221212v2f6cc1c4kf7a35e84f351e4cd@mail.gmail.com>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	 <alpine.LFD.0.999.0707221205080.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:12:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgqh-0001ax-QB
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762296AbXGVTMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762140AbXGVTMG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:12:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:7951 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760743AbXGVTMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 15:12:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1729202wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 12:12:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s7Qm0sXCCkBSfxqoK8iw/1lZSgOcCGPF8GBcDqtL995xz9sBpAZDG0EzlKAzzzzLw01YiOHMNWJBEy4cn3lpVw1zgNZjeL5SSod1yV2kSMipnhYeGbdCZY/m55U3cWBOnHa6OuSEmm6dhUEHkwgxUZo+btCSRms9iPa9yFY2smU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sgscq7kiajna4XRvanq5CvmvqzJ/tKCcxedOuOaVZzDDlfNK4EgqRheJzl8gQcfhEMuZWU0Xhx3JIeRjDxxQgLNTvvZ/0yaNmMAc7T53WlduoldB8pz8IzHLp6aVeWBoKDuQ2aSbyzrp3pLuqj7kaFP09r3AQlVc6BKAHy5HWCk=
Received: by 10.114.110.1 with SMTP id i1mr2299715wac.1185131523692;
        Sun, 22 Jul 2007 12:12:03 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 22 Jul 2007 12:12:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0707221205080.3607@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53298>

On 7/22/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Sun, 22 Jul 2007, Jon Smirl wrote:
> >
> > It would really be useful if git diff had an option for suppressing
> > diffs caused by CVS keyword expansion.
>
> I really think it's not a "git diff" issue, but it might be a "import"
> issue.
>
> IOW, I think you'd be a *lot* better off just not importing those things
> in the first place (which is what CVS does internally), or possibly
> importing them as two trees (ie you'd have the "non-log" version and the
> "log expansion" version, so that you can track and compare both).
>
> Doing the thing at "diff" time is certainly possible, but this is simply
> much better done as a totally independent preprocessing phase. The diff
> handling is already some of the more complex parts (and very central), it
> would be much simpler and efficient to not try to make that thing fancier,
> and instead solve the problem at the front-end.

These diffs are coming from companies doing GPL compliance without
really wanting to comply. CVS servers are not made available.


>
>                         Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
