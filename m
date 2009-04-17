From: Scott Chacon <schacon@gmail.com>
Subject: Re: Presentation Ideas
Date: Fri, 17 Apr 2009 11:51:24 -0700
Message-ID: <d411cc4a0904171151w52eb9025s5e60309f1d929f84@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AB285C4@EXCHANGE.trad.tradestation.com>
	 <20090417184109.GA30489@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Dlugosz <JDlugosz@tradestation.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:58:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LutGN-0006gg-Lv
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbZDQS4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 14:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478AbZDQS4g
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:56:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:61806 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbZDQS4g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 14:56:36 -0400
Received: by fk-out-0910.google.com with SMTP id 18so463846fkq.5
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d/g9AKtYD05O7N+udenbvP8T480Qwa8vSj3tzz66PIg=;
        b=fwn1ZAiNntdfwSLgItLOabQzxFnYfBf83bQztlmGs3NC6ZQyJC8a87QDX290c5+f56
         9hi+8fSfgBi2uYJ78Yh9ipNPPIZSP3lb7FYz7d3c6vZL7Jp5Lt4gMs3Mq93n1DJxDXaJ
         uPILDvMPnjkZBNnlVWkA+VtqWdN4vhZVi7t/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kdDOwLtc2TrcUhmkeFjAR8lHCYoxvjERUct706so4oJmB6oPI7BvXh3i+5d+CUfoP2
         H1QXaLDedNICMDo7vPalKH8rS5OpIPFfOq63X9YNLmpS+py64Yxsz3IGRko/GUyJnbbH
         xC1Bi+0mnXbrWoDVzaroEJupbnNqbaG6czm+o=
Received: by 10.223.108.196 with SMTP id g4mr877649fap.36.1239994284420; Fri, 
	17 Apr 2009 11:51:24 -0700 (PDT)
In-Reply-To: <20090417184109.GA30489@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116777>

On Fri, Apr 17, 2009 at 11:41 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 17, 2009 at 11:29:36AM -0400, John Dlugosz wrote:
>
>> I'm going to be giving a presentation on git to other development te=
ams.
>> Is there any good material around I can borrow from or use as
>> inspiration?
>
> There seem to be two popular ways to present git, and which you prefe=
r
> to see seems to be a matter of personal learning style. They are:
>
> =C2=A01. top-down; i.e., explaining commands in terms of workflow and
> =C2=A0 =C2=A0 accomplishing user-oriented tasks, and trying to minimi=
ze details
> =C2=A0 =C2=A0 unnecessary to the task at hand
>
> =C2=A02. bottom-up; i.e., explaining the data structures of git first=
, upon
> =C2=A0 =C2=A0 which you can explain the behavior of commands, out of =
which you
> =C2=A0 =C2=A0 can see how to piece together tasks.
>
> I prefer (2) myself. It's a steeper learning curve, but I think it pa=
ys
> off when advanced topics in git just make sense (but then, I also thi=
nk
> that normal users should understand sed and awk).
>
> If you are interested in (2), I have often seen this page referenced:
>
> =C2=A0http://eagain.net/articles/git-for-computer-scientists/
>
> I also did a presentation of git to some CS grad students that was ve=
ry
> bottom-up. The slides are somewhat mediocre, but I would be happy to
> share them if you like.
>
> I think I stole a few diagrams from Junio's OLS talk, which has some
> nice images (I especially like the symbolic view of the 3-way merge):
>
> =C2=A0http://members.cox.net/junkio/200607-ols.pdf
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

I have put a number of my presentations online at

http://github.com/schacon/git-presentations

There are four in there now, but I'll add the one I'm giving at
RailsConf in a few weeks once it's completed.  Most are high level or
top-down, the railsconf08 is more bottom-up.

Scott
