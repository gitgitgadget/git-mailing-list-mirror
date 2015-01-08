From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: [ANN] SVNGit - Checkout Git repository by SVN Client
Date: Fri, 9 Jan 2015 01:45:58 +0900
Message-ID: <CAFT+Tg8xpFWJ2ucHn1Y2CsiqH6oZbRPzbxBnbOOE2b=StEJrTA@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 17:47:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9GDl-0006C0-6V
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 17:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbbAHQqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 11:46:00 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:62871 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbAHQp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 11:45:59 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so8980473obc.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 08:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=Q28/BJyVwGJaCVn7tEufc36nl3syvk1WCyxfP3GYbk0=;
        b=1DWYfRmiL2nOep2Wfzl0spebcLZ0FtscdStviD6L8SMnx5ZWqzN0stKC+fIJD7VIQz
         t2S21Mp81u6WdM7pcIOpcY9Jol1u9vjjLbza+81UxoSfawjN3SqqdCN1ucSuiYpTcj1x
         XONn0BQ2sDYCWQFoBCFgPBQSpExsjeRGFZZKUJtve9kvv2z1T55Mo7tbqPIOy8wyY2zp
         SrRZHgN5OIsZy565JkANYsSjAxfvnq5fPXx9bL4rV/b/f1/jcEFUM4XMb1OHfikZIoXY
         ABVcJkZHAa3kfbRqPSE0SITGoHXbLGe88SmS6XVCWGmBufIoDIgLvTtBxBUrTmF1VvqV
         0Npw==
X-Received: by 10.60.124.225 with SMTP id ml1mr6251379oeb.78.1420735558586;
 Thu, 08 Jan 2015 08:45:58 -0800 (PST)
Received: by 10.202.85.144 with HTTP; Thu, 8 Jan 2015 08:45:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262200>

Hello, all.

I just have started to develop SVNGit, the servlet library in pure
Java for SVN Client to checkout Git repository. The project is hosted
at https://github.com/naver/svngit.

Since the project is at very early stage, SVNGit unstably supports
only a few SVN commands: checkout, update and log.

SVNGit is based on SVNKit to accept HTTP(DAV) requests from SVN client
and uses JGit to access Git repository.

If you have interest in my project, please download it and test with
your Git repositories. I will be very happy if you give me a comment,
a bug report and/or a pullrequest.

Thank you for reading.
