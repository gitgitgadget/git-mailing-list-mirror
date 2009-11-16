From: Matt Di Pasquale <liveloveprosper@gmail.com>
Subject: git multisite setup
Date: Mon, 16 Nov 2009 13:18:36 -0500
Message-ID: <13f0168a0911161018r6fc67d29n781cca670a66815b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 19:19:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA6AK-0002QD-NE
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 19:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbZKPSSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 13:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbZKPSSw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 13:18:52 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60519 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbZKPSSv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 13:18:51 -0500
Received: by bwz27 with SMTP id 27so5949407bwz.21
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 10:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=V/GpinM1NQq1PSbykPlynmMPUSW4WnjvEVRH3BD694Q=;
        b=YIRg0FwK7NtYXNyscV+Mcoo4Jl2gcHSeZ76DjqujZkiQEsb9KUsuTpCYnf1hxrm91m
         W5BGNRl1aMIkEcVLiZz+jJMcn2YZ/XUqMcAQMLkktgvnkeYnKy4ogzSStNk7foKXkgAk
         tGVf04jzEJ5lObCX1TUGmdmuajI59mzErZaiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=PAbyHNox2b2PAHaUaUoJTQv/W3qJeUTKSwJETwF7DGVXAxUiTOXrt+cw3tHRnRb200
         WBJj/lFx0Nh7SOshGzuIyoTkIcXel3sDmQjpcjWl5ZfC/sqlH9Zckom3Xp7tkwYf5WYx
         2Wel/DeN2tjvjHTEsZe3mobMyy6cjyE7On6tY=
Received: by 10.216.89.135 with SMTP id c7mr1538169wef.62.1258395536147; Mon, 
	16 Nov 2009 10:18:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133021>

Hi,
In my sites folder i have folders for different sites of mine:
example.com example2.com, and i also have generic files like an
includes dir and a .htaccess file that all sites use. what is the best
way to track the generic files and the different sites?

i was thinking each site has its own .git repo. and then make a .git
repo for my sites folder but ignore the individual sites dirs.
actually that's what i'm doing now.

should i use submodules? i don't really understand submodules and the
examples i saw did not cover nested folders

Thanks!

matt
