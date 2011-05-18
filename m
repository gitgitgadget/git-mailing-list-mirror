From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Windows permissions with repository on a network share
Date: Wed, 18 May 2011 14:22:51 +0530
Message-ID: <BANLkTikb4Q9ZmG-ToaV5LXLzfrcBu58PUw@mail.gmail.com>
References: <iqu417$qnj$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
X-From: git-owner@vger.kernel.org Wed May 18 10:52:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMcV0-0000q4-1T
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 10:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab1ERIwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 04:52:53 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34548 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab1ERIww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 04:52:52 -0400
Received: by vxi39 with SMTP id 39so938579vxi.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nU8D9sdfMg12LCJDTYJqZ4LWav9o+aYtxHn61/wigCc=;
        b=prU/pTfvYZrrX9drkdVEFz7U8DmA+49W3ocD08p45rWRdpyn4Mtw7DihpMOohj8eI9
         8bBLEdafwZ9fcU725zmkWHJJyTs+SBl9gPMixd+YgAGODamyK8BK0b1cRg/HGngklk9b
         xyYDM1cptMFqANsfBshddbDutlRS9Jan1+EXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aLNAm6L0UzZE7ZoXeRdk6A0uPw7QMpX2hwRR9GueV12ZUPpNN7y491FAmddhjh/u1H
         k4XUX5nF/WfT9hH04jlh6PQN0MalCQokegfc5KgEmhyPnxCugRMZXFAaMkyJJ3TjDjl2
         ziwugh7cf8E/W45OlPSQJu/xU6PLUPtiSsOpk=
Received: by 10.52.111.136 with SMTP id ii8mr2308759vdb.72.1305708771856; Wed,
 18 May 2011 01:52:51 -0700 (PDT)
Received: by 10.52.164.101 with HTTP; Wed, 18 May 2011 01:52:51 -0700 (PDT)
In-Reply-To: <iqu417$qnj$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173863>

On Tue, May 17, 2011 at 8:55 PM, Jerome Lovy
<t2a2e9z8ncbs9qg@brefemail.com> wrote:
> Hello,
>
> Did anyone experiment with Windows permissions for a Git repository located
> on a Windows network share?
>
> Is it a sensible scheme in order to have a central repository with ACLs
> (notably some group can read/write, some other group can only read) without
> the need to set up a dedicated server (ala Gitolite) ?
> (Assuming a Windows network share infrastructure is already in place...)

I don't know about Windows but any OS/file-system level ACL system
that has more granularity than the usual user/group/other, ought to
work fine.

The only thing gitolite can add is branch-level permissions, which it
doesn't sound like you need.

[Of course, I like to think that the config file in gitolite is a much
cleaner way of setting, reviewing, changing, and tracking changes of,
permissions, but I'm biased ;-)]
