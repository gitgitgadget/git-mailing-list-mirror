From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Adding color to git diff output.
Date: Wed, 12 Apr 2006 17:52:36 +0200
Message-ID: <81b0412b0604120852gaa61e91s5f9ae9f4e061bd56@mail.gmail.com>
References: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE>
	 <7virpf4sg4.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
	 <BAYC1-PASMTP119CAD2588D00764DB3EA3AEC20@CEZ.ICE>
	 <Pine.LNX.4.64.0604111801270.14565@g5.osdl.org>
	 <81b0412b0604120038q2e4aef8cn55ba4cfa68e18b34@mail.gmail.com>
	 <Pine.LNX.4.64.0604120846000.14565@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 17:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FThe4-0001Wu-Dz
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 17:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWDLPwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 11:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWDLPwh
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 11:52:37 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:39714 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750945AbWDLPwh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 11:52:37 -0400
Received: by pproxy.gmail.com with SMTP id i49so1723149pye
        for <git@vger.kernel.org>; Wed, 12 Apr 2006 08:52:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=etoiKipkq3gORStx/WQ1xpY2+3J+Qk2LKy/H5by2GvQqDQ9AgxbX18/QGrd+RkXe/NDbJeZ89VW1pxemk6BEkmzpgnxWgqu1+MaR8Q4Tg8fc9r2vJzV1k01fzCleDKtn+lKNpF01Dgxio2uXHFetHqQiLA6J7FpjkBB/3nngEts=
Received: by 10.35.12.13 with SMTP id p13mr126452pyi;
        Wed, 12 Apr 2006 08:52:36 -0700 (PDT)
Received: by 10.35.41.18 with HTTP; Wed, 12 Apr 2006 08:52:36 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604120846000.14565@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18633>

On 4/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Maybe use "-t" here? I have at least one system which has no tty installed.
> > Like this:
> >
> >   if [ -n "$GIT_DIFF_PAGER" -a -t ]; then
>
> I assume you mean "-t 1". It needs the FD number. But yes.
>

yes, tpyo
(bash doesn't give an error here, btw. Just always 0)
