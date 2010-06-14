From: Nazri Ramliy <ayiehere@gmail.com>
Subject: How to prevent changes to repository by root
Date: Mon, 14 Jun 2010 11:12:35 +0800
Message-ID: <AANLkTikLixhYITdJKMFb3Hw2hZvaas1DtiV3x9ThCTZz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 05:12:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO06Q-00083Y-UD
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 05:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0FNDMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 23:12:41 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62324 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab0FNDMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 23:12:40 -0400
Received: by gwj15 with SMTP id 15so2131658gwj.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 20:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=fyW3qiJDKdyl429m/HTkzN2WCHn2v5PJ6r6aqH0LIUk=;
        b=S1gbbi943rIyz2aaQHaIPwkRx2HeH78Y5+IpFxnAxQJcNAHmAfOcNqqPvuB/DgD+kY
         bILaGQ1nShg9AnPq9KMs3JFSjntdwzyEG4r7ilZ9oZi/onfG61FtErPBwu6TKnX/pgX2
         kOz7kxs+NsBhSzobiWOjraCBk27HUf1q8R2bA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Sa0h0SGmDwfsgZMkCLu1Hfwb5u7SQJmyVwvw8U8uZ4dcDcoS5N0VlAMhKtGsBEqbak
         LeoZSsgwsdDLc+16/lSbTvJeal76vi6/YIJbk6seCntzSc7b0BoSSiEtQkVlQjX4KdZD
         bZPY7JESP51Ec6gUP2QhhxhpYz45NYU5TAzc8=
Received: by 10.91.58.11 with SMTP id l11mr4346928agk.0.1276485155474; Sun, 13 
	Jun 2010 20:12:35 -0700 (PDT)
Received: by 10.90.114.16 with HTTP; Sun, 13 Jun 2010 20:12:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149063>

I have a git repository owned by a non-privileged user account on a
machine that is logged into (via ssh) by multiple users. These multiple users,
all of them (not at at the same time) do "git pull" on this repository.

Everything is fine as long as they don't do the "git pull" as root.

Murphy's law and all, someone is bound to do "git pull" as root on that repo
and that would sometime cause problem for the non-privileged user (who 'own')
the git repo to do subsequent git operations on that repository.

My question is:

How do I limit any action on this repository to this non-privileged user only?

I looked at "git help hooks" thinking that maybe I can use one of the hooks to
add return "test $USER = foo" but from the descriptions there it is
not clear which
hook is the one that applies to this case (limit all repository action
on this repository
to this user only)

Any ideas?

Thanks in advance for any help.

nazri.
