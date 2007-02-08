From: "Mark Levedahl" <mdl123@verizon.net>
Subject: Re: [PATCH] Make gitk save and restore the user set window position.
Date: Thu, 8 Feb 2007 11:55:28 -0500
Message-ID: <eqfkm4$fd3$1@sea.gmane.org>
References: <491753.81112.qm@web38915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 17:59:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFCcg-0000PX-5a
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 17:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965539AbXBHQ7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 11:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965726AbXBHQ7r
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 11:59:47 -0500
Received: from main.gmane.org ([80.91.229.2]:55143 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965539AbXBHQ7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 11:59:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFCab-0005CO-2w
	for git@vger.kernel.org; Thu, 08 Feb 2007 17:57:41 +0100
Received: from sahara.mdnt.com ([12.109.151.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 17:57:41 +0100
Received: from mdl123 by sahara.mdnt.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 17:57:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: sahara.mdnt.com
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39063>

"Brett Schwarz" <brett_schwarz@yahoo.com> wrote in message 
news:491753.81112.qm@web38915.mail.mud.yahoo.com...
>>
>> Mark
>>
>
> I've only been half following this thread, so I apologize if this was 
> already talked about.
>
> Have you tried [wm protocol] command. You would use it like this:
>
>    wm protocol . WM_DELETE_WINDOW do_quit
>
> This basically traps the signal from the windowmanager, and [do_quit] 
> gets executed *before* the gui is torn down. The only bad thing about 
> this, is if you explicitly destroy a widget inside your code (i.e. 
> [destroy .]), then this will *not* get invoked. You also need to make 
> sure you catch any possible errors in do_quit, otherwise the gui will 
> hang.
>
> HTH,
>    --brett
>
Thank you - that is exactly what I was looking for but couldn't find. 
I'll generate another patch tonight.

Mark 
