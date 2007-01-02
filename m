From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 16:01:15 -0800 (PST)
Message-ID: <182318.86313.qm@web31812.mail.mud.yahoo.com>
References: <20070101214023.GB23857@fieldses.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 01:01:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1X5j-0004ur-0y
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 01:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbXABABQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 19:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbXABABQ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 19:01:16 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:20879 "HELO
	web31812.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754695AbXABABQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 19:01:16 -0500
Received: (qmail 93193 invoked by uid 60001); 2 Jan 2007 00:01:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=3FrHBNz69euSeWy9l1oDzPtMrbFjBTrI5RckxuICGMwFj33k+AXHyv1b8x+WUh2+AVUNSshBrwGtlFD6nqFjIDl4T4mw0vhJ1S54l4f0PXLOCMe3A5BmndVXoNgG1pchCfN0+NHsEnE/F1JUgJaJr7KW7aNKwUgOCGpdPSwNfQA=;
X-YMail-OSG: 3L7P38oVM1l0vmKNH7rdZF47HiCo5YHvn04nQ3NaCFdfj0loqwf2V9ofXsKXhNmdJYqVrpFzynmM9amVH22cJA.2JGGRR_Ps3EW4UiavYgAQslRtEajnGgr2TiVCdBQ9aw.P_XQffinlo4_qfftNliIQR1ROZGYC5IAfd2Ab_ryJJJb_uYNVMGbm
Received: from [71.84.31.238] by web31812.mail.mud.yahoo.com via HTTP; Mon, 01 Jan 2007 16:01:15 PST
To: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <20070101214023.GB23857@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35749>

--- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Mon, Jan 01, 2007 at 04:39:06PM -0500, J. Bruce Fields wrote:
> > On Sun, Dec 31, 2006 at 05:44:37PM -0800, Junio C Hamano wrote:
> > > How about doing this?  The difference this time around is that
> > > if you have non-wildcard refspec listed first, which usually
> > > is the case for people with established git workflow with
> > > existing repositories, we use the old-and-proven rule to
> > > merge the first set of refs.  An earlier round botched this
> > > completely by basing the logic on lack of branch.*.merge,
> > > which broke for many people.
> > 
> > Updated man page assuming that change; does this look any better?
> 
> Also, resend of the following patch:
> 
> --b.
> 
> [PATCH] Documentation: remove master:origin example from pull-fetch-param.txt
> 
> This is no longer a useful example.
> 
> Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
> ---
>  Documentation/pull-fetch-param.txt |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index e852f41..8d4e950 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -39,10 +39,6 @@ checkout -b my-B remote-B`).  Run `git fetch` to keep track of
>  the progress of the remote side, and when you see something new
>  on the remote branch, merge it into your development branch with
>  `git pull . remote-B`, while you are on `my-B` branch.
> -The common `Pull: master:origin` mapping of a remote `master`
> -branch to a local `origin` branch, which is then merged to a
> -local development branch, again typically named `master`, is made
> -when you run `git clone` for you to follow this pattern.

So is this no longer the case?

Can someone please bring me up to date?

What is going on?

    Luben



>  +
>  [NOTE]
>  There is a difference between listing multiple <refspec>
> -- 
> 1.5.0.rc0.gac28
> 
> 
