From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git clone command
Date: Wed, 20 Jun 2012 15:49:33 -0500
Message-ID: <4FE2375D.5010409@gmail.com>
References: <4FD82090.8010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paa Kojo Konduah Amos <pkkamos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:49:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShRqP-0003Q6-QT
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab2FTUtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 16:49:36 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55411 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab2FTUtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 16:49:35 -0400
Received: by obbuo13 with SMTP id uo13so48811obb.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ANeOBz1kRNy5yeBXL+CHf8NhKkw5F6GS2B+2NoFsy2A=;
        b=K9aKQ9XCEfWUwkpDfOSgpFaC1a+nPC+5VdEEN7UBnUkVcbgo+vKWmWmCmbL2yixQkL
         2o4a1bo6zCrA/rOYd/U9IuOt1UdKixZV8hUbU/JwPLwHaskgxUiH8y2eDmEREK9h4LNK
         aKGuJCbpN2lLqjpJZK119lZKe5rJKtsjmupzwMhqpyHyximmk96JKTAETyYEniQW1G+n
         SsaJ+pHmgEZ8ofLpkUmK+2eMvVertEHsMI2yeVskyXD00mFuk0xhkBVVlNmJClH4Nelg
         ZJFlkuNlD38yQy1N++o5hQy1FmPY6nPTtUNEdts6AyafFc0XKWhZ9lFUaPxa9JrwGyEk
         qh+Q==
Received: by 10.60.172.209 with SMTP id be17mr7656815oec.16.1340225375395;
        Wed, 20 Jun 2012 13:49:35 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id lg5sm22485939obb.19.2012.06.20.13.49.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 13:49:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FD82090.8010509@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200360>

On 6/13/2012 12:09 AM, Paa Kojo Konduah Amos wrote:
> hello, i have been working with git for some time now... and i have just
> been hit with a serious problem in the middle of a major deployment of
> our project.
>
> Problem: when i do a "git clone" on the server url without specifying
> the actual git repository..the command still pulls files of a previous
> clone rather than warning me the repository does not exist.
>
> PLEASE what might be wrong...is there something like clean some
> cache.... i am really hot now!!!
>

git-clone manpage states:

<directory>
The name of a new directory to clone into. The "humanish" part of the 
source repository is used if no directory is explicitly given (repo for 
/path/to/repo.git and foo for host.xz:foo/.git). Cloning into an 
existing directory is only allowed if the directory is empty.

I assume you're ending up with a new dir/worktree named after the 
humanish part of the repo-name in your url?  mystery solved?

v/r,
neal
