From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: newby question about merge.
Date: Wed, 16 May 2007 21:35:46 +0200
Message-ID: <46d6db660705161235k130fabc2i6acb45d71b85891e@mail.gmail.com>
References: <20070515113820.2621c8d5@localhost.localdomain>
	 <f2c23k$dm0$1@sea.gmane.org>
	 <Pine.LNX.4.64.0705161241560.6410@racer.site>
	 <46d6db660705160721u24e43f7bmb5171555158089fb@mail.gmail.com>
	 <Pine.LNX.4.64.0705161542540.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 16 21:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoPHw-0007WE-UZ
	for gcvg-git@gmane.org; Wed, 16 May 2007 21:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277AbXEPTft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 15:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757036AbXEPTft
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 15:35:49 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:12781 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689AbXEPTfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 15:35:48 -0400
Received: by nz-out-0506.google.com with SMTP id r28so691410nza
        for <git@vger.kernel.org>; Wed, 16 May 2007 12:35:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bEWzd5/NB+HT+Coad38NH/CWiqG3rSosB8Dw2iuSePZtVLGAnp3KHVxHqSWxidvuvg1BLJ3KsSra7AChlBV1Y2/odnNIFbqBz4WPnOSmqMt8ygwdZCrD20ilHqzKQHeUjT/1r4EWsflJFz2pzWSyCbv+yyQouX2/bez6s6zYBe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kjWoRVZspvZvFwIgg4xDOkytaEEhYhk2C552CUx+H4UIYHIg9c+nTIxdZbo11Oi4BUbmY+K/ae8+ldScyRWssdceVtDfO+9+oe6jFTkeJ1oBxyX87Rk9J+5aiDYiACNMsSw+txGfVqVozk0z1RswBp1vVqQr0BpSJ/7vh3dsAX8=
Received: by 10.115.16.1 with SMTP id t1mr2452189wai.1179344146896;
        Wed, 16 May 2007 12:35:46 -0700 (PDT)
Received: by 10.115.76.5 with HTTP; Wed, 16 May 2007 12:35:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705161542540.6410@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47452>

On 5/16/07, Johannes Schindelin wrote:
> [please, Christian, do not cut the Cc: list. In particular, do _not_ cut
> the person you are _responding_ to from the Cc: list]

[ oops. I thought some of us sometimes receive doublets of emails,
being in reply_to and cc of git@vger.kernel.org. point *taken* ]

> > I could be wrong, but git-show works in this way only after version 1.5,
> > right ?
>
> Yes. So what?

I also sometimes use old git versions (I still consider 1.4.4.4 as a reference).

I know the API changes frequently. But engineers don't like too many changes
usually, and like to carry a portable/stable way. "git cat-file" at
least behaves
as it was in 1.4.x :)

> > As far as I can tell, using git-1.4.4.4 or ealier, you would still need
> > git-cat-file -p... to fix this merge conflict.
>
> If you are using pre-1.5 Git, you should really, really upgrade.

While in principle I'd agree, in practice I do not. Git API changes
increased learning curve for people who actually started with git a
year ago.

Note this is a git user feedback, not a git developer feedback.

>
> If you do not want to do that, then _at least_ you should not confuse
> newbies, who _should_ use Git 1.5+.

hey, I'm not a newbie anymore! :)

it's just that today, on a machine I only had git-1.4.4.4 to play with,
I had to do a merge of 2 private branches ( aufs and squashfs) on
linux-2.6.21... I had 3 smalls conflicts to fix and I saw this thread...
and decided to stick with git-cat-file on this fix.

> And most importantly: if you suggest a change in the man pages, it should
> reflect the new Git versions, _not_ the old ones.

nope, I would not dare to suggest. I'm not a git developer: just a git user :)

> Okay?

yep

-- 
Christian
