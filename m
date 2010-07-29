From: Em DauPhu <emdauphu@gmail.com>
Subject: Sync submodules
Date: Thu, 29 Jul 2010 16:53:04 +0200
Message-ID: <AANLkTimMBBa2HEv4P45=MiWuk1K3ak_LFgWgEq_Zzfj0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 29 16:53:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeUTy-0000VE-OH
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 16:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab0G2OxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 10:53:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33927 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab0G2OxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 10:53:08 -0400
Received: by wwj40 with SMTP id 40so412046wwj.1
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=1G2hOc+MM59MfzFmmesQnkRPwH0jnJ/wIep5ZFx4dYc=;
        b=QkqFLi3+Cv27wEyeFjqcDD4Ic9N9dBtLwC3T9opNy1dN7K8+zwc37Xmd1UuTODVyJ3
         wV66eaeLM0OZBXT5UVy3dLDVnprY1g9MWxKBiIs+/BRttZab3NRTx6ujwxU7QIK0Pp0Q
         PX6njZOwSQC6dR4b/iVD7so1/JAObQ18zYxnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=OT+rBOdb00W5cpTxFjSi9wpTeQIfJwoCdBmPat9XJM39ZRb2CdDIeedRub8k6EInDP
         jJKaiZ1jC+I0H40YrEXBWDK1TQhrMFwmpRQDOp1rbkXa25O2qeMvEujmC9bYCN4TBchQ
         cBLA7SAavyJo6Uu17zjeGGGCv5u/6oY2S/rEI=
Received: by 10.227.129.12 with SMTP id m12mr245969wbs.102.1280415184317; Thu, 
	29 Jul 2010 07:53:04 -0700 (PDT)
Received: by 10.227.141.29 with HTTP; Thu, 29 Jul 2010 07:53:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152178>

Hi,

I have hard times trying to understand submodules and superprojects
(also I'm knew to git).
Here we use Clearcase (yeay...) and I would like to use git on top of
it on my desktop.

There's a project stored in two clearcase vobs.
What I did is "git init", "git add ." and "git commit -m "initial
commit"" in both clearcase vobs.
I created then a directory (D:/myProject for example) and in this
directory I did "git init", "git submodule add Y:\myview\projA" and
"git submodule add Y:\myview\projB". And finally "git commit -m
"initial commit"".

It is working fine, I build it with hudson specify the "D:/myProject/.git"repo.

How should I update it now ?
I believe I have to do "git add ." or "git commit" in both vobs
corresponding to the first two repos when new dev are added there.

What should I do next ? I don't think an add or a commit is needed in
the superproject. I don't see any changes when building my project.

I hope it is clear enough.

Thank you.
