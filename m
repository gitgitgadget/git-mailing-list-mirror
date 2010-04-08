From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull with "no common commits" : danger?
Date: Thu, 8 Apr 2010 15:55:23 -0400
Message-ID: <t2j3abd05a91004081255h58d2aca3leeb41adf53dc6a4f@mail.gmail.com>
References: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com> 
	<20100408054349.GA6067@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 21:55:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzxpT-0002jc-RB
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 21:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933373Ab0DHTzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 15:55:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49563 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933315Ab0DHTzp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 15:55:45 -0400
Received: by wyb39 with SMTP id 39so161463wyb.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OasZ8+I9wnUrdlnC4/wXkP3B9Q/PV5brz2A9UVPsdm8=;
        b=cd6cjV8XINSd9raKd+D57dI+uOVCVPjfJvk9xttGkMGpBI75QzlIEc9WZxsq8BlwYG
         l900rynHAPJP7FXYLvrr7LoZwy5hrUWanKAjFJIgC5Oal3kkI9ZM4S4W9/kNrnR/Mb0x
         VcEb7cEBVXeK9S5XwD17hKrs+2QdB+78f04hY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Weo2jaaVhOARj3y6k5yYhd48eYwseTo7MM/B0NZq/jQtnfkP1iRB6CqupTrrEkOvqN
         JSgQMEjjkF+L4Mh/R84qncF7ZuaW713xFocYGmEP39erLUh3g1VZAmS91Y/4sCtvGY6u
         xUtoJ7s+1Dmjvo+CkcYFMlQHdV5ZzEbPnb9/w=
Received: by 10.216.170.8 with HTTP; Thu, 8 Apr 2010 12:55:23 -0700 (PDT)
In-Reply-To: <20100408054349.GA6067@progeny.tock>
Received: by 10.216.172.70 with SMTP id s48mr299152wel.114.1270756543167; Thu, 
	08 Apr 2010 12:55:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144377>

Jonathan Nieder <jrnieder@gmail.com> writes:
>
> ...
>
> On the other hand, =91git pull=92 is a little different. =A0The fetch=
 has
> very little cost because it=92s interruptible, but the merge could
> result in two unrelated pieces of history being merged, requiring
> the user to use =91git reset --keep HEAD^=92 to get back to the
> previous state. =A0A more likely outcome is a merge conflict, requiri=
ng
> =91git reset --merge=92 to recover.
>
> Can we make this less painful? =A0Is it worth adding yet another opti=
on
> to =91git pull=92 to avoid this pain? =A0I don=92t know.

That is exactly the case I was talking about.  I never lost any data
because of this and considering what Junio Hamano is saying I
probably should just continue to do the 'git reset'.

  -- aghiles
