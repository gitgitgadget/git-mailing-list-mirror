From: PCMan <pcman.tw@gmail.com>
Subject: How to replace master branch of a repo with that of another totally 
	unrelated repo?
Date: Fri, 6 Aug 2010 15:38:09 +0800
Message-ID: <AANLkTiksJd-VfiP2Wzz-FsZoJk8djWyuxgweQpy6WaPB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 09:38:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhHVV-0002q1-BV
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 09:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933957Ab0HFHiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 03:38:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59682 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837Ab0HFHiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 03:38:11 -0400
Received: by wwj40 with SMTP id 40so8727943wwj.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=idSJy1IQNee1bis4ZXl7cEnEth8ZrYVpmb8BmiInTGY=;
        b=VbdVHizJAfTPYVD2pXkL2G/mhWn0D8L9HMvXBbvbWpAWnhVwIPTpmSegEZ+7ZAZibD
         I4GcIa90gM5Scddn+7q/bOwH+vct1xOilMBS+epCohmVyOLEM2/jbdibboO4GX7KC+ps
         SO8Uy15TB3+4reOrCX4VbbvlNNhSmANANinzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=poEztwmKMXF3AVbi9mYCCcvOheq7fwvUz5MUWAIOGr8tR4SB73/aTnUQMpA5S/mH2Z
         o76rDCnVY6FQhxUANwjKEEkmz9jNrkTpDSB2OA2q95FuPdNeDW4AjIovmGxL0YtwVPBR
         gizFU6uN+EnJXNaryPot0YQHqc8QUa5V0KCQM=
Received: by 10.216.13.17 with SMTP id a17mr530585wea.46.1281080289508; Fri, 
	06 Aug 2010 00:38:09 -0700 (PDT)
Received: by 10.216.61.12 with HTTP; Fri, 6 Aug 2010 00:38:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152768>

Hello,
I want to rewrite a program totally from scratch rather than branching
from current one.
So I created a new repo for it and do the development there.
Now it's finished and I want to replace the old program with it.
Is it possible to replace the master branch of the old repo with the
code in this new repo?
I want to move the old code to a separate branch for backup, and
replace the master branch with the master branch of the new repo.
Since git rm -r * than git add all new files will lost history of new
repo, it's not an option.
The old repo is a public online repo used by multiple users. So just
renaming the repo won't work since the users who pull code from the
old repo will get troubles.
What's the best strategy for smooth migration in this case?
I'm not able to find the answer on Google.

Thank you all.
