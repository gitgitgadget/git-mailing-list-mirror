From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Sat, 23 Jul 2005 12:33:25 -0400
Message-ID: <42E27155.6070903@yahoo.com>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>	 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>	 <20050722192424.GB8556@mars.ravnborg.org>	 <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>	 <1122068634.7042.35.camel@localhost.localdomain>	 <7vu0imh23q.fsf@assigned-by-dhcp.cox.net>	 <1122108098.6863.38.camel@localhost.localdomain>	 <20050723093035.GB11814@pasky.ji.cz> <1122114452.6863.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 18:33:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwMwg-00014Z-Iv
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 18:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVGWQdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 12:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVGWQdf
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 12:33:35 -0400
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:18767 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262396AbVGWQd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 12:33:26 -0400
Received: (qmail 5775 invoked from network); 23 Jul 2005 16:33:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=rrgELuW8v5TC422XrAg9hK2GZcwx8PjAXc5z5e1P2Px7Ph+J/oYK5MEi+N7cOnZQFfdOFNPcsCgj8QVOZIw0h+Ia8BYRMb2gB0hWYo2xuLxUoBTVT6W1GcX3e2uR+ZRIR+RKI3cdj/MPwTM9pKqG7jCzKhCeXyvNd39Mp5k3eVs=  ;
Received: from unknown (HELO ?72.0.77.164?) (bryanlarsen@72.0.77.164 with plain)
  by smtp109.mail.sc5.yahoo.com with SMTP; 23 Jul 2005 16:33:23 -0000
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1122114452.6863.72.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:

It seems I inadvertantly kicked off the discussion I wanted to kick off, 
but I didn't excpect this patch to do so!

I prepared a patch adding the following information into 
git/Documentation to kick off discussion.  Obviously Catalin is more 
likely to be accurate.

> 
> OK, though StGIT doesn't use any at the moment.
> 
> Now, the StGIT files (.git means $GIT_DIR):
> 
>       * /etc/stgitrc, ~/.stgitrc, .git/stgitrc - configuration files
>         (the latter overrides the former). The syntax is similar to the
>         ini files
>       * .git/patches/ - directory containing the patch information. I
>         won't go into details here since this is only used by StGIT
>       * .git/exclude - for the files to be ignored by the 'status'
>         command
>       * .git/conflicts - includes the list of files conflicting after a
>         merge operation. The user should run 'stg resolved --all' to
>         mark the conflicts as resolved and remove this file
>       * .git/branches/ - the same meaning as in cogito, only that
>         'master' is considered a branch and 'stg pull' doesn't use
>         'origin'
>       * .git/patchdescr.tmpl - the same idea as commit-template, used
>         when creating the first description for a patch
>       * .git/patchexport.tmpl - template used when exporting the patches
>         in a series
>       * .git/patchmail.tmpl - template used for sending patches by
>         e-mail
> 

how about:
  .git/refs/heads/master - documented in README, doesn't appear to be used.
.git/firstmail.tmpl - template used for sending the preamble email
