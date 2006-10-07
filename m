From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Sat, 07 Oct 2006 21:06:25 +0200
Organization: At home
Message-ID: <eg8tpu$drj$1@sea.gmane.org>
References: <20061007141043.16912.73982.stgit@rover> <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 07 21:06:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWHUp-0000PA-Ec
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 21:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWJGTGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 15:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbWJGTGA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 15:06:00 -0400
Received: from main.gmane.org ([80.91.229.2]:12206 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932720AbWJGTF7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 15:05:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWHUZ-0000KZ-Uk
	for git@vger.kernel.org; Sat, 07 Oct 2006 21:05:47 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 21:05:47 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 21:05:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28497>

Luben Tuikov wrote:

> --- Petr Baudis <pasky@suse.cz> wrote:
>> +                          esc_html($t->{'name'} . '/'));
> 
> First, this is a Unixism, and would confuse other OS users.
But AFAIK _Git_ uses it, in output and in index.

> Second, "/" is after all _not part of the name_ of the tree/directory,
> but part of the filesystem's path separator, let's not export it
> to users of other OS's.
> Third, directories/trees are already clearly 
>   1) underlined, and
>   2) differently colored,
> which makes it overly obvious what it what.
> 
> In fact, my eyes only scan for the different color/underlined
> entries when I'm searching for a directory in tree view.  I don't even
> look at the left-most column.
> 
> NACK!

I'd rather like it.


More important though would be to add better support for symlinks,
perhaps in the UNIX form

        symlink -> _target_

Whete _text_ denotes link.

By the way, I miss somewhat the "redundant" tree/blob links in tree
view...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
