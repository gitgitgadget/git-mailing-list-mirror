From: =?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>
Subject: possible to checkout same branch in different worktree
Date: Fri, 15 Apr 2016 15:53:47 +0200
Message-ID: <CAJZYdzhG8h3s=Ep1fuGbam1cWhYkv0tW6tQ7pBGGj+fj6=Nrsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 15:54:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar4Ca-0001Xq-VN
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 15:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbcDONyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 09:54:19 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33977 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbcDONyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 09:54:18 -0400
Received: by mail-lf0-f49.google.com with SMTP id j11so146064662lfb.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q3Wk/Xxc4WIWX/Mlvy0FQIscRuFwlSkArwms1oluslY=;
        b=OhSadEMykbS8iONmafnK7VKSH544KR+cEfiUcwmkivmDHBNS1KT5xgUQI4P7jbPPRo
         rSOFI1e8Vuh4/ULuDJQxrTa3qG1wGYirWDvzGyrUXvz3m/L3vQXQOpouA5nl819Ay/np
         YPaorNEOPzT9OigErdSz6xSYJm37QTnovEXeyTFNk2rij5+6FwR8ALbg3BlQU80B25a8
         nTcIkHmEBSwH3Lm9Ai7Vv6VehgfnRmvEAZLF93bn/qVdf9wCptpu5MBKmSd1mZZPd8vs
         xc0JQBtoIVBFY1W2PjYPGvvnP9e2a5b6s2QCow6K+2TF1cl5WWajLomTi1bNQskIx8/l
         VwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q3Wk/Xxc4WIWX/Mlvy0FQIscRuFwlSkArwms1oluslY=;
        b=TUd3jh5K1F/sSH+2Aq8t8f1UFezY9PdkxOCRRNG6HAf4EcpEYN5LpoxlvXQGXDWU7/
         /G9i9O4acJlZyCR3uGnpleWkPXRqO+GT/DIACrnVCqoghxN+9hgalhxkM3XpP0PBO6RW
         Pdj1TlVUR/6QXk7BK1rzpiMrpbF5VfUkSfav6emqm1WLhgcM3GC2QncBD9NXqfgGmMLF
         TWN/fSTarG2qU23B3YK8feNKPW8vP+nzd3uj5nqwos2JfXPM4p9d2QDfOXIBuwJdjSOO
         aOszdpy56eToW3N5ryzIyGjjqkS6rUK46u3hvSDPUVzb0iv/btPt1mExg+CU5M7WFgmp
         uBvQ==
X-Gm-Message-State: AOPr4FUNyr1qAcNqSzcE3POYsYtArr2ilJhG49fvFX94CfF7ojo/rPQiofMBC/g4c0BS6mfLmJHgBCj7rmWHXA==
X-Received: by 10.112.170.68 with SMTP id ak4mr7473413lbc.94.1460728457212;
 Fri, 15 Apr 2016 06:54:17 -0700 (PDT)
Received: by 10.112.158.170 with HTTP; Fri, 15 Apr 2016 06:53:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291606>

Hi,

the checkout command prevents me from checking out a branch in the
current worktree if it is already checked out in another worktree.

However, if I rebase the branch in the current worktree onto the
branch in the other worktree, I end up in a situation where the same
branch is checked out twice in the two worktrees.

- Reto

--

PGP
Key ID = 0x67D30264
Fingerprint = E235 F740 4419 5B4B 29EC 3437 CBF2 2CB7 67D3 0264
