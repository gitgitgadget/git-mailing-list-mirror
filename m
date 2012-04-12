From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: How to always use --merge option in git rebase?
Date: Thu, 12 Apr 2012 13:31:59 -0700
Message-ID: <CAGAhT3k4Hztbn8139LBuRFxTJgKxDzZcJR=L2A5o9rQBVuVMEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:32:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIQgZ-0003wp-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 22:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667Ab2DLUcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 16:32:01 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50493 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab2DLUcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 16:32:00 -0400
Received: by yenl12 with SMTP id l12so1355970yen.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+BwXbfy3Gcosu4YxQNjEjh1YenrzwXJCQMvKMPEzmh4=;
        b=rV0+awc7ortjE3CsfKXJxMowW47fxcz5gimSYrJK9a9x/7Z+2jt1na57O21DXMQV9o
         QKVezPsJZFvhaLbEjc0Hze8UOZimb4q1QpZsK2RcRqi8zfTFMUyyNfnK7gblVF5o9ezA
         K0HKtDWFXCENU2D1NcM4+xvpVZ5HGLFqWTrrjhgqh90/ErxGfIgGJVDdvGWXT9gkL3BX
         Q/I8AbhjAeiWl8HBfm9tvOWU3QDxlto5WU7uCtJwEi2z/KttJ7mfQp7vCPwQBH3by7NX
         TiNRlTEVqQP4v/yHTmYC9v50AAzZBaYHixZq3yAdRpvVeN6CFkypZwc/XoVSYPoppRZ/
         hMuQ==
Received: by 10.236.78.74 with SMTP id f50mr3461569yhe.26.1334262719850; Thu,
 12 Apr 2012 13:31:59 -0700 (PDT)
Received: by 10.146.84.15 with HTTP; Thu, 12 Apr 2012 13:31:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195363>

Hi,

We have a huge repository ~10 GB. After some integrations the following happens:

> git rebase master
First, rewinding head to replay your work on top of it...
fatal: Out of memory, malloc failed (tried to allocate 55012353 bytes)

There is a workaround to use 'git rebase --merge' instead. But I
couldn't find a way to make the merge-based rebase the default one. Is
it possible?
git version 1.7.10.msysgit.1

-- 
Alexander Kostikov
