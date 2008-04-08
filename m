From: "Abraham Arce" <abraham.arce.moreno@gmail.com>
Subject: Re: git cloning fails
Date: Tue, 8 Apr 2008 14:40:14 -0500
Message-ID: <cb8016980804081240l4c7f42eeyd51a4a33248dabd2@mail.gmail.com>
References: <cb8016980804080600se489c8bv5b79186be284163f@mail.gmail.com>
	 <20080408131347.GB22623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 08 21:41:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjJgk-0001bi-CN
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 21:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286AbYDHTkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755215AbYDHTkR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 15:40:17 -0400
Received: from hs-out-0708.google.com ([64.233.178.249]:53622 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259AbYDHTkP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 15:40:15 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1576531hsl.5
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GNtE/axMeHv99UXZ0yQHkX3z42HHiOr2a+8nqjSe8Eg=;
        b=liceLtCal9RewtTZizfJyfT7ZMDJWiTYW9awMtzlIF5vYAtAJn5X60WMQAmLhSKrMieCGF07UHPbK13aLJBG1PMT7VqELp7kUG+F6ZbhVKi7WdOkf+YjflcIBRk6c2KfDa+AfmmTAdYBP9bfjK+ebqPtjHRl6LEjhAsCxMUhv/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c6C84C0uMZNK6m6fEW2UrnQ213rk1aBilLPuEasEfrlF7FSafgWTTakGmI8kEKylMBUYP4pzc5/PMGkYzno4WmsxJp2bbFXVK7LiSPEaYPCkDAHeDiexLRrLAxxIrqhI/GVYLdUKNYMkd3grDGak7dKggO7vLt9h8kqri0MIx1M=
Received: by 10.100.13.5 with SMTP id 5mr551818anm.139.1207683614835;
        Tue, 08 Apr 2008 12:40:14 -0700 (PDT)
Received: by 10.100.12.8 with HTTP; Tue, 8 Apr 2008 12:40:14 -0700 (PDT)
In-Reply-To: <20080408131347.GB22623@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79020>

On 4/8/08, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 08, 2008 at 08:00:20AM -0500, Abraham Arce wrote:
>
> > While cloning git repository
> >
> > git clone http://www.kernel.org/pub/scm/git/git.git
> >
> > I've received the following message:
> >
> > got 33682a5e98adfd8ba4ce0e21363c443bd273eb77
> > error: Couldn't get
> > http://www.kernel.org/pub/scm/git/git.git/refs/tags/gitgui-0.6.0 for
> > tags/gitgui-0.6.0
> > The requested URL returned error: 404
> > error: Could not interpret tags/gitgui-0.6.0 as something to pull
>
> This works just fine for me. Which git version are you using? Does the
> problem still exist if you try again? If that URL did in fact return a
> 404, it sounds more like a kernel.org problem.

Thanks!
I've tried 3 times, the git version I am using is 1.5.0.6.

>
> -Peff
>
