From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Tue, 6 Jun 2006 17:55:08 +1200
Message-ID: <46a038f90606052255s62cda81bt62d7442beb26658a@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <9e4733910606022128h23ff94fbg3fcb4fa191254b5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 07:55:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnUX6-0004bh-Vq
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 07:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWFFFzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 01:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWFFFzK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 01:55:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:63277 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932087AbWFFFzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 01:55:09 -0400
Received: by wr-out-0506.google.com with SMTP id i22so1146442wra
        for <git@vger.kernel.org>; Mon, 05 Jun 2006 22:55:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FNolLt3OrUzNvmkpwqJwlQ/d3o4n2KunXwWPHVXoreFhW25pUVfZT1ir3wJb0VU+H7UPFVFjNPjEdW7lKSi3OlX7ZmkZDba3SNIE9YDQypUHQ6+tfvARw6zuSZ4vdb9UGg9tfvR2ZtTsPoe1twHhavD/XW7y7E5U2jFvM8EQTo4=
Received: by 10.54.148.6 with SMTP id v6mr401884wrd;
        Mon, 05 Jun 2006 22:55:08 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Mon, 5 Jun 2006 22:55:08 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606022128h23ff94fbg3fcb4fa191254b5a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21363>

On 6/3/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > With the attached patch you can parse the entire Mozilla tree. The
> > tree has over 100,000 files in it and about 300 branches.
>
> I was a little low with these counts, more like 110,000 files and some
> parts of the tree have 1,000 branches. Total tree size is 3GB.

I don't think it really has that many branches. If I am to believe
cvsps (which took 3GB to walk the history), it has some branches with
recursive loops in their ancestry (MANG_MATH_BRANCH and
SpiderMonkey140_BRANCH have eachother as ancestors!?), 197969 commits
and 796 branches.

This repository has been mangled quite badly. Don't know what you guys
did with it, but it sure isn't pretty. I'm working on getting
git-cvsimport to get through a complete import.

cheers,



martin
