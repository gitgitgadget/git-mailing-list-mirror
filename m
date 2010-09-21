From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.16.2
Date: Tue, 21 Sep 2010 09:01:26 -0400
Message-ID: <AANLkTin5FeRqEq3gN3Wi0m2xib7Cv5dK_bOwHXf_2vV0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 15:02:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy2U8-0002Ey-1Z
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 15:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab0IUNBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 09:01:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60288 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab0IUNBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 09:01:47 -0400
Received: by gwj17 with SMTP id 17so1620283gwj.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 06:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=NizUZ0uLqCLa9P9+dP1Q/PjOdO5iLBOymI0CjrK0HBw=;
        b=mzDNZb1YaX1lJQnVrjb1zCSRelvqG94aMHJoAmYeii3d/3rZcNELvnXLuizLMo4ym/
         J9P/jzOfjfaJLDG39tvVIW1lA90QlhlalUC5d3GoGc87SlsnBNAzNPef8fxz8Q0Mp4hw
         AIk9Sh3UgBR+gLgXukEPSGUUv7Z3PMdrykYRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=wQOALDMXjAZli2bQ7k1U38GIEE42nl4AelpW0YFIOQe+oQgz3fSaN4axXQnAywcLRM
         SbAIt4SQdHMkQPnHgvRf/1mvaiGVtqMEgofDCMN12NCmBLC+X7YOeOolGHIramS+N9nq
         0KssaijvY/a2PHETwwuKRx1sZ6hRlahnO4aFQ=
Received: by 10.151.122.4 with SMTP id z4mr10533769ybm.136.1285074106500; Tue,
 21 Sep 2010 06:01:46 -0700 (PDT)
Received: by 10.231.39.194 with HTTP; Tue, 21 Sep 2010 06:01:26 -0700 (PDT)
X-Google-Sender-Auth: FEaL97p3ArOqke4mZujEiUbTjHU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156722>

Hello,

I decided to make a quick bug fix release that addresses the issues
reported with 0.16.1.

Release notes
-------------
Bug fixes:

 - Fix regression causing empty tree view.
 - Fix set_tabsize() compile error for older versions of ncurses.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 NEWS                |    8 ++++++++
 VERSION             |    2 +-
 contrib/aspell.dict |    2 +-
 tig.c               |    6 +++++-
 4 files changed, 15 insertions(+), 3 deletions(-)

Jonas Fonseca (2):
      Fix 'tig show <commit>' fix which causes empty tree views
      tig-0.16.2

Kumar Appaiah (1):
      Check the ncurses version before using set_tabsize

-- 
Jonas Fonseca
