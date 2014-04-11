From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: What's cooking in git.git (Apr 2014, #03; Fri, 11)
Date: Fri, 11 Apr 2014 18:27:53 -0500
Message-ID: <53487a78f38bf_3b596b93106e@nysa.notmuch>
References: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 01:37:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYl1B-0000kK-2e
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 01:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbaDKXhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 19:37:53 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37052 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbaDKXhw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 19:37:52 -0400
Received: by mail-oa0-f46.google.com with SMTP id i7so6859402oag.5
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 16:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=dZuhtMYVQecX6fPtTF3BFh7E8Cv+kAZN6qUiCt2d1XA=;
        b=k3QZPl61X4gAWTd5xmg9VfDnV6SLVT3ckfVAkMkSgJscsjNxYbNLW3x0os7fdsDlrr
         Eunafz1nq05rbPzwHhEVibV+ddSLbXAV5BvzDxw7K2VfSlJvmFTd9fon9Kj+wLnIhGLJ
         HoOs7QbS4IENE2kJavvkxjhLTAg6gjfOVllm0GqlPqembNc4n2vp5j6vfPjzKQi5YxlF
         Wnrnpug6BP9Hylm2Fu8G7dnXFdQsNcTETFwS6jWAzCatbw82UtuhMPvwOQaBlDT4iAf4
         BfIApjbsPZ0S87qRf8lYb0xeB07gw+nMQd2RDhwusZUfXFmvcMZTdVQeUF6QP2IMY32d
         WucQ==
X-Received: by 10.60.98.139 with SMTP id ei11mr21462858oeb.43.1397259472547;
        Fri, 11 Apr 2014 16:37:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm37417428oeb.11.2014.04.11.16.37.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 16:37:51 -0700 (PDT)
In-Reply-To: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246158>

Junio C Hamano wrote:
> * fc/complete-aliased-push (2014-04-09) 1 commit
>  - completion: fix completing args of aliased "push", "fetch", etc.
> 
>  Will merge to 'next'.
> 
> 
> * fc/remote-helper-fixes (2014-04-09) 4 commits
>  - remote-bzr: include authors field in pushed commits

Before you do, you might want to pick the unrelated fix I just sent[1],
otherwise this test might fail on some machines.

>  - remote-bzr: add support for older versions
>  - remote-hg: always normalize paths
>  - remote-helpers: allow all tests running from any dir
> 
>  Will merge to 'next'.

> * fc/publish-vs-upstream (2014-04-11) 8 commits
>  - sha1_name: add support for @{publish} marks
>  - sha1_name: simplify track finding
>  - sha1_name: cleanup interpret_branch_name()
>  - branch: display publish branch
>  - push: add --set-publish option
>  - branch: add --set-publish-to option
>  - Add concept of 'publish' branch
>  - t5516 (fetch-push): fix test restoration
> 
>  Add branch@{publish}; this round v3 hasn't yet seen much reviews
>  yet.
> 
>  Seems to have some interactions to break tests when merged to 'pu'.

That was v2, wasn't it?

[1] http://article.gmane.org/gmane.comp.version-control.git/246157

-- 
Felipe Contreras
