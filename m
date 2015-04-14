From: Josh Hagins <hagins.josh@gmail.com>
Subject: Error staging submodule removal when empty directory present
Date: Tue, 14 Apr 2015 14:23:27 -0400
Message-ID: <CANuW5x3N07ftrYmTF8LihHNEUsA=nn=b_EcOQ7BPYjOMfkDtVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 20:24:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi5VF-0004zC-GE
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 20:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933142AbbDNSYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 14:24:00 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35580 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbbDNSX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 14:23:58 -0400
Received: by iejt8 with SMTP id t8so22212006iej.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=GZFaLy/qMmgV97NikDc+zBaf2gv/iXZTE7H/2x2InJs=;
        b=uLYG4OCxCNPFyIzwODNekQHUJ/hzTLkfkJCzJ/aocdFwdFhH/VYSLvHWrGKt7Wm0vT
         Z9KeKqGNhGadG8NFkqYRSGwRDzHmeaZy5okOpqAb8sG8lkZM1FXedwDKrsIQ7TyHKlpg
         anyajCTZaaPDopYMxWunj/LCflLVtaJjp96SM+MXnpSE3AfhVXY+fGHJwKhsiWEcLhtm
         OX6Yl0Uu5qgzlcmvKixn+37iyKo1dZ+HSXjfYkx2C0fGe+3foAPh7u6Azn6zLSDJdn7/
         vZ+cN8+2xwm+cGfQHN5WjZgV0Hty5ao7IUEsycpRHJb+Ws/AZLk6MRLI+lpH1WF0miVn
         SdZA==
X-Received: by 10.50.143.42 with SMTP id sb10mr25932803igb.49.1429035838112;
 Tue, 14 Apr 2015 11:23:58 -0700 (PDT)
Received: by 10.50.41.8 with HTTP; Tue, 14 Apr 2015 11:23:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267156>

I'm having a hard time understanding why ``git stash save" chokes on a
submodule removal when an empty directory is present at the removed
submodule's path. If the submodule is staged for deletion, why not
just leave the empty directory alone?

The following Gist illustrates the situation I am encountering, and
includes OS information, Git version (2.3.5), and GIT_TRACE output:
https://gist.github.com/jawshooah/d60ff70952cff18099d7

Relevant post in the git-users Google Group, where I was encouraged to
query the mailing list:
https://groups.google.com/forum/#!topic/git-users/3YxxpVVXtqg

Thanks,
Josh
