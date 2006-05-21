From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] send-pack: allow skipping delta when sending pack
Date: Sun, 21 May 2006 11:24:42 +0200
Organization: At home
Message-ID: <e4pbk3$6au$1@sea.gmane.org>
References: <20060521054827.GA18530@coredump.intra.peff.net> <7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net> <20060521081435.GA4526@coredump.intra.peff.net> <e4p83e$uqt$1@sea.gmane.org> <20060521084403.GB12825@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun May 21 11:25:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhkC8-0005p8-2a
	for gcvg-git@gmane.org; Sun, 21 May 2006 11:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWEUJYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 05:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWEUJYj
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 05:24:39 -0400
Received: from main.gmane.org ([80.91.229.2]:20115 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751505AbWEUJYj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 05:24:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FhkAo-0005di-38
	for git@vger.kernel.org; Sun, 21 May 2006 11:24:30 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 11:24:30 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 11:24:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20445>

Jeff King wrote:

> On Sun, May 21, 2006 at 10:24:37AM +0200, Jakub Narebski wrote:
> 
>> Hmmm... isn't the patch slightly against git coding style?
> 
> Oops, yes (though the point is moot since the patch is conceptually
> wrong). Is there a git coding style document somewhere?

Not that I know of. It's better to follow the coding style used
in the rest of files.

Besides, differentiating between

   if (condition)

and

   function(argument);

makes IMVHO sense.

-- 
Jakub Narebski
Warsaw, Poland
