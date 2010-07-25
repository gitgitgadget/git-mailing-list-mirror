From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: pre-receive - 1st push
Date: Sun, 25 Jul 2010 20:43:43 +0530
Message-ID: <AANLkTi=atkT2n0-+3pXevp-mBahtf1sXmNa+DEVbt=E_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 17:13:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od2ti-0005js-Tz
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 17:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab0GYPNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 11:13:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38076 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab0GYPNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 11:13:45 -0400
Received: by bwz1 with SMTP id 1so2418238bwz.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=mhIb4sKCiLr78DTUShX0HdPgEgt9J3swRqrf3Wc3H0c=;
        b=Mj0QG4nGT4Fcgc1mfD1H5zH+uJCkxL55pIpmDL1j3MEEkB9bvNMzlfZuhqpFDZzVyN
         E0o8oKGEKESq4oZXO1MYfFhAgPMpAETIBQne2740GNRpGr++qHkXWDPnAPQCReHloHPH
         C3i2K4gO3aBNwCSlUCONK5Mk4CxIp5PXomkIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=mOboZEvUTFtMwx2W2KjNu3qB+IYod8eFKWotiOOdKf5OAdxXmxiYct1gTpP9fzR0kQ
         x5Sq2Xed75oHS38r1+8FLDAZiCrbJdFJs5S0RKLGCIXXD+I13dttZApR6dhwS8V5BnpI
         DTHJuEp9vRQfPyQLIlk5mwLqxL4n+IDyYr6Rk=
Received: by 10.204.81.215 with SMTP id y23mr4748162bkk.78.1280070823591; Sun, 
	25 Jul 2010 08:13:43 -0700 (PDT)
Received: by 10.204.118.193 with HTTP; Sun, 25 Jul 2010 08:13:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151754>

Hi I want ensure that commits are in particular format before doing
receive-pack. I use pre-receive hook

I use git-revlist command. This works fine when that branch exist in
destination origin.

When I am doing a push 1st ever time and sending clone is sending 3
commits; how do i determine which are those 3 commits on the specific
branch.

git rev-list <commit> gives just too many commits ; I have done only 3
commits on source repository. destination repo don't have that branch
yet so no use of git-show-branch)


Thx/ Mahesh
