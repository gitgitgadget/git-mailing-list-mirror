From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [gitolite] (security) problem with deleted or renamed pubkey files
Date: Tue, 20 Apr 2010 19:57:06 +0530
Message-ID: <o2v2e24e5b91004200727le913dd21lc88603ada9f057fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: gitolite <gitolite@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 16:27:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4EPz-0002PQ-LR
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 16:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab0DTO1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 10:27:10 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44868 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab0DTO1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 10:27:08 -0400
Received: by vws5 with SMTP id 5so2943768vws.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=B3RmFDbOJ/sCn0HZX0Fr7nvzHZQNB5vmiWAkzrMvNns=;
        b=egm2f03QKMR3zDLBMoV/q4fTfr3WxO5yml+McobB+YHQzW9+8Txvstk/+mOPN1V3xT
         8Xuz6evz8MRjBqkaD44RxGMJUBj0J8NBsXdkRr4P5J3x0ObkMHOSIvc3MPwnnsM3czur
         ml5DB3JWvDnasbTwY+w8aHkRtsETRiZs/q6Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=BGmpW8NtFSxirgY8xSINoulT5SlpwFiMpxbJlRDDhJL3FOQHFn+Yhh4imdJKFt4Z+y
         PB9NuITgqxlms0Q3pKDV2O5c75ZZMJJeOFE/MQthHphPPDDS4JSI2/r53vNXV75dJeyK
         CTQZbeBuTG1Q2PW0l8Pi2QhpfIFUpp68NPcW4=
Received: by 10.220.98.73 with HTTP; Tue, 20 Apr 2010 07:27:06 -0700 (PDT)
Received: by 10.220.62.200 with SMTP id y8mr4724683vch.90.1271773626814; Tue, 
	20 Apr 2010 07:27:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145378>

If you deleted or renamed a pubkey file after 5fd9328 went
in (April 12th), please:

  - upgrade asap, then
  - go to your latest gitolite-admin clone and "git push -f"

Otherwise this is not urgent and does not affect you.

Please see the latest "master" commit (1e06fea) for more
details.

Sorry about that, and of course feel free to email or holler
at me on #git :)

Sitaram
