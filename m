From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] archimport improvements
Date: Thu, 24 Nov 2005 09:25:31 +0000
Message-ID: <46a038f90511240125s1617cd44n868d77204ea87f78@mail.gmail.com>
References: <20051112092336.GA16218@Muzzle>
	 <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
	 <20051124074605.GA4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 24 10:27:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfDMM-0004Un-5K
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 10:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVKXJZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 04:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVKXJZd
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 04:25:33 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:45591 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751327AbVKXJZc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 04:25:32 -0500
Received: by xproxy.gmail.com with SMTP id i29so1259237wxd
        for <git@vger.kernel.org>; Thu, 24 Nov 2005 01:25:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pjFuTOMMg601r5JKupOPfpAjxPnGRJk8j7ewqOO/olbklThG6XdGcEHlzzEJOnXOcihSKW6lYRretkjgwPCW2RBGKJUnEsK7VtAZQ6nEhucKfb5JXqKonJKe5uZ45DVIerAX/9m9aLjZhQsuzXrt7w8+9yk4JhBCHSrmee+1WLk=
Received: by 10.64.232.18 with SMTP id e18mr6931251qbh;
        Thu, 24 Nov 2005 01:25:31 -0800 (PST)
Received: by 10.64.242.12 with HTTP; Thu, 24 Nov 2005 01:25:31 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051124074605.GA4789@mail.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12699>

On 11/24/05, Eric Wong <normalperson@yhbt.net> wrote:
> Ok, I didn't expect you guys to have 12k of files in your trees.  None
> of your source trees are remotely close to that size (but I have many
> more changesets).  I'm surprised you guys were able to put up
> with Arch in the first place!
>
> 125m58.431s with my method.
>   8m24.504s with yours :)
>
> All of my usual source trees imported 1k changesets in 10-15 minutes

:-) I'm happy that you managed to wait patiently for it to complete --
all my attempts to run your import code were ended by a sleepy ctrl-c.

> Patches on the way.

Cool -- will review, but may take a couple days, as I'm away from home
this week.

> OTOH, the time spent importing the bulk of the history is a one-time
> operation for most people and I'd much rather it get things as right as
> possible and move on.

Hmmm. Some teams -- such as mine -- just run it every couple hours to
maintain an Arch2cvs gateway.

More later,


martin
