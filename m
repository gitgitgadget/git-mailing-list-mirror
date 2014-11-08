From: Adri Farr <14farresa@gmail.com>
Subject: --trust-exit-code not working
Date: Sat, 8 Nov 2014 18:23:48 +0100
Message-ID: <CAPfWmhg=Ok+ZQXBbiNWyhJay5h9xXkR7Vu+4u0C19EKa-OU8hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 18:23:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn9jt-0004F7-DK
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 18:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbaKHRXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 12:23:49 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:53690 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbaKHRXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 12:23:49 -0500
Received: by mail-qa0-f43.google.com with SMTP id j7so3685287qaq.16
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 09:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=rIjPWLLRdnwF61ys54LBA1DduUA1YdoawV1x3OdS0mg=;
        b=kyKrxIxMgk14E+RActif2Xw5e7O2Rqf+IMjfuZ3xZW8H6CgryLE5l8a+SOjkHQYyNl
         oN1McHnY8eILbVttRRtWirubR8loNXYXVoM3EnLF1YRPMdj1wieNqotxPt90wgUo1xTB
         HhotvG+O9pOs1+X+rUUP/cgcUUZ0IfGreTT0gwrTLxFqFM+D1nAlNuVk/J1LfMx/kb9R
         VgZroSm2VIMM3shywwQz3N8Rj3q52tWJJlCVuYJgMHhaoaHurENMN6EI31UdN6nhPO53
         MmR42hzuiX+Lp0SlgD8UaXir87rTW1azGtUk3D5oz8Je9Kn0uLqTBFUo+8GctxZDU9Qx
         94MQ==
X-Received: by 10.229.111.201 with SMTP id t9mr29056307qcp.9.1415467428255;
 Sat, 08 Nov 2014 09:23:48 -0800 (PST)
Received: by 10.229.126.6 with HTTP; Sat, 8 Nov 2014 09:23:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!,

Firstly, thank you very much to those that contributed the patch; I
truly appreciate it. I haven't been able to make it work in 2.2.0.rc1,
though. I'm not sure whether it's my fault, or the patch', but a 'git
difftool --trust-exit-code' call with vimdiff as the diff tool and
exiting with :cq doesn't seem to make it quit. git simply keeps
pushing files to be diffed. Similarly, if I set meld as the tool and
kill it, git will reopen meld with new files.

Sorry for bringing that up so late; I've been fairly busy. I did test
it some days ago and didn't manage to make it work, either.

Thank you,

Adria
