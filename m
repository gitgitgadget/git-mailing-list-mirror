From: Daniele Segato <daniele.bilug@gmail.com>
Subject: What's the best way to make my company migrate to Git?
Date: Fri, 21 May 2010 16:55:37 +0200
Message-ID: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 21 16:55:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFTdZ-0000Md-QX
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 16:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325Ab0EUOzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 10:55:41 -0400
Received: from mail-yw0-f180.google.com ([209.85.211.180]:36476 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab0EUOzk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 10:55:40 -0400
Received: by ywh10 with SMTP id 10so609947ywh.1
        for <git@vger.kernel.org>; Fri, 21 May 2010 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=FwzGp+8XVyfkHlwpj+RrXkych3Cbm7XLjxiPvLWn+0s=;
        b=YIOg3Uq8pavB2CIHKyCMQGRyEcOFKv5PXPD6GxiyeDtTVuuwc89tZmeNPknpGaeQ1Z
         l5oxoRCz+BUJVHdBT1uxUhJWMCg2BO88Tra81AZKsNfFjrwOohK8Ao6YJa0WfBlp4Lih
         GoDYkRSTIZ29VdNKn5xyEovzIV5BJ3X4P02wA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=gydaJTZPDqTBzRKlOYwiHm6tCCPVFXrJfDbHQ2vLDZFjRRCiDXR8qfDJNd6j4+68r2
         XbfGlQHV1xUNpJxmrQ5/DCK3ed2vSxx4fx+hkdem3AMub1B0aVU9hjzXtzkUg5zj6Sht
         R77hVb0h05Q19KRdSTkQo7EJvX3TlmnV6afD4=
Received: by 10.101.132.12 with SMTP id j12mr2313142ann.130.1274453737339; 
	Fri, 21 May 2010 07:55:37 -0700 (PDT)
Received: by 10.100.34.5 with HTTP; Fri, 21 May 2010 07:55:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147461>

Hi,

I work as a Developer (mainly Java and web applications) and I'd like
to introduce my company to the use of Git.
I don't have much time to allocate on this matter, so the elapsed for
applying any of your suggestion will probably go from weeks to months
:)

If I manage to migrate I'll be only able to start using git with the
new projects, I don't think that old project will be easily migrated
to Git (unless not until it will be widely accepted and learned by
everyone).
There are, more or less, 30 developers working in different projects
from junior to senior developers.


We use Subversion as versioning system.

The developers are used to work with Eclipse (an open source IDE) that
happen to have a Subversion plugin and they all works on Windows
platform.
I'm the only one who work on a Linux box and use git-svn from command
line as a front end to Subversion.
I already know of (some of) the advantage of using git, but I'm also
aware that it's not that easy to change other people mind on what they
used for years.
So I need to be really persuasive on the advantage of using it, and I
think you can help me on this.

I think that to introduce git in my company I should at least go throw
this 5 points:
1. prepare a project management web application easy to use and
mantain (like github or gitorious for instance) on one of our intranet
servers.
2. achieve knowledge on the git-submodule and to handle binary files
versioning (mainly third party java libraries that are in every
project)
3. learn what I had to know to use Git on windows (i never did this),
and find some user friendly AND graphical tool to propose (i know
there is a Git-eclipse module but I don't know if it is considered
stable and/or full featured)
4. give my managers some reason to migrate/begin to use Git instead of
Subversion
5. do some "school" to other developers



I think there are many of you that went throw this before and I'd like
to have some advice on the 5 point of the list above.

Can you also tell me if you think there is some risk in migrating and
what kind of difficult I could encounter in the process?
For example: like any company we have a proxy and a firewall..
For example: if i had to commit something working from home I connect
to the Subversion via HTTPS and commit, with Git I should have ssh
access which is something that I probably will not have.


I can summarize all this email with just this question: What's the
best way to make my company migrate to Git?

thank you all for any advice.

Daniele
