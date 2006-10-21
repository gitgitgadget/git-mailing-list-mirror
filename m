From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 22:55:49 +0200
Message-ID: <200610212255.49791.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net> <87ac3p1jn7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 22:55:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbNse-0000Ou-0u
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 22:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWJUUzl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 16:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWJUUzk
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 16:55:40 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:37028 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161038AbWJUUzk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 16:55:40 -0400
Received: by hu-out-0506.google.com with SMTP id 28so632283hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 13:55:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XsC+TgrPFtVObHXXDiu1rzbj4kpkkP3mmyvxyzkHEQ2nr3DQvEViP4epcPaLa8+V8APkIy6Jk15Nb1nW4Zpp6cBNoTF7Z9GfBxYnWueQlHcE0qbXVZ/QpFTZ+g9HJUIop/3jZSjFoD01i+upj1rvGYlcSJjGP4DOv1SNnna7qzs=
Received: by 10.67.89.5 with SMTP id r5mr4432239ugl;
        Sat, 21 Oct 2006 13:55:38 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id y7sm1611131ugc.2006.10.21.13.55.37;
        Sat, 21 Oct 2006 13:55:37 -0700 (PDT)
To: Carl Worth <cworth@cworth.org>
User-Agent: KMail/1.9.3
In-Reply-To: <87ac3p1jn7.wl%cworth@cworth.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29675>

Carl Worth wrote:

> Also, since the git names are so predictable, git almost never emits
> them. It accepts them as names just fine, but it doesn't generate
> them, (log, and commit never show the branch-specific names). I think
> the only git command that even can emit such a name was a recently
> added git-name-rev which exists solely for the purpose of mapping a
> commit identifier to a local, branch-specific name which might have
> more intuitive meaning for the user.

git-show-branch also shows git-name-rev like names.

BTW. git-show-branch has somewhat strange, and different from other git 
commands UI. You can think of it as text version of gitk/qgit history 
viewer (although you can use tig for CLI (ncurses) graph).
-- 
Jakub Narebski
Poland
