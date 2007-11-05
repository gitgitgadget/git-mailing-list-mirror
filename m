From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Mon, 05 Nov 2007 23:06:25 +0100
Message-ID: <85sl3kny8u.fsf@lola.goethe.zz>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
	<CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
	<20071105215433.GA12827@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpA4e-0007KE-0g
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbXKEWFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXKEWFU
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:05:20 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:55277 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbXKEWFS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:05:18 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IpA4J-0000nu-4J; Mon, 05 Nov 2007 17:05:15 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BC9E21C464E3; Mon,  5 Nov 2007 23:06:25 +0100 (CET)
In-Reply-To: <20071105215433.GA12827@inspiron> (Alejandro Martinez Ruiz's
	message of "Mon, 5 Nov 2007 22:54:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63568>

Alejandro Martinez Ruiz <alex@flawedcode.org> writes:

> On Mon 05 Nov 2007, 11:28, Steven Grimm wrote:
>>
>> But that suggested command is not going to convince anyone they were wrong 
>> about git being hard to learn. I wonder if instead of saying, "I know what 
>> you meant, but I'm going to make you type a different command," we should 
>> make git revert just do what the user meant.
>
> I think that would just add to confusion.  "revert" applies to full
> changesets, not single files, plus it creates a new commit, which is
> probably not what the user wants.  Most of them just want to revert some
> local changes to some random files, so teach them what they need, if
> anything.
>
>> There is already precedent for that kind of mixed-mode UI:
>>
>> git checkout my-branch
>> vs.
>> git checkout my/source/file.c
>
> This is a different case: you're basically performing the same
> operation, with the second line applying just to a subset of files.

Huh?  The first one moves HEAD.  The second one doesn't.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
