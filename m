From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Problem with add folder to a subdirectory
Date: Sat, 3 Apr 2010 23:55:56 +0530
Message-ID: <n2nf3271551004031125g38c52d0cq810ed366f3d1d2d3@mail.gmail.com>
References: <28125580.post@talk.nabble.com> <h2yf3271551004030213u1441cf4akd0898aa3a418eda9@mail.gmail.com> 
	<990EEB31-9AAB-4CF5-AC05-11BCA45C6447@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Aris Bezas <aribezas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 20:26:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny83F-0005C0-A7
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 20:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab0DCS0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 14:26:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64080 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab0DCS0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 14:26:18 -0400
Received: by gyg13 with SMTP id 13so1454964gyg.19
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=HSipfe7024pwXIx0SoG73t4RcrQznYfls1fVWt4Osdo=;
        b=BteNQ5c5BuRDAhFcO2C/wMWgQ2tBdzI//RAkH6esBm0ngl5h1T61xCXLHKtCpt5gXc
         EI6lLgcjqghIyFrUNI17eXfSvM2R1twSxWM33ypqnqketVgWLWN558uWSVJgYAcAKQmB
         UaRFs5bRthblmi8D/ffHu1EFeSr5lC9bBLbEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=IAvmspO0qgqaGesG6RpkW2IoVPgRhTExLX405qZ4DClIMuj+5Oqe55evnaKLVHxBVX
         D/mBd6PziEPWGmzJIuUzO4yeOScv1seWsCn0rKbJG8tI+KGY+C1kmOmPAggdw2IMmArR
         Q57RLvwoS3qNQxjGy9WYjXvZJYdeE41eDBkyY=
Received: by 10.90.69.14 with HTTP; Sat, 3 Apr 2010 11:25:56 -0700 (PDT)
In-Reply-To: <990EEB31-9AAB-4CF5-AC05-11BCA45C6447@gmail.com>
Received: by 10.90.161.16 with SMTP id j16mr3417975age.20.1270319176784; Sat, 
	03 Apr 2010 11:26:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143894>

[Kindly do not cull the list from CC unless absolutely necessary]

On Sat, Apr 3, 2010 at 11:45 PM, Aris Bezas <aribezas@gmail.com> wrote:
> I put a content in the folder (test.txt file) but i there is no result.
> The strange thing is that when i add this in the root directory (where the
> git is) it recognize it but in a subdirection no.

Unless I've misunderstood something, I'm not able to replicate your
issue. Kindly go through some introductory material on Git.

$ git init
Initialized empty Git repository in /tmp/foo/.git/
$ mkdir -p 1/2
$ touch 1/2/test.txt
$ git add 1/2
$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file:   1/2/test.txt
#

-- Ram
