From: Srirang Doddihal <om.brahmana@gmail.com>
Subject: Git repo on a machine with zero commits is ahead of remote by 103
 commits.. !
Date: Tue, 25 Jan 2011 11:18:41 +0530
Message-ID: <AANLkTikj06sjTbNd8afk9cY2=_Hy+kT+J1NCjR-fKP5J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 25 06:48:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phblq-0007We-4F
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 06:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab1AYFsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 00:48:43 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51149 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab1AYFsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 00:48:41 -0500
Received: by iyj18 with SMTP id 18so4736623iyj.19
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 21:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=6293mA5yfGbfhZ9PNNlwcuxHidEnx7E7BldboFumEOA=;
        b=cT5HlItFM0vhFNd0vcMngfIom7GaD/ZX85DYII8HuFQLt4az4MEsG6RyctRSkowPR8
         ZqqxoTZroCv8aBGhtYAWbawTYdQ3H/5/ruofd1SYc9TP2No21Ea+8kLAvVBCANmsJkH8
         4bud4iwHHZksrtmzwOCu08A6ZKIYe8h94TXpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HPzOTpgcRekj+1dqPgVMqqO/X0xmfeUErkjKthVdjPgvvoxIrl3LAePaCRkGxA/Snu
         gVu+JuIQ79vccgJ/QUl/3e9N3M7M7veIYFOXb+5yoaaVbfdhA53TMFb/7QJS3yBMeq2D
         rfL70g70yc9+cKsCsAfa4Vi/UIksTqoZL0Yy0=
Received: by 10.231.36.133 with SMTP id t5mr5902567ibd.12.1295934521227; Mon,
 24 Jan 2011 21:48:41 -0800 (PST)
Received: by 10.231.206.77 with HTTP; Mon, 24 Jan 2011 21:48:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165468>

Hi,

I am using a simple git based deployment for my rails app and here is
my setup and current status:

1) Git repo initialized on my local development machine with a sample file.
2) Pushed to remote repo on Github.com
3) Subsequent pushes and pulls made from local development machine
4) Repository cloned on the deployed machine
5) Subsequent pulls made from the deployed machine (but no commits or
pushes are made on this machine)

Now when I run "git status" on the deployed machine it says :

# On branch master
# Your branch is ahead of 'origin/master' by 103 commits.

git pull origin master -- says it is Already up to date

git log -- appropriately shows till the latest commit

however

git log orign/master -- shows commits only till Jan 8th.

also

git rev-parse origin/master -- give different SHA1 values on my
development machine and the deployed machine.

Questions:
===========
1) Why does "git status"  say that the local repo on the deployed
machine (where no commits are made) is ahead of the remote by 103
commits? (This number, 103, increases with every "git pull origin
master" and very likely the change is equal to the number of commits
pulled)

2) Why is "git log orign/master" stuck at a Jan 8th commit?

* How can I set these right?

Even with these anomalies, "git pull origin master" on the deployed
machine seems to be working just fine, in terms of the right revisions
of files being pulled in and all that.

Any help in understanding what caused these anomalies and suggestions
to fix then would be very helpful.
Kindly let me know if any more information is needed.

-- 
Regards,
Srirang G Doddihal
Brahmana.

The LIGHT shows the way.
The WISE see it.
The BRAVE walk it.
The PERSISTENT endure and complete it.

I want to do it all ALONE.
