From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: What's in git.git
Date: Mon, 06 Mar 2006 11:29:29 +0100
Message-ID: <440C0F09.5060302@etek.chalmers.se>
References: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Mar 06 11:29:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGCyB-00080X-TL
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 11:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbWCFK3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 05:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbWCFK3h
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 05:29:37 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:12744 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1752367AbWCFK3g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 05:29:36 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.070)
        id 4405BCD9000FFD2A; Mon, 6 Mar 2006 11:29:30 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17293>

Junio C Hamano wrote:
 
> I'd like asciidoc tweaks in "next" by Francis Daly tested by
> people who have access to different vintages of docbook-xsl by
> trying to build manpages.  Look for displayed examples, such as
> the one in git-branch documentation.  I've tried it with v1.68
> and getting far better results than before, and Francis says
> v1.69 works fine with or without the change. IOW this is a
> workaround for a problem in v1.68.
> 

I tested it with asciidoc 7.0.1 and the examples in the git-branch 
man page look better with the fix.

/Lukas

Before:
 Examples
       Start development off of a know tag


              $  git  clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6 $
              cd my2.6 $ git branch my2.6.14 v2.6.14 $ git checkout my2.6.14

               These two steps are the same as "checkout -b my2.6.14 v2.6.14".

       Delete unneeded branch


              $  git clone git://git.kernel.org/.../git.git my.git $ cd my.git
              $ git branch -D todo

               delete todo branch even if the "master" branch  does  not  have
              all commits from todo branch.

After:
   Examples
       Start development off of a know tag

              $ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
              $ cd my2.6
              $ git branch my2.6.14 v2.6.14
              $ git checkout my2.6.14

               These two steps are the same as "checkout -b my2.6.14 v2.6.14".


       Delete unneeded branch

              $ git clone git://git.kernel.org/.../git.git my.git
              $ cd my.git
              $ git branch -D todo

               delete todo branch even if the "master" branch does not have all
              commits from todo branch.
