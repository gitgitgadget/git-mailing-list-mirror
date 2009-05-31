From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Resetting working files
Date: Sun, 31 May 2009 19:39:32 +0200
Message-ID: <20090531173932.GA13856@vidovic>
References: <DA26600008CE404B831978F6EBB31C6B@HPLAPTOP> <4A229B9A.6060807@dirk.my1.cc> <20090531162515.GB8129@m62s10.vlinux.de> <20090531163225.GE3674@debian.b2j> <9719867c0905310950x153db8efw179a8a10ac3f4640@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Baumann <waste.manager@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Sun May 31 19:39:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAp0f-0004QH-36
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 19:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbZEaRjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 May 2009 13:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbZEaRjj
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 13:39:39 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:63794 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZEaRjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 13:39:39 -0400
Received: by ewy24 with SMTP id 24so7357923ewy.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ps3x8sUqdI0nFcVrSgiqcX9lAQ35q6RoFr1eD4lYHXA=;
        b=lThYKf2azilx+hpXaAACjTpeufY/dZXpW1wpVMJdlurSHL91yF3UN0CtJ9qIXPwqv4
         146UZITB3dz6Ge5KZLU7DKcuKTYzDS0snyE2NFGTwuMUl4KrR1kvUQuNRVmZjR4OYFpV
         X+9MLMaKXPiqpYaDR8LMFfudJmeBe7WcsESq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=COVFJc9/QL//XEgV59GBgKQAZ2LVQJinsYj4A2uPDftpbJCszqEZRPzzUZnQ04j7Ed
         6Rjsh4GvopuSIQHnaGVMGsgqQb3SiXrfp9wZ7P10S0otLDa0TsgKLNlsl0Zll5b5yApP
         GHMtfWQHHRwQQ9oE8gYkPhJxkueuspqOh1Rkg=
Received: by 10.210.88.7 with SMTP id l7mr5321368ebb.55.1243791579993;
        Sun, 31 May 2009 10:39:39 -0700 (PDT)
Received: from @ (ABordeaux-258-1-66-239.w92-136.abo.wanadoo.fr [92.136.17.239])
        by mx.google.com with ESMTPS id 7sm464221eyb.45.2009.05.31.10.39.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 10:39:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9719867c0905310950x153db8efw179a8a10ac3f4640@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120422>

The 31/05/09, Aaron Gray wrote:

> > I still do not understand what index is.
> > 1. is index an replica of the committed tree
> > 2. is index only transient in that its content will be reset once
> > =A0 committed?
> > 3. or other ?
>=20
> I think index is HEAD or a revision hash. Am I correct ?

HEAD is a reference to a branch name:
$ cat .git/HEAD
ref: refs/heads/master
$

The branch name is a reference to a commit:
$ cat .git/refs/heads/master
a80aad7b85fc560451e07792d64ab6cb15a39914
$

The index is what will be committed by 'git commit'.

--=20
Nicolas Sebrecht
