From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] improve documentation for some commands that use pathspecs
Date: Fri, 3 Apr 2015 20:55:48 +0700
Message-ID: <CACsJy8ADrWAuCXXA92FdF6YCMwVUPrWi42tf-qD0re6xnYvHtg@mail.gmail.com>
References: <20150331152224.GA16617@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <joeyh@joeyh.name>
X-From: git-owner@vger.kernel.org Fri Apr 03 15:56:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye25P-0007K0-3N
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 15:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbbDCN4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 09:56:25 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37603 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbbDCN4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 09:56:19 -0400
Received: by igblo3 with SMTP id lo3so8990659igb.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A+H4mpgKfBYyCHIGFOX307O/xYg9L+GSGmDXlPdlKSc=;
        b=zOCHezAuMr73nlUZ717a/f1reXPruN1L6/imiO778cyI7m8Gx0vW4JFjIv5fkSyx7V
         h0sOy1uw2GV6G/wvvfFr6Akoc81RT513ZMyF3qeQeDRChOVo8aLLela42z7gtNsvCo0l
         V9lbIRAOrq6do20xepdQbaau/dmCZCpkIZU2eH9aURDi2MxLJlhpK0npZ7endYdz9otz
         LGOFQgHnZZUQ/aSAT7FlBGhKlZfsjpspbtHE4KW2QYA7FHgcbkok+ondq63N2lzCNTtW
         pnb7VnRPUAzYBOLzAtgiyoFJVNPOJO+mMs9FzNma7TRALWTnV8hHqwFPai2UPTiZ8xab
         28Qg==
X-Received: by 10.107.130.145 with SMTP id m17mr3795057ioi.89.1428069378462;
 Fri, 03 Apr 2015 06:56:18 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Fri, 3 Apr 2015 06:55:48 -0700 (PDT)
In-Reply-To: <20150331152224.GA16617@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266706>

On Tue, Mar 31, 2015 at 10:22 PM, Joey Hess <joeyh@joeyh.name> wrote:
> After being surprised that git-ls-files expands pathspecs, here's a patch
> that would have saved me.
> ---
>  Documentation/git-ls-files.txt | 9 +++++----
>  Documentation/git-ls-tree.txt  | 8 ++++----

ls-tree only supports straight file or directory paths, no globbing or
other magic (except ":/") so I'm not sure if we should change its man
page now.  On the bright side, if you use unsupported pathspec feature
on ls-tree, it'll reject, so not so bad.
-- 
Duy
