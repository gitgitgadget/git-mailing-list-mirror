From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 6 Jul 2007 18:22:51 +0200
Message-ID: <81b0412b0707060922sf0e3c17wcbd55dd65e1c1e14@mail.gmail.com>
References: <468E59B3.7080007@nrlssc.navy.mil>
	 <20070706151145.GA15341@informatik.uni-freiburg.de>
	 <468E5E31.8040504@nrlssc.navy.mil>
	 <Pine.LNX.4.64.0707061631560.4093@racer.site>
	 <468E64F9.9080805@nrlssc.navy.mil>
	 <81b0412b0707060859u6a1c3a24p4399a71d84038615@mail.gmail.com>
	 <20070706155902.GA17489@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=" 
	<ukleinek@informatik.uni-freiburg.de>,
	torvalds@linux-foundation.org, gitster@pobox.com,
	mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
To: "Vincent Hanquez" <tab@snarc.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 18:22:58 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6qa9-0001MK-GB
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 18:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760239AbXGFQWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 12:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758589AbXGFQWy
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 12:22:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:3115 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbXGFQWy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 12:22:54 -0400
Received: by wr-out-0506.google.com with SMTP id i30so212175wra
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 09:22:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tpz9ys6to1uRbPm0MDiKMtBoOnLV5CO9uLj7bCz17083wsqefS9+hqL+eWpA3tzzI8YjogmC7CAdjUW91B/BpBsJ4tqYfDcK81pjmlVIiLfCHPWothxN0GCUFbFxSfteFN7d2n9GZblKQmczDog61ThoB8bz/NTD+X6FPt1+IOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rSvbW6UBek3XTAgPj+w1SVl4qAZ5QxADg6GjVZyfOMj5HxEQF9cCtDJI3tHepyi8CeSAUEp2URPrMn6fsdJiM3iWHPEmHRR2LhNCUUBcAmMRdc7ZAEdhKzzjuZ2pAW3foP654QEau2eKFOBBcoxhCQo8qLuvQC5HwFdEaDINJVg=
Received: by 10.78.159.7 with SMTP id h7mr392354hue.1183738971811;
        Fri, 06 Jul 2007 09:22:51 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Fri, 6 Jul 2007 09:22:51 -0700 (PDT)
In-Reply-To: <20070706155902.GA17489@snarc.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51772>

On 7/6/07, Vincent Hanquez <tab@snarc.org> wrote:
> On Fri, Jul 06, 2007 at 05:59:19PM +0200, Alex Riesen wrote:
> > On 7/6/07, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> > >
> > >Is the recommended tab stop 8 characters as it is for linux? or 4?
> > >
> >
> > Tab is always 8 spaces. It is indentation which can be 8, 4, 3, 2, and even
> > 1.
> > It is 8 in Git.
>
> tab isn't 8 spaces. a tab is a tab.

Of course. It is used to indent the text to the next position
which multiple of 8.

> It's usually *APPEARING* at 8 spaces. they *may* appears as a different
> size (to fit anyone preferences), as long as they stay as a tab (not
> expanded), and that nobody is aligning on tabs.
>
> => this way the how many spaces should indentation be has no meaning
>    since everybody can choose it on their own terminal/display without
>    setting any value across readers of the code.

The symbol in question, HT, is used to indent source in the project Git.
