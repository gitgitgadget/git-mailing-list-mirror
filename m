From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git clone doesn't work in symlink dir roots on Windows
Date: Sat, 10 Aug 2013 14:51:40 +0200
Message-ID: <20130810125140.GD25779@paksenarrion.iveqy.com>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sedat Kapanoglu <sedat@eksiteknoloji.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 14:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V88ac-0001I7-Sx
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 14:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933083Ab3HJMsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Aug 2013 08:48:11 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:59361 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678Ab3HJMsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 08:48:09 -0400
Received: by mail-la0-f42.google.com with SMTP id mf11so3619624lab.29
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nqaQbsmdrfVwrbdEnl5WbsZbS2K8J8Br6ZFUdDEZRMY=;
        b=YXzWlzKwrAsSX7SpUlvO5yEng2lAp9xGfwCLfA1SJcHFsHxqqSWIUz+EIerPryNS3F
         RPjFFgF4aBcau4Akkw/VhdDd1225aYfhX3TY3lJVWTpBx12sh4FirTYKl82zbH6ZmkZP
         kCW37xmnK7sTPUNYZbPmdjLUwYwoQ1kk/6iekoTMIXkSAIFt3YrFYOw/utsKSXelvz6e
         4KLiZ9RtWAO5QZvoK6qFspyZB4rsj2ZO5QjQPjab14DIXrvpMudeOQf0wB2/Gh9nJHQR
         RArD1WPVqCFotnHmBWnNTex6gCUQC0EtV/eF2j9C1okYgx6qcrYvKG8zByPPyxDrXlB4
         NSpQ==
X-Received: by 10.152.87.169 with SMTP id az9mr911182lab.65.1376138887845;
        Sat, 10 Aug 2013 05:48:07 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id p17sm8466792lbv.11.2013.08.10.05.48.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 05:48:07 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V88dw-0008Uk-Sr; Sat, 10 Aug 2013 14:51:40 +0200
Content-Disposition: inline
In-Reply-To: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232095>

On Sat, Aug 10, 2013 at 03:10:49PM +0300, Sedat Kapanoglu wrote:
> My D:\src folder is a symlink to another folder in my Google Drive, c=
reated
> by Windows command mklink /d d:\src "d:\Google Drive\src"
>=20
> D:\src>git clone https://github.com/jlewallen/jenkins-hipchat-plugin.=
git
> Cloning into 'jenkins-hipchat-plugin'...
> fatal: Invalid symlink 'D:/src': Function not implemented

git is a disk intense program, so this setup is not sane at all. With
that said I know that git on windows historically had problems with
working on smb-mounted shares (sometimes you're forced to have stupid
setups). I doubt that git really is the right tool for your work, since
you're using a decentralized tool in a centralized work flow. Maybe
something like subversion would suite you better. (or just simple use a
hosting service such as github/bitbucket/your own server).

However I can't find that error message in the git source code which
make me wonder if this actually is a git problem. Could you investigate
more on where that error message comes from?

Using dropbox git users have experienced corrupt repositories due to th=
e
dropbox sync algoritm isn't suited for the git file access patterns, I
would imagine that you could have the same problems using google drive.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
