From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb filter for patches by a specific person in a specific timeframe
Date: Mon, 28 Aug 2006 15:13:43 +0200
Organization: At home
Message-ID: <44f2ebff.71ddc839.5a4e.79a6@mx.gmail.com>
References: <200608281459.26643.kai.blin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 28 15:13:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHgvv-0001yD-SY
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 15:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWH1NNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 09:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWH1NNg
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 09:13:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:50140 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750806AbWH1NNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 09:13:36 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1010454nzf
        for <git@vger.kernel.org>; Mon, 28 Aug 2006 06:13:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:to:mail-copies-to:date:references:lines:organization:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=M2/uzjCngzXLBF5qnOjpggebLxIIRQ7JPf2sOXm7vAujK02u0HCfeglfXs0ZfKM/GPm/oMoWa7RNRz9EHtm5lme0eSy8Zbi9d6YoOFIg9LwBcS3IKzLGOLaO68r9GX8vZYStqgabEtm+3yY/RB2bpgg6bm65vnQ2x0Vb59i8oiE=
Received: by 10.65.240.5 with SMTP id s5mr6839750qbr;
        Mon, 28 Aug 2006 06:13:35 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id q13sm4352696qbq.2006.08.28.06.13.34;
        Mon, 28 Aug 2006 06:13:35 -0700 (PDT)
To: Kai Blin <kai.blin@gmail.com>, git@vger.kernel.org
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26155>

Kai Blin wrote:

> I have just completed my Google Summer of Code[1] project[2] working for the 
> Wine project. Now, as I was submitting patches to a git repository, I don't 
> have a branch solely containing my patches or something like that. Google 
> seems to want something like this, so I figured maybe I could get gitweb to 
> filter for my patches during the SoC period. Is that possible?
> If not, does it sound like something feasible to add?

It is possible. Simply enter "author:Kai Blin" (without space between ':' 
and your name as it appears in author field) in the searchbox, and you 
would get an URL similar to the URL below:

  http://www.kernel.org/git/?p=git%2Fgit.git&a=search&h=HEAD&s=author%3AJonas+Fonseca

Of course you should first go to proper branch.  If you are giving the link,
you can write it in more human-friendly form, e.g.

  http://www.kernel.org/git/?p=git/git.git;a=search;h=HEAD;s=author:Jonas+Fonseca


Or you can just search for your name, which gives URL like this one

  http://www.kernel.org/git/?p=git/git.git;a=search;h=HEAD;s=Jonas+Fonseca

which will find all commits in the lineage of given branch (HEAD is 
the current branch) which have specified phrase in commit log (which 
includes signoff lines)

> PS: Please CC me, as I'm not on the list.

You can always read the list using one of the many archives 
of git@vger.kernel.org list, or using Usenet (news) client via NNTP
gateway at GMane (nntp://news.gmane.org/gmane.comp.version-control.git).

See http://git.or.cz/gitwiki/GitCommunity

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
