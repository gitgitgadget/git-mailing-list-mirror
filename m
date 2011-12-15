From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Git difftool / mergetool on directory tree
Date: Thu, 15 Dec 2011 13:53:01 -0600
Message-ID: <4EEA501D.3050401@gmail.com>
References: <4EE8618E.7020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 20:53:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbHMd-0007Pk-E3
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 20:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab1LOTxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 14:53:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56653 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1LOTxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 14:53:04 -0500
Received: by yenm11 with SMTP id m11so1724702yen.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 11:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Cu88yAoj6avwQSC3/o1WjYM/Jhd4EoF7Eu3NQTdyneU=;
        b=QqIQPUXIUwWaBWpL60mHsM+2JQeKX5w2J46dBTH87z8UOSug48EzYPbLZ8NVedNoC4
         yYXmGwE73h1aZO3H5OpyrsVFtDhmEWGG+Jk5LdXqy9Ur87kyou+o0ZYxIaISX6Ue8ak1
         rfp/SY+sK2AuMEmxsSjpzD161QOg8eICS1nZQ=
Received: by 10.236.175.72 with SMTP id y48mr7417047yhl.17.1323978784347;
        Thu, 15 Dec 2011 11:53:04 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id 5sm12706757anz.14.2011.12.15.11.53.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 11:53:03 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4EE8618E.7020902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187227>

On 12/14/2011 2:42 AM, Daniele Segato wrote:
> many diff / merge tool around have the ability to compare a directory
> tree (meld is one, but there are many).
>
> Is there a way to start a difftool or a mergetool on a folder instead of
> the single file?
>
> It would be an handsome feature to git.
>
> I googled a little before popping out this question and I only found
> suggestion on how to open "many" file at once instead of opening them
> serially but that's not the same thing not as powerful as directory
> comparison.
>
(This works with kdiff3 as the mergetool/difftool on git 1.7.1 on linux):

git difftool <commit>:<dir>/ <commit-2>:<dir>/

e.g., git difftool mycommit:ourdir/ yourcommit:ourdir/

<commit> = pointer to a commit (ie: sha-1, branchname, tag, ref)
<dir> = path of dir relative to worktree


v/r,
neal
