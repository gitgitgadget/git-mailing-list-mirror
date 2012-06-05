From: Paul Harris <harris.pc@gmail.com>
Subject: subtree woes
Date: Tue, 5 Jun 2012 15:14:21 +0800
Message-ID: <CAMSUDdaZ1W0h2D_yGnei3rOEYJXDkuCYJms1yHTwYHBFEKvcFQ@mail.gmail.com>
References: <CAMSUDdYj=GJx3LwSq98bLLXpEDWjR9ssHi=rdh1Q=zopZzAm_w@mail.gmail.com>
 <CAMSUDdZ0BX8E26haZ-V-Grm42PaWFm3eXuSAJBcUg1LFvis7mA@mail.gmail.com> <CAMSUDdaKu7f+A3wwsWDOA1W071xunssixrWwCi1Uz21k4DFcBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 09:15:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbnyw-0002RU-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 09:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab2FEHPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 03:15:04 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40440 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab2FEHPD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 03:15:03 -0400
Received: by wibhn6 with SMTP id hn6so3600699wib.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=EJcEiHSFtRv2fgdRPfyaIY6Gf9a6BDUd1M+70E4UeGw=;
        b=WsqBXPdnbWGG1DcYn6qn234ll7FUcm1Tmt+32AarIgjfuGhGly8YmIafz1hiCdpaEC
         Md0/CCFsCWC3qKDUGCFnU4fNtVz1DL3TCNyZyCOwbaJ5J7wrjU6OZf08kDZKZ7U9hlD/
         7R6/z/nZhpWKbVNXFN5Im8bH58VsbaYnDFQlTMwq5x1tkCtrxLAmIreE6RvGXuKMklZc
         rvfenqcvoJvQb8zNPdCsrl9dhqavqG3G1duH4Jmc5x4vSAxtT2h+sjis77sTvsUSuWbi
         eynNUs2vXik/qsnNMa/nVnnXpb5QvluJ3pHFNkdBBcG4sMz/2A8PC9gpPxZE2pR8rfY3
         0khw==
Received: by 10.216.143.206 with SMTP id l56mr13738973wej.15.1338880502154;
 Tue, 05 Jun 2012 00:15:02 -0700 (PDT)
Received: by 10.223.154.202 with HTTP; Tue, 5 Jun 2012 00:14:21 -0700 (PDT)
In-Reply-To: <CAMSUDdaKu7f+A3wwsWDOA1W071xunssixrWwCi1Uz21k4DFcBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199209>

Hello,

I'm shifting my projects to use a subtree system, and I'm having some trouble.
Looks like I'm hitting a subtree-merge bug, although I thought they
were all fixed by now.

I'm using cygwin, git 1.7.9 and apenwarr's git-subtrees repo.
I've also tried git 1.7.10.msysgit.1 with apenwarr's git-subtrees.

I've created a repo on github with a test:
https://github.com/paulharris/subtree_test

The procedure is described in the readme, and has the results too.

In short, I set up a superproject, with some subproject/subtrees.
I have a branch that is my subtree, and now I want to merge it,
like so:
git subtree merge -P zlib origin/subtrees/zlib

Instead of merging the subfolder, it clears the super-project and all
I am left with is the zlib project !

thanks!
Paul
