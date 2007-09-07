From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Fri, 7 Sep 2007 13:51:30 +0200
Message-ID: <20070907115130.GA1547@xp.machine.xx>
References: <20070906075104.GA10192@hand.yhbt.net> <1189096669534-git-send-email-hjemli@gmail.com> <20070906210155.GA20938@soma> <20070906213556.GA21234@soma> <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com> <20070906235516.GC4538@xp.machine.xx> <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com> <20070907084352.GD4538@xp.machine.xx> <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 13:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITcNA-0004as-E3
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 13:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbXIGLvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 07:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbXIGLvf
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 07:51:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:38103 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965193AbXIGLve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 07:51:34 -0400
Received: (qmail invoked by alias); 07 Sep 2007 11:51:33 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp009) with SMTP; 07 Sep 2007 13:51:33 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX196OD4lqLt6nJLnjlitQFZNtibh6W1+e071+Ec6i8
	N9PBidQDlHD4qe
Content-Disposition: inline
In-Reply-To: <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58029>

On Fri, Sep 07, 2007 at 12:13:23PM +0200, Lars Hjemli wrote:
> On 9/7/07, Peter Baumann <waste.manager@gmx.de> wrote:
> >    lets reset 'trunk' to its state before the merge and
> >    'branch1' to the merge commit, before fixing the bug in 'branch1'.
> >
> >        a-b-c-d-e    trunk
> >           \      \
> >            \ -x-y m branch1
> 
> Yeah, this would certainly not be handled correctly by dcommit using
> --first-parent (but it could be handled by (a correct implementation
> of) --upstream).
> 
> Thanks for the example, I had a feeling something like this could
> occur. So I guess I'll have another go at --upstream this weekend.
> 
> [btw: could you please stop messing with 'Mail-Followup-To:'? When
> replying to your mail, I don't want everyone _except_ you in the 'To:'
> header...]
> 

Sorry, I wasn't aware of that.

I had a 'subscribe git@vger.kernel.org' in my muttrc and just pressed 'g'
for group reply. Reading the docs suggested to 'set followup_to=no' (as
I did before sending this message). Per default it is set to 'yes'.

Could anyone more experienced with mutt correct me if this was the wrong
fix for this problem (or even point me to the right documentation)?

-Peter
