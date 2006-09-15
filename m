From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 11:42:26 +0100
Message-ID: <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
References: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 12:42:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOB9S-0000wd-OR
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 12:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWIOKm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 06:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWIOKm2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 06:42:28 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:6954 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751226AbWIOKm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 06:42:27 -0400
Received: by py-out-1112.google.com with SMTP id n25so4023601pyg
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 03:42:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Aj5eNB8epf6f8eMsgnE+9huC0Y+0K7F0xZZx1gJlaGP/Yxzj6+WXQaTvSlz5DMsoMPO3WvkxHXpmQAu9PcjN8nci0Kb7iAOSCPAQAwJGgpU8WfJrFfU6Iv3IksHyknDy/GLFuB1BLyPZ0yXGpbEOkMjaWbP79ayqvUmvqCfkPCg=
Received: by 10.35.102.1 with SMTP id e1mr16994640pym;
        Fri, 15 Sep 2006 03:42:26 -0700 (PDT)
Received: by 10.35.103.19 with HTTP; Fri, 15 Sep 2006 03:42:26 -0700 (PDT)
To: "Rajkumar S" <rajkumars+git@gmail.com>
In-Reply-To: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27073>

On 15/09/06, Rajkumar S <rajkumars+git@gmail.com> wrote:
> I am using StGIT to track a branch of a remote git repository
> (actually a remote cvs repository, which I am tracking cvsimport)
[...]
> The .git/remotes/origin is
> URL: /usr/local/pfSense/upstream/pfSense/.git
> Pull: refs/heads/master:refs/heads/origin
> Pull: refs/heads/avendor:refs/heads/avendor
> Pull: refs/heads/Package-Reorg-2005:refs/heads/Package-Reorg-2005
> Pull: refs/heads/RELENG_1:refs/heads/RELENG_1
>
> My requirement is to track RELENG_1 branch with StGIT while
> maintaining my own patches. but when I do a stg pull the messages are:
[...]
> It seems StGIT is trying to merge the origin branch from remote to
> RELENG_1 of local. Is there a way to get RELENG_1 of remote to merge
> with MyBranch (clone of "RELENG_1") of local?

After StGIT pops all the patches, it just calls "git pull origin". My
understanding of GIT is that this should update local RELENG_1 with
the remote RELENG_1 from the "origin" repository. Anything wrong with
my assumptions?

-- 
Catalin
