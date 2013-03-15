From: Kristof Mattei <kristof@kristofmattei.be>
Subject: SSH version on Git 1.8.1.2 for Windows is outdated.
Date: Fri, 15 Mar 2013 11:05:11 +0100
Message-ID: <CAJ5Q6vXTyaegQq2uMoK7QQVYiYS9GcJhCefkQs9tXxqU=M10Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 11:05:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGRWB-0001lG-5T
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 11:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab3COKFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 06:05:13 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:63543 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab3COKFM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 06:05:12 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so3008914iak.38
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type;
        bh=4F2OlzAGaVJS6S9VYBE/W9D5YWEIzKvau4xqWOxFFwQ=;
        b=tCx47IBJLj1RblXeqLIzQP+0r1rBSRZvN6lfgDmpn/CLNq1L7Qu+KBt+cDV4CYC69R
         6RwNvx3ZZPQQp8BAfbWKWOSwAWMLDiSjnwbHbRucVpXF+/q1A2RTlA5g5LSpfBJxPtnw
         nuQpTkMr10hI+Kt34xgHUDId8sg6goJ+rRzY7FhjLXpYNnM1rjhCxWfilISfoVjpCC2M
         r0pCVEP2r+IDHEZzZPwXiGLKkdnHSLPaZUXFhOQum9ACbk5HsOO+AR3V8xww4yFGUpjW
         kM1KwCIeKBuJ92v07vMKqI44I/eFgJWCz/X0jPqG/Cv13bQBvfe1o7Qg7uMFStQFuiNV
         wNEA==
X-Received: by 10.50.53.146 with SMTP id b18mr835815igp.82.1363341912004; Fri,
 15 Mar 2013 03:05:12 -0700 (PDT)
Received: by 10.64.63.7 with HTTP; Fri, 15 Mar 2013 03:05:11 -0700 (PDT)
X-Google-Sender-Auth: Y_4EbFgAROvFCLvuJ2v28zih9fs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218234>

We're having issues with the version of SSH included in git version
1.8.1.msysgit.1 (Git-1.8.1.2-preview20130201.exe)

The included version of SSH is from 2007:

C:\Program Files (x86)\Git\bin - Old>ssh -V
OpenSSH_4.6p1, OpenSSL 0.9.8e 23 Feb 2007

Updating the OpenSSH component (downloaded with Cygwin, cumbersome!!!)
resolves the issue:

C:\Program Files (x86)\Git\bin>ssh -V
OpenSSH_6.1p1, OpenSSL 1.0.1e 11 Feb 2013

Is there any way you can incorporate this update in the installer?

Thanks,

-Kristof
--
Kristof Mattei
Human Compiler

Blog: www.kristofmattei.be
Twitter: KristofMattei
