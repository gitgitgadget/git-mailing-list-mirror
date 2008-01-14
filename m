From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Mon, 14 Jan 2008 15:21:28 -0700
Message-ID: <a5eb9c330801141421g13c627e5x77afb357e2a78463@mail.gmail.com>
References: <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com>
	 <20080114202932.GA25130@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 23:23:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEXi1-0005Aa-P3
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 23:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222AbYANWVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 17:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757219AbYANWVc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 17:21:32 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:32344 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217AbYANWVa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 17:21:30 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1043999nze.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 14:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+3Y1FBSzwZXn31gaGyarfo+KxMrD/VVk8wK7/CPXpYc=;
        b=QlTWv+CfVqR9HzRuVsnJrpOD2a2p0HzQtlgITSjzZUlKJ3AIHucStTdQVDq/bJTvVwyypfK6CbWWG6x3C1jHLBXXwfr43aQR/rwA2kTXNL8zVTChTwzdwn0KjRImXuREte/VN6KIdEhVfueUScecNEGACp4PdCZbVr4d+J6R1Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rJGMkYKpNFD/WqmQbJ3Sg3vwqGd88SvuGrfVfPqvGkjAUOc6mQGvsaW25CI9ortDqH6VYq2jmMh9O7rirlEUMGffvGGGQiAJD39GPYuE5Uw+oc3gk5WaNR8RkaJmLTtyZnaTVkB6H0WpAYl+bdnMEqUEgY53T+rRcuRqAWOlSlU=
Received: by 10.142.158.17 with SMTP id g17mr2854016wfe.157.1200349288857;
        Mon, 14 Jan 2008 14:21:28 -0800 (PST)
Received: by 10.114.137.1 with HTTP; Mon, 14 Jan 2008 14:21:28 -0800 (PST)
In-Reply-To: <20080114202932.GA25130@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70484>

The "mount" command tells me everything I have is mounted in binmode.
I have used Git on a default cygwin install (win XP pro) before and
not had this problem - that's why this is so frustrating. Not sure
what changed this time round as I tend to use defaults for most
installations.

Are you saying I need to make sure the repository directory is mounted
in text-mode (for Windows compatibility)? I just reinstalled cygwin,
selecting text-mode as the default. I can create a git repository, but
"git add ." returns:

fatal: cannot use /cygdrive/c/test/.git/info/exclude as an exclude file

Paul

 On Jan 14, 2008 1:29 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Paul Umbers, Mon, Jan 14, 2008 18:21:44 +0100:
>
> > Trying to create a repository under the cygwin install of git, windows
> > XP Pro. I can create the initial repository OK using "git init" and
> > add files using "git add .", but when I come to commit I get the
> > messages:
> >
> > error: invalid object d9b06fceac52f6c24357e6a7f85c601
> > 088381152
> > fatal: git-write-tree: error building trees
>
> Is it a "text-mode" mount where your repository is to reside?
>
>



-- 
Computer Science is no more about computers than astronomy is about telescopes.
--- Edsger W. Dijkstra

Paul Umbers MSc MBCS MIAP
paul.umbers@gmail.com
