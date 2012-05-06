From: Steven Penny <svnpenn@gmail.com>
Subject: Git commit path vs rebase path
Date: Sat, 5 May 2012 23:24:16 -0500
Message-ID: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 06:24:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQt1i-00086x-BL
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 06:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786Ab2EFEYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 00:24:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44808 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab2EFEYR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 00:24:17 -0400
Received: by obbtb18 with SMTP id tb18so6346663obb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 21:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1UJaKSuIrce12xN9bLdidmu8Ho0P9qQsFQqywjQKpX4=;
        b=G01IDc9SK7TahjNz21GVrsy6kXR29uPxbxF8cdJ8ok6OYZ4TtVfywoVLOZqkYJnlZd
         6R8yogEzQhVSd+/PigGPHd40xrn8lVVyzxQNhKIc1L/OAvML2yqjJ7xjpmkoOOWth6cP
         wB0BtlqdZKbIF2HYmQD6aEC2Z5/cOefKvesgjP/yyGmrcmJw7aUCplf/v1k+3PD7iOmQ
         y6K3P5tQkUDeiM3a01pAp2Nx+NroKaUdDc03v7eqzjQvX+hdVnnN6j6DI9SWis9OXNpL
         v29WeCaQUVTe4asyB6uHEh42AKwv3IDvx9gLpd6pbqaQtXdariCEakNXc5lpxVnvatJE
         jW8Q==
Received: by 10.50.160.225 with SMTP id xn1mr2836554igb.3.1336278256764; Sat,
 05 May 2012 21:24:16 -0700 (PDT)
Received: by 10.231.80.147 with HTTP; Sat, 5 May 2012 21:24:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197147>

I have noticed

git commit uses this path

.git/COMMIT_EDITMSG

git rebase uses this path

/home/Steven/jquery/.git/rebase-merge/git-rebase-todo

So git commit is using a relative path while git rebase is using absolute path.

This causes problem in Windows if your editor does not understand linux paths,
e.g. notepad, Notepad2, Notepad++, etc.
