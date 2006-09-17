From: "Andrew Pamment" <andrew@mort-os.com>
Subject: Re: gitweb on OpenBSD (-T not supported on filesystems...)
Date: Sun, 17 Sep 2006 19:16:13 +0930
Message-ID: <op.tf0n3bjjqpav6l@crystal.sienna.ath.cx>
References: <op.tf0k9fdvqpav6l@crystal.sienna.ath.cx> <eej3g3$d9j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 17 11:45:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOtDA-0006Kt-ON
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 11:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWIQJow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 05:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWIQJow
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 05:44:52 -0400
Received: from vscan02.westnet.com.au ([203.10.1.132]:44495 "EHLO
	vscan02.westnet.com.au") by vger.kernel.org with ESMTP
	id S964801AbWIQJov (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 05:44:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 2347311F1AE;
	Sun, 17 Sep 2006 17:44:49 +0800 (WST)
Received: from vscan02.westnet.com.au ([127.0.0.1])
 by localhost (vscan02.westnet.com.au [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09651-12; Sun, 17 Sep 2006 17:44:49 +0800 (WST)
Received: from crystal.sienna.ath.cx (dsl-202-173-138-168.sa.westnet.com.au [202.173.138.168])
	by vscan02.westnet.com.au (Postfix) with ESMTP id 7F94A11F278;
	Sun, 17 Sep 2006 17:44:47 +0800 (WST)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <eej3g3$d9j$1@sea.gmane.org>
User-Agent: Opera Mail/9.01 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27175>

On Sun, 17 Sep 2006 18:42:12 +0930, Jakub Narebski <jnareb@gmail.com>  
wrote:

> What Perl version do you use? Does 'perldoc -f -X' has the following  
> lines?
>
>         -X FILEHANDLE
>
>         (...) If "-T" or "-B" is used on a filehandle, the current IO  
> buffer
>         is examined rather than the first block. (...)

The version of perl is the one that comes with OpenBSD 3.9, it is v5.8.6.

I do get the above text when I run 'perldoc -f -X', does this mean it  
should work? When I try the original -T $fd I get:

Software error:
-T and -B not implemented on filehandles at /var/www/htdocs/git/gitweb.cgi  
line 1598.

> The solution for you would be to skip -T test.

That works fine. Thanks.

Andrew

-- 
Mort - http://www.mort-os.com/
