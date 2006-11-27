X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-PS1 bash prompt setting
Date: Mon, 27 Nov 2006 08:49:31 +0100
Organization: At home
Message-ID: <eke571$ng2$1@sea.gmane.org>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE> <Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de> <20061126094212.fde8cce7.seanlkml@sympatico.ca> <20061127065400.GA19174@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 27 Nov 2006 07:48:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 34
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32388>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GobDz-0007EA-5Q for gcvg-git@gmane.org; Mon, 27 Nov
 2006 08:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757265AbWK0HsO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 02:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757266AbWK0HsO
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 02:48:14 -0500
Received: from main.gmane.org ([80.91.229.2]:18576 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1757265AbWK0HsO (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 02:48:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GobDd-0007Ad-J2 for git@vger.kernel.org; Mon, 27 Nov 2006 08:48:01 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 08:48:01 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 27 Nov 2006
 08:48:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> Sean <seanlkml@sympatico.ca> wrote:
>> On Sun, 26 Nov 2006 15:27:07 +0100 (CET)
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 
>>> But there really is no good place to put it: most commands need a git 
>>> repository, and those which do not, are inappropriate to put an option 
>>> "--show-ps1" into. Except maybe repo-config. Thoughts?
>> 
>> What about just making it an option to the git wrapper?
> 
> I'm using something like this, and will be adding it to
> git-completion.bash tonight:
> 
>       __git_ps1 ()
>       {
>               local b="$(git symbolic-ref HEAD 2>/dev/null)"
>               if [ -n "$b" ]; then echo "(${b##refs/heads/})"; fi
>       }
>       PS1='[\u@\h \W$(__git_ps1)]\$ '
> 
> it works very well...

Perhaps, as it was proposed somewhere else in this thread, instead of
\u@\h use $(git repo-config --get user.email)?

And I would add \!: at the beginning of prompt, but that might be
just me.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

