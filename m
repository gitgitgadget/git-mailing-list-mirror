From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Attempt to make git-checkout man page a bit more clear.
Date: Thu, 21 Dec 2006 10:34:07 +0100
Organization: At home
Message-ID: <emdk9f$c31$1@sea.gmane.org>
References: <20061221015350.245cc964.seanlkml@sympatico.ca> <7vbqlx1yht.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP071BBC53B5CE7917CE8DE1AECE0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Dec 21 10:31:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxKHA-0006A7-5O
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 10:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWLUJbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 04:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWLUJbl
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 04:31:41 -0500
Received: from main.gmane.org ([80.91.229.2]:37988 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965176AbWLUJbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 04:31:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxKGz-0000wh-7h
	for git@vger.kernel.org; Thu, 21 Dec 2006 10:31:33 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 10:31:33 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 10:31:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35042>

Sean wrote:

> On Wed, 20 Dec 2006 23:47:42 -0800
> Junio C Hamano <junkio@cox.net> wrote:
> 
>> The 'restore from arbitrary tree-ish' form does not take -m as
>> far as I know.
>> 
>> Although it might be interesting to do a single-file three-way
>> merge, I do not think the command is _checkout_ anymore once it
>> starts doing that.
> 
> Yeah, I should have caught that.  As well, your explanation makes me
> wonder if it makes sense to change <branch> in the third form to
> <tree-ish> ?  Would you like an updated patch or will you just make
> the touch up(s) yourself?

Better not, because if I remember correctly

  $ git checkout [--] <paths>...

would replace the contents of the named paths in your
working tree from the index, while

  $ git checkout <commit-ish> [--] <paths>...

would replace the contents of the named paths in your
working tree from the given commit (given branch, perhaps given
tree-ish).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
