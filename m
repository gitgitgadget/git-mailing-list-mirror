From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Rebase with remote branch?
Date: Thu, 16 Jan 2014 11:23:31 -0600
Message-ID: <CAHd499DQmEqt44u71xn_FPumbPpJgNmTOnhA0C4BTG_-B+9ODQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 18:23:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3qfJ-0005Ze-Bn
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 18:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbaAPRXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 12:23:34 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:60781 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaAPRXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 12:23:32 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so2201897lbd.29
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 09:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=VLdPUvM9ZE4+kqEmZobzC7aBpll2+jLpJVBVkhVGVvo=;
        b=ocNxj2Jqs4OE2MAZRQruWe7/iJD6hOxZHHvcXsbb8MN3Mzix1ni6bi/1QqcJ53TrkK
         XRefmmgdntrp98ww/aFp3doqEJhs2rq6OYPALEEC3tszWUmQ2y+e3VS/c0wP/l1gBfQI
         NAwTFYz0umyo2lnXr56CvlcGzJmh3K/Ko+NyiJKRysbTzpkBz7DFFh1KD5pucF5v8E8L
         CD6weIV23GxQ48RE1/OViJdpyzh/qSnGJPbqhqATeOBrDrS6/K+hg5KlYumnfVlnNIFr
         RknrMZn4McQPxXc1RDBCHkjAZnC4MfrjC4STJKouSi58yMk4DQeEPc+efCimu1JP2qSS
         otzA==
X-Received: by 10.152.1.197 with SMTP id 5mr5828508lao.0.1389893011131; Thu,
 16 Jan 2014 09:23:31 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.114.24.199 with HTTP; Thu, 16 Jan 2014 09:23:31 -0800 (PST)
X-Google-Sender-Auth: Ri3dvuEbZht62W66FDbay2x59zo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240517>

I have two branches, 'master' and 'work'. 'master' I never work out
of, and I merge changes into it from another SVN repository (I do not
use git-svn, I do this all by hand as real git commits). My 'work'
branch is technically my 'master' in the git-trunk sense, as that is
my personal main line of development and I merge directly to 'master'
from 'work'. I like to rebase 'work' onto 'master' but by doing so, I
have to 'git push --force origin work' due to the fact that the rebase
puts my current branch behind origin/work.

Should I stick to merging between 'master' and 'work' only ? Rebase is
only for local-only branches, right?
