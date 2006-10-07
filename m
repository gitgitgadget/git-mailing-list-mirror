From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry
 in tree listing
Date: Sat, 07 Oct 2006 14:31:43 -0700
Message-ID: <45281CBF.7030405@gmail.com>
References: <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 23:32:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWJlx-0008LW-ER
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 23:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbWJGVbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 17:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932859AbWJGVbu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 17:31:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:10371 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932857AbWJGVbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 17:31:49 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1531214nfb
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 14:31:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VS5h7aBluzZUTVv/SrKoQxARralLRJjx6mB0dfImSv128M48ge5FPTSYu4h6LErCvKuRZZpctWYuq9PcZhZLuQLFSo+QgL9XoXwQ3JhG+qHz9r7+ETSiTr0uAM9IIvKFjdF6d2KVxZhLIo8bQvUISMMZ9/CzsK6gW5Xp7TBIp38=
Received: by 10.78.123.5 with SMTP id v5mr3197359huc;
        Sat, 07 Oct 2006 14:31:48 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.google.com with ESMTP id 32sm4992472hui.2006.10.07.14.31.46;
        Sat, 07 Oct 2006 14:31:47 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: ltuikov@yahoo.com
In-Reply-To: <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28510>

Luben Tuikov wrote:
> --- Petr Baudis <pasky@suse.cz> wrote:
>> Signed-off-by: Petr Baudis <pasky@suse.cz>
>> ---
> 
> First, this is a Unixism, and would confuse other OS users.
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

Not that I care that much, but
   1) not all browsers show underlines (try some text mode browsers)
   2) not all browsers show colors (try some text mode browsers)
   2) not all people see all colors
