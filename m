From: Gelonida <gelonida@gmail.com>
Subject: Re: how to squash a few commits in the past
Date: Mon, 03 May 2010 22:55:32 +0200
Message-ID: <hrnd84$rh0$1@dough.gmane.org>
References: <loom.20100503T112508-677@post.gmane.org> <4BDEA0D7.9090201@drmicha.warpmail.net> <hrncm3$pg8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 22:55:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O92gJ-00016Z-8J
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 22:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab0ECUzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 16:55:54 -0400
Received: from lo.gmane.org ([80.91.229.12]:51004 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422Ab0ECUzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 16:55:53 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O92fz-0000vA-NU
	for git@vger.kernel.org; Mon, 03 May 2010 22:55:49 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 22:55:39 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 22:55:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <hrncm3$pg8$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146256>

Hi,

Gelonida wrote:
> Hi Michael,
> 
> Michael J Gruber wrote:
>> Gelonida venit, vidit, dixit 03.05.2010 11:33:
>>>
>>> The plan would be:
>>> - create a new git repository without the huge file
>>> - let everybody clone the new repository and continue working.
>>>
>>>
>>> I thought, that I could squash the commit adding the file, removing the file and
>>> the commits in between into one commit.
>> You don't need to squash the commits in between. Use git rebase -i A^ if
>> A is the commit introducing the large file. Then, either edit that first
>> commit (to not add the file) or reorder so that the removal commit is
>> squashed into A.
> 
> 
> I seem to misunderstand your suggestion.
> 
> git rebase -i 740ebdf9b^
> returns following output
>> fatal: Needed a single revision
>> Invalid base
> 
> 
> what am I missing?

In case it is relevent:

My git version:
git version 1.6.3.3
