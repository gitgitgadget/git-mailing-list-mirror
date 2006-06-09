From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 17:46:47 -0400
Message-ID: <9e4733910606091446u5660d7b0q1f2e118abcd057c9@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
	 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
	 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
	 <Pine.LNX.4.64.0606091655420.2703@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 23:47:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fooof-0008On-OK
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 23:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbWFIVqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 17:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030533AbWFIVqu
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 17:46:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:45039 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030530AbWFIVqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 17:46:49 -0400
Received: by nz-out-0102.google.com with SMTP id k1so770781nzf
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 14:46:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E1IsF/JffuFzQfuUaPLwiwQ17tPikuB2K1H68Z7SLFAPtGzdzeHSr+Z7WYpWELDS1z3Zx3qs6K50ED26YEwaL8UdmoyE6aYcYmGp/ZT72x6JmElCRAZ6ATqh5uasCivHcDwUPERLfUrl/5sMxs/b+kfCExwHs6IU4XLgJ8mHTN0=
Received: by 10.36.247.27 with SMTP id u27mr4804881nzh;
        Fri, 09 Jun 2006 14:46:48 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 9 Jun 2006 14:46:47 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606091655420.2703@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21563>

On 6/9/06, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 9 Jun 2006, Jon Smirl wrote:
>
> > I haven't come up with anything that is likely to result in Mozilla
> > switching over to git. Right now it takes three days to convert the
> > tree. The tree will have to be run in parallel for a while to convince
> > everyone to switch. I don't have a solution to keeping it in sync in
> > near real time (commits would still go to CVS). Most Mozilla
> > developers are interested but the infrastructure needs some help.
>
> This is true.  GIT is still evolving and certainly needs work to cope
> with environments and datasets that were never tested before.  The
> Mozilla repo is one of those and we're certainly interested into making
> it work well.  GIT might not be right for it just yet, but if you could
> let us rsync your converted repo to play with that might help us work on
> proper fixes for that kind of repo.

I'm rebuilding it on my shared hosting account at dreamhost.com. I'll
see if I can get it built before they notice and kill my process. My
account there is on a 4GB quad xeon box so hopefully it can convert
the tree faster. My account has 1TB download per month so rsync will
be ok. Not bad for $12 the first year.

It would take over a day to rsync it off from my home machine.

> > Martin has also brought up the problem with needing a partial clone so
> > that everyone doesn't have to bring down the entire repository.
>
> If it can be repacked into a single pack that size might get much
> smaller too.
>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
