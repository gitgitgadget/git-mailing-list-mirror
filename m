From: jeff millar <wa1hco@adelphia.net>
Subject: Re: How stop tracking a file?
Date: Sun, 22 May 2005 14:29:25 -0400
Message-ID: <4290CF85.5060105@adelphia.net>
References: <4290B7FB.5070708@adelphia.net> <7vacmnfapv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 20:29:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZvBS-0008Ng-Kn
	for gcvg-git@gmane.org; Sun, 22 May 2005 20:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVEVS3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVEVS3b
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 14:29:31 -0400
Received: from mta13.mail.adelphia.net ([68.168.78.44]:47759 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S261213AbVEVS30
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 14:29:26 -0400
Received: from [192.168.2.4] (really [24.52.167.181]) by mta13.adelphia.net
          (InterMail vM.6.01.04.01 201-2131-118-101-20041129) with ESMTP
          id <20050522182926.DSIC4191.mta13.adelphia.net@[192.168.2.4]>;
          Sun, 22 May 2005 14:29:26 -0400
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacmnfapv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>    jm> cg-rm does two things
>    jm>    rm -f "$@"
>    jm>    git-update-cache --remove -- "$@"
>
>I do not do Porcelain, but something along the following lines
>should work:
>
>    for path
>    do
>        git-update-cache --force-remove "$path"
>    done
>
Seems a bit more difficult...
[jeff@Desk gsmc-1.1]$ git-update-cache --force-remove main.o
[jeff@Desk gsmc-1.1]$ cg-diff
Index: main.o
===================================================================
Binary files a5d1a55e0818ab11b71fee01bcd9053c4ecc65a6/main.o 
(mode:100644) and /dev/null (tree:uncommitted) differ
[jeff@Desk gsmc-1.1]$ cg-commit
Refusing to make an empty commit - the tree was not modified
since the previous commit. If you really want to make the
commit, do: commit-tree `tree-id` -p `parent-id`
A picky porcelain problem?



