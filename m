From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [RFC] faking cvs annotate
Date: Fri, 16 Dec 2005 17:37:32 +1300
Message-ID: <46a038f90512152037u66993aadg566a2a47abd279c9@mail.gmail.com>
References: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com>
	 <Pine.LNX.4.63.0512160229140.6323@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 05:38:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En7Ld-0008Q8-3U
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 05:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVLPEhe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 23:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVLPEhd
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 23:37:33 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:10904 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932117AbVLPEhd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 23:37:33 -0500
Received: by wproxy.gmail.com with SMTP id 57so518250wri
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 20:37:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jDhsQiA4/etLIZ7NUDRiUOiQc7/2XAFvzMWR+z6fn375lB6Di//aJ3q35RtlPj8PJQHchQdzBpCR65KcvQCv56KQaGRDHaNvyh6TRGPnjmefzXR8ilAzwHR94pL+6qEY7J20TLHWqF0Nw+M1uPR0W+QJ8Uba2mGZmX4BDUhzHoE=
Received: by 10.54.67.6 with SMTP id p6mr3227745wra;
        Thu, 15 Dec 2005 20:37:32 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Thu, 15 Dec 2005 20:37:32 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0512160229140.6323@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13729>

On 12/16/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> For starters, you could use my attempt:
> http://www.gelato.unsw.edu.au/archives/git/0508/7171.html

Not bad at all! I might simplify it a bit (won't need the commitmsg
parsing), and see if how fast I can make it.

> It does not fool any CVS user,

Ah, no. Those have been fooled already ;-)

> However, I learnt to use git-whatchanged in the meantime, and I'll
> probably never go back.

Of course. I'm trying to meet a few the expectations of popular cvs
clients (cli, TortoiseCVS, Eclipse, etc). If a workable git-annotate
falls out of this, oh well.

OTOH, yours didn't get included. Any particular reasons? (other than
stressing the point that you should use whatchanged/pickaxe?)

Also! On 12/16/05, Junio C Hamano <junkio@cox.net> wrote:
> I haven't actively done anything but one of the good things that
> could happen is to split out the access routines for annotate
> database qgit build when run the first time in the repository,
> and make them available to other Porcelains.  There is no need
> to reinvent the wheel.

That would be cool! Though my particular implementation may be a tad
unconventional in its view of the "file history" as a strictly linear
thing. Normal git porcelains don't even blink when dealing with
branching/merging development histories.

cheers,


martin
