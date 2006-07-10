From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 2 questions on git-send-email usage
Date: Mon, 10 Jul 2006 22:29:59 +0200
Organization: At home
Message-ID: <e8udb6$jo1$2@sea.gmane.org>
References: <20060710190010.94648.qmail@web25808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 10 22:30:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G02OZ-0003Z7-TI
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 22:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422807AbWGJUaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 16:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbWGJUaQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 16:30:16 -0400
Received: from main.gmane.org ([80.91.229.2]:58014 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422807AbWGJUaO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 16:30:14 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G02OI-0003Vt-3J
	for git@vger.kernel.org; Mon, 10 Jul 2006 22:30:02 +0200
Received: from host-81-190-19-52.torun.mm.pl ([81.190.19.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 22:30:02 +0200
Received: from jnareb by host-81-190-19-52.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 22:30:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-52.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23650>

moreau francis wrote:

> I'm wondering what am I supposed to answer when git-send-email
> is asking me :
> 
> Message-ID to be used as In-Reply-To for the first email?
> 
> I'm running this command:
> 
> $ git-send-email --no-signed-off-by-cc --no-chain-reply-to --to \
>   foo@bar.com --compose /tmp/patch/ 
> 
> to write an introductory message, and all patches are sent as replies to
> this introductory email sent.

Empty string (i.e. RET) should do if you don't want to attach your series of
patches somewhere in existing thread.

> I also noticed that git-send-email removes the commit message of each
> patches I sent, I don't think this is the normal behaviour though. What 
> am I missing ?

Are patches formatted using git-format-patch?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
