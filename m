From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: File archiver using git
Date: Sun, 27 Aug 2006 17:34:04 +0200
Organization: At home
Message-ID: <ecse17$2q3$1@sea.gmane.org>
References: <3bbc18d20608270610o102968d2kd340d40843262dc5@mail.gmail.com> <Pine.LNX.4.63.0608271528130.8018@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Aug 27 17:35:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHMfI-000362-Ru
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 17:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWH0PfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 11:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWH0PfI
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 11:35:08 -0400
Received: from main.gmane.org ([80.91.229.2]:55433 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751075AbWH0PfG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 11:35:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GHMf8-00033t-KT
	for git@vger.kernel.org; Sun, 27 Aug 2006 17:35:02 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 17:35:02 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 17:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26101>

Grzegorz Kulewski wrote:

> On Sun, 27 Aug 2006, Matt McCutchen wrote:
>> Dear git people,
>>
>> You might like the two attached scripts that I wrote around git to
>> pack file trees containing lots of redundancy into very small
>> packages.  For example, if I have ten slightly different versions of a
>> piece of software because I didn't use version control, I can use
>> gitar to compress them together.
> 
> Does it (and GIT in general) work ok with file permisions, ownership, soft 
> and hard links, named sockets, device files and similar "strange" 
> filesystem objects? Do I need any options to GIT to make it work with 
> them?

Git in general only preserves executable bit, deals with symlinks,
hardlinks after a fashion (stored once, but unpacked/checked out as separate
files, not hardlinked), and does not deal with other "strange" filesystem
objects as far as I know.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
