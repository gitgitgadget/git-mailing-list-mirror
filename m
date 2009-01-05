From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: announce: TortoiseGit 0.2 preview released
Date: Mon, 5 Jan 2009 14:40:57 +0800
Message-ID: <46dff0320901042240x1dbbb640yb136b8dea37a7b14@mail.gmail.com>
References: <1976ea660901040715l36667c7dld5f686e8c3624d1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tortoisegit-announce@googlegroups.com
To: "Frank Li" <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 07:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJjAM-00007l-GB
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 07:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbZAEGlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 01:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZAEGlA
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 01:41:00 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:61745 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbZAEGk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 01:40:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3680184wah.21
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 22:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uKWuDyuIk+MBNmU4Bph3abUX1Ug/iYGUV2RWUdXyjug=;
        b=IH/DuFYTD9Z+LhjHXBbE3i5pJt+En6FbScN7l7yO9fXVda8W7VTO9Pd76NvBrb942N
         5qTEffK2aJhxMXQ0YpgWqaUcbK3uo/GZFejlY1SBR0DzwBO6kni1bc4Dl3fsJB84njFp
         TlfzrrCmqIe8VlPm+akcnswFotEU+M0JUXNqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kN6/gfg6ri4Fi95LYdDpXZSUyrR6mpaTYMDpkZ7qEIJBZ3xdBHCSXZBcJoXGUWspQx
         wLaJCirGJGA0eT5ElxEjyqhmT+j3n51KIq0YiMsjuUfMa6x9anPz/uglfN+3FEUkZV8X
         w1LoAW0k7LXyvBANSx/ASlVa+J6jMPUfo7oog=
Received: by 10.114.198.1 with SMTP id v1mr13596674waf.78.1231137657898;
        Sun, 04 Jan 2009 22:40:57 -0800 (PST)
Received: by 10.115.93.12 with HTTP; Sun, 4 Jan 2009 22:40:57 -0800 (PST)
In-Reply-To: <1976ea660901040715l36667c7dld5f686e8c3624d1b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104566>

Wonderful work! Thanks.

On Sun, Jan 4, 2009 at 11:15 PM, Frank Li <lznuaa@gmail.com> wrote:
> After heavy developing, TortoiseGit 0.2 preview release published.
> TortoiseGit 0.2 can finish regular work, such as commit, show log,
> diff version, create tag, create branch, create patchs.
>
> Download:
> http://code.google.com/p/tortoisegit/downloads/list
>
> Version 0.2.0.0 preview version:
> Features:
>  1. Add TortoisgeMerge as default compare tools
>  2. Pull, Fetch, Push
>  3. Create Branch\Tag
>  4. Switch branch \Chechout
>  5. Compare with previous version
>  6. Clone(only support local repository, see known issue for detail)
>  7. Log Dialog support filter
>  8. Check for modifications
>  9. Revert local change
>  10.Create Patch Serial
>  11.Apply Patch Serial
>  12.Add file to repository(see know issue)
>  13.Export to zip file
>
> Bug Fix:
>  1. A2W cause stack overwrite bug when git output is long.
>
>
> Known Issue:
>  1. ProcessDlg will wait for ever when clone remote repository(ssh, http,git).
>  2. push fetch and pull don't support password mode. Just support
> public key problem.
>  3. Just fetch first 100 log item.
>  4. If install TortoiseGit before MsysGit, you need modify register
>     HKEY_LOCAL_MACHINE\Software\TortoiseGit\\MsysGit\
>    Let it point to correct msysgit install path.
>  5. Add File, please commit and show unversion file, the choose add
> file, then right clict, Choose Add file
>  6. To new initial repository, You will not see add file again in
> commit dialog box if give up commit when choose add
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
