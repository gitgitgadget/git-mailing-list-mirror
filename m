From: Irene Ros <imirene@gmail.com>
Subject: branch ahead in commits but push claims all up to date
Date: Tue, 24 Mar 2009 11:22:45 -0400
Message-ID: <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 16:24:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm8Uo-0007J7-Ef
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 16:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbZCXPWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 11:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756648AbZCXPWs
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 11:22:48 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:42337 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369AbZCXPWs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 11:22:48 -0400
Received: by gxk4 with SMTP id 4so6560943gxk.13
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=hLeUYC1UQ7yTaK2CwVpVtDVXmd9SJix1lQOH54Y+Jhg=;
        b=CfhxYMgSLBsTH2VVZSpHUQbIxSv+OUad2424AuYxVpyPqLM7q9EHs6WYKxA1smZeCc
         e7nCK/ZGs52TSBVtCAzV23Foj3qTjH7AWKlMcTtj+FM4whLBhFuTrDc4i04M8DN16zMP
         IP9QC3UI3lrz5UzeYiIr1doF0YgZGGTDiSRew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=H9LgOKLaKazljjqYSpD9g0wA/osfAuBH/HICby3anst3pl0a/3/x3RtuPgoWmaPy/B
         gdGRxYlPlWge+giZc5IegyW4dBJ+YY+YU2XpLLXwdGOT7e7dDKsAXjQ+e6anRQy0YOPU
         ocpVe5A3Z38i9T2lPUOtZCNM8xifFvr9WZB/I=
Received: by 10.100.144.11 with SMTP id r11mr4321363and.45.1237908165839; Tue, 
	24 Mar 2009 08:22:45 -0700 (PDT)
In-Reply-To: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114466>

Hi all,

I've been using git for some time now and haven't run into this issue
before, perhaps someone else here has:

I have a branch that is ahead of its origin by a few commits:

$ git status
# On branch myBranch
# Your branch is ahead of 'origin/myBranch' by 10 commits.

Oddly, when I try to do a push, I get a message saying that everything
is up to date:
$ git push origin myBranch
Everything up-to-date

Looking at the log for origin/myBranch I can tell those commits are
missing, but I can't push them up, even with a --force flag. Any
ideas?
Here's the config entry for this branch:

[branch "myBranch"]
=A0=A0=A0 remote =3D origin
=A0=A0=A0 merge =3D refs/heads/myBranch

There's also nothing to pull from this branch, I'm the only one working=
 on it.
I use many other branches in this particular repo, and its just this
one that's giving me trouble.

Thanks so much!
-- Irene
