From: Dimitar Bonev <dsbonev@gmail.com>
Subject: Add porcelain command to revert a single staged file to its HEAD
 state while preserving its staged state
Date: Sat, 4 May 2013 10:34:55 +0300
Message-ID: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 09:35:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYWzk-0004Hl-O9
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 09:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082Ab3EDHe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 03:34:56 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:46648 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab3EDHe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 03:34:56 -0400
Received: by mail-pd0-f175.google.com with SMTP id y14so1254366pdi.6
        for <git@vger.kernel.org>; Sat, 04 May 2013 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=IzVFAl4gj/gMKpX0iLq+B0QWqPPOAGzB2H06MIbyl+A=;
        b=F5pgKt78dvLI391snp274kEqWH67RW5xjSmRcaP3KGWJK8Tjevo7llpg9T61y7k+ft
         lWa21DC27QvoI8PPbL0AoHt0SqzNvKcQJRAeBIh086aq0nudlxtp5Eu5ze5UhXcSlWgD
         wTgstV0K0gaWX0ngwg+vgEYPIKxhmxyLkETjwcu7AAnNvDAD+T0/Tcqn3ncQx8qQp7Jc
         EOj1LtSi2/1Ju/ZUVznjIVKz0DN0lYg3HxflFOLHh69B5nKbiGnz/eu94pdVQl8BpI80
         DkqVNfp9O2bq1OyGOTMHEgyMFG2OnltR4iwG7e97x95jMjPpuUJWzvtfGecHJgb0Ip65
         ooNA==
X-Received: by 10.68.218.8 with SMTP id pc8mr17005580pbc.115.1367652895618;
 Sat, 04 May 2013 00:34:55 -0700 (PDT)
Received: by 10.70.78.37 with HTTP; Sat, 4 May 2013 00:34:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223357>

Hi,

I have been looking for such a command/option and no one gave me
sufficient answer. So this message should be considered as a feature
request. I had a situation where I had staged a file with a problem
solution in it, then I wanted to experiment with a different solution
so I had to revert the file to its HEAD state and I couldn't find a
way that preserves the staged state of that file. More discussions:

https://groups.google.com/forum/?fromgroups=#!topic/git-users/nYiN-rE_3i0

http://stackoverflow.com/questions/16335799/git-porcelain-command-to-revert-a-single-file-to-its-head-state-but-keep-its-sta

Regards,
Dimitar Bonev
