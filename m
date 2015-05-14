From: Pawel Por <porparek@gmail.com>
Subject: determine a linux kernel version of a patch file
Date: Thu, 14 May 2015 19:08:10 +0200
Message-ID: <CAJmOuExq3WF26Gufr5bAA7w3=EMxJ80NKMXf8Dgi0TK7kVXStA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 19:08:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YswcP-0003MV-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbbENRIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:08:14 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36715 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbbENRIL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:08:11 -0400
Received: by wizk4 with SMTP id k4so249452810wiz.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=M7U3OyBs4kF9xq5IUzZGaptKGP7vZHwDi975pAVbSrg=;
        b=WkIbRcTUkY2OjuFKP4ei7ZV5/CuN+lfoUUIsvmQegWuzZaENMWluVtsiBelFBtzEj0
         pgGIhVuvLJ2MhKU4YvJfhNQgZdNcjpJhtY0ULotsrpTeDeArrbmEwoPj7x3aMVMbLjjQ
         YSnyMLORyUual8mFhI10cfG+v6AbNJFhjivE4UBzZE8b0Eq5BlqupIWfJHOO2Zwx3WzV
         rf/FJySutyc8Si7pe6KU7XIHqGLCE02OyIh10HHi7t6IGbYtJ0VU5I6lyZwV/3agUpfK
         NXlKuphOEbDIwWC/FG71yvmIlyknFyVKfg8UIvYlHQrIIZle6SNYdPWYeaLyQ5tzd/4c
         6w8A==
X-Received: by 10.194.193.66 with SMTP id hm2mr9793939wjc.111.1431623290203;
 Thu, 14 May 2015 10:08:10 -0700 (PDT)
Received: by 10.27.143.23 with HTTP; Thu, 14 May 2015 10:08:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269046>

Hi,

At the beginning I'm sorry if this post is completely unrelated to
this mailing list.
I'm trying to find the base linux kernel version from which a patch
has been created and posted to LKML.
Most patches contain the index line. Is it the well known git index
(staging area) ?
Can I use the index to find the exact kernel version from which a
patch was created.
Please look at an example patch sent to LKML:
https://lkml.org/lkml/2015/5/14/497

It contains the following index line:
index 8dd1e55..9b0c81e 100644

I tried to find it using "git log" but I couldn't.

Please help me to determine the exact kernel version.

thanks in advance
