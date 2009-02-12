From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 12:29:54 +0100
Message-ID: <36ca99e90902120329v2351174cg4597e4995c4e4274@mail.gmail.com>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
	 <20090212084811.GA14261@piper.oerlikon.madduck.net>
	 <20090212092558.GB21074@skywalker>
	 <20090212093227.GC20248@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXZnL-00038X-Mj
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 12:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbZBLL37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 06:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757033AbZBLL35
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 06:29:57 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:41496 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbZBLL34 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 06:29:56 -0500
Received: by ewy14 with SMTP id 14so548931ewy.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 03:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s6beQq+krEGw6bFL7Q8IMzqc476YnKauSHsqTMMJMsI=;
        b=xvcohM2OVf8GInb6G18J7D38aAxUWrWZWeu2aS4VeT/1NG2ZQzjai2oBzrb6zEFxM2
         9YvFr2U2s3AwAUYPud8QBa6J6rkpIA5ZXH9xPSteeFl2ZftVg4j4yVNRziXIFTLIcn/f
         +mpq/v9TD1MOKKsuMyKPk9aJV+XTGsdgpFDes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j8fvIN9alv67e35iqgztZVh5p0yTMR6m7+8td5ZcKB1JUvlW/1uGb9KQIaB3VaCIZL
         OxawvsXizX1hI2Ol6DvxjtdSgBnEKOXR8kVvE0zXKPAxQOEokYniuE1JDEnxprkWNc4M
         kIrI5pTpOIZzGZ7LwcEsPwJD4cgywvc8xScgs=
Received: by 10.210.71.11 with SMTP id t11mr345861eba.19.1234438194079; Thu, 
	12 Feb 2009 03:29:54 -0800 (PST)
In-Reply-To: <20090212093227.GC20248@piper.oerlikon.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109605>

On Thu, Feb 12, 2009 at 10:32, martin f krafft <madduck@madduck.net> wrote:
> also sprach Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> [2009.02.12.1025 +0100]:
>> Latest git and topgit. Moving to git version v1.6.1.3 fixed the issue.
>> I can reproduce the problem on any test repo. Just do a tg update after
>> committing something in the dependent branch.
>
> This is not helpful. Please provide a complete transcript of
> a session reproducing the problem.
>
> I can't:
>
> piper:~|master|.tmp/cdt.GydvBgiR% echo foo > bar                                                 #10002
> piper:~|master|.tmp/cdt.GydvBgiR% giti                                                           #10003
> Initialized empty Git repository in /home/madduck/.tmp/cdt.GydvBgiR/.git/
> Created initial commit 0f189f3: initial checkin
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 bar
> piper:~/.tmp/cdt.GydvBgiR|master|% tg create test                                                #10004
> tg: Automatically marking dependency on master
> tg: Creating test base from master...
> Switched to a new branch "test"
> tg: Topic branch test set up. Please fill .topmsg now and make initial commit.
> tg: To abort: git rm -f .top* && git checkout master && tg delete test
> cached/staged changes:
>  .topdeps |    1 +
>  .topmsg  |    6 ++++++
> piper:~/.tmp/cdt.GydvBgiR|master|% git commit -minit                                             #10005
> Created commit d49ea41: init
>  2 files changed, 7 insertions(+), 0 deletions(-)
>  create mode 100644 .topdeps
>  create mode 100644 .topmsg
If I interpret the 'how to reproduce' right, you have to switch to the
master branch here.

> piper:~/.tmp/cdt.GydvBgiR|test|% echo bar >> bar                                                 #10006
> changes on filesystem:
>  bar |    1 +
> piper:~/.tmp/cdt.GydvBgiR|test|% git add bar                                                     #10007
> cached/staged changes:
>  bar |    1 +
> piper:~/.tmp/cdt.GydvBgiR|test|% git commit -m'append'                                           #10008
> Created commit e85457e: append
>  1 files changed, 1 insertions(+), 0 deletions(-)
And switch back to branch test here.

> piper:~/.tmp/cdt.GydvBgiR|test|% tg update                                                       #10009
> tg: The base is up-to-date.
> tg: The test head is up-to-date wrt. the base.
> piper:~/.tmp/cdt.GydvBgiR|test|% git --version                                                   #10010
> git version 1.6.0.2
> piper:~/.tmp/cdt.GydvBgiR|test|% tg --version                                                    #10011
> Unknown subcommand: --version
> TopGit v0.5 - A different patch queue manager
> Usage: tg [-r REMOTE] (create|delete|depend|export|import|info|mail|patch|remote|summary|update|help) ...
>
Bert
