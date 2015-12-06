From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Show total commit count of two authors or more authors into first author
Date: Mon, 7 Dec 2015 00:53:35 +0530
Message-ID: <CAD6G_RQ2Ub8HasupNbUFK2LJfir25tNFTqrqU2ELoEJHOibzHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 20:23:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5euM-0007gA-7L
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 20:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbbLFTXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 14:23:40 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35951 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbbLFTXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 14:23:39 -0500
Received: by lfs39 with SMTP id 39so136909496lfs.3
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Bz6sWRmexJNQsFO5SBEydfvEoLlINMKV9IWK1CUErkw=;
        b=cZWxPholT+ae3MBySaRlCgLT3qpgx8XVlcAPDu9Mr4vt38LYDSfimmwhZOPEO3TULp
         wltOF+AAMgCV3LjDFr4nPNNoNQYyeiU5YG2MmUyDyIvkNbYbePTNY2DL/I31zsgLnGLI
         vZuisidqUKHoRuSU4wYJw4uXczDnLtn1vDt0vFA1awdRN5ERYGWS2zk/xJ10tB/VxSO3
         IvMVXY4U2Dqm6blMFpq2JCivcT7hh6XBtIy5GUSsGD5EbQXTBJBxWQ+puflLKAFp+jai
         T0LqwO3nwBevrtdyCCApcOrvFMWyQ/dCbaK9M8V8N0E3/cl7kjUmWqoEdfKs9uU3E0oD
         pNJQ==
X-Received: by 10.25.85.78 with SMTP id j75mr11884814lfb.46.1449429815453;
 Sun, 06 Dec 2015 11:23:35 -0800 (PST)
Received: by 10.25.209.206 with HTTP; Sun, 6 Dec 2015 11:23:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282059>

I usually count commits as below command

$ git shortlog -s -n
   149  Jagan Teki
   148  Otavio Salvador
   143  Bo Shen
   137  Lokesh Vutla
   134  Minkyu Kang
   132  Marian Balakowicz
   129  Haavard Skinnemoen
   127  Holger Brunck
   124  Tim Harvey
   122  Jagannadha Teki
   120  Daniel Schwierzeck
   119  Eric Nelson
   118  Andy Fleming
   116  Jagannadha Sutradharudu Teki

Out of which below three names are with same author which changed
while submitted patches.
  149  Jagan Teki
  122  Jagannadha Teki
  116  Jagannadha Sutradharudu Teki

I need a command to show to add all commits and show first one as
   387 Jagan Teki

Can anyone help to do this?

thanks!
-- 
Jagan.
