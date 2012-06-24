From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Problem pulling large repo, Error: /usr/bin/git-pull: line 277:
  5401 Terminated              git read-tree --reset -u HEAD
Date: Sun, 24 Jun 2012 01:15:37 -0500
Message-ID: <4FE6B089.1000705@gmail.com>
References: <1340469568490-7562027.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: bmitic <bj@infomitic.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 08:16:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sig7S-0003z2-0T
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 08:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab2FXGPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 02:15:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42857 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab2FXGPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 02:15:39 -0400
Received: by obbuo13 with SMTP id uo13so4535173obb.19
        for <git@vger.kernel.org>; Sat, 23 Jun 2012 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Hqt4doGuk3Npddt3dpATbUGYisnVB9sTnVPnZu0+Hv4=;
        b=Ihihg7+eqSGYNw8WNcrikUju4gVX2+L1FPp4bQ/7H3upgiQ4PjedzY8ZET/pCzq7+S
         h7i71UPTfeKxyqq3FZBgX+rqdJgSqf0hUrUdy+GTUM9nnD2rUD3xoURCOhf4dC4enBgK
         q/mdx9e6BZ44pwjKvz/1cpj3+IHpbc1tB1yuJLXZquntar+YQuWGPKN9fX29IJ/IW8J6
         A5ZVUOo3ozaPRRd7BCG5Etaw6h/T6pAg6VB0fhWShsh22easc3B1EbimnvvcjAeifS+J
         przeQK6yee87UzQvtFXvMuB+FyhJc9k/Cp1w3/85tCXVvpgR5NYahEO66cdeYbMneGFL
         p8uQ==
Received: by 10.182.164.69 with SMTP id yo5mr8013629obb.17.1340518537982;
        Sat, 23 Jun 2012 23:15:37 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id dk15sm32400865obc.10.2012.06.23.23.15.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jun 2012 23:15:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <1340469568490-7562027.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200517>

On 6/23/2012 11:39 AM, bmitic wrote:
> I can't really explain it, but basically every time I try to pull this
> specific repo from my other servers I get the results bellow.  I have two
> identical servers where this works, but for some reason on the third one it
> doesn't.  I even got another virtual server and tried it and I was getting
> the same error.  I don't know how to troubleshoot this.
> If anyone has a suggestion I would appreciate it:
>
> [root@myserver gittestremote]# git pull -v tst1 master
> xxx@xxxxx.xxxxxxxx.com's password:
> remote: Counting objects: 20095, done.
> remote: Compressing objects: 100% (18794/18794), done.
> remote: Total 20095 (delta 1005), reused 20095 (delta 1005)
> Receiving objects: 100% (20095/20095), 1.11 GiB | 11.46 MiB/s, done.
> Resolving deltas: 100% (1005/1005), done.
>  From xxxxxx.xxxxxx.com:/var/www/GITREPO3/fullsites/prd_biq
>   * branch            master     -> FETCH_HEAD
> /usr/bin/git-pull: line 277:  5401 Terminated              git read-tree
> --reset -u HEAD
> [root@myserver gittestremote]#
>
> --
> View this message in context: http://git.661346.n2.nabble.com/Problem-pulling-large-repo-Error-usr-bin-git-pull-line-277-5401-Terminated-git-read-tree-reset-u-HEAD-tp7562027.html
> Sent from the git mailing list archive at Nabble.com.
>
What is your version of git (git --version), and what are the specs of 
the machines where it worked and didn't work?  The 1.11 GiB in your 
output looks pretty big.

v/r,
neal
