From: "R. Klomp" <r.klomp@students.uu.nl>
Subject: (unknown)
Date: Mon, 8 Sep 2014 13:36:58 +0200
Message-ID: <CAE8x=qW7EwO9YyrQ49vYH50BFcF7RF43eVqDeVex7FKut0oaaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: p.duijst@stylecncmachines.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 13:37:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQxFs-00065l-7i
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 13:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbaIHLhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 07:37:01 -0400
Received: from mail-la0-f65.google.com ([209.85.215.65]:34535 "EHLO
	mail-la0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbaIHLhA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 07:37:00 -0400
Received: by mail-la0-f65.google.com with SMTP id gi9so1847290lab.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 04:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=ue2lQ2jJK78kcZuuMPGfmftYHB5aNkrvx0Cp8XT82QM=;
        b=Ldq1CIUkiUU1JtkP5ECDmzq2+B4jXxFpLQmRFw9sNPlPZ/1BqP/GbncL5iGDVvzSIj
         mJvk05ohJY5tFZ0P+bf4HZeh8jr7Kabt3iz3ZH3xY9HaEZaW/fxQgHB5eHoR3eXTRvRz
         +SvronkZtrK9AkUs7aNhbtUUcP3xaHIelOAA8dM1xg+CKTFFsyi0G/07rosG/GkWfH5A
         ikyVffm+UizXZfkTIf7hpSJ1m2NSlEM9zQ8NT2mTTn6msRRH0Rkpfr5thBe9L2afyxF7
         xyeXq0X5y1Wudgjnd62B/PP117gNUKbw98GnNqWjv2y6sGHRubDJUPQYempmmfuBBfII
         dCIg==
X-Gm-Message-State: ALoCoQksQY1QAYNg6HCWPE7wGzI9K7aMjZHPZvPNoYWRQqVXBp8r9WY0PREjRkQ/m6b9AMweUVCu
X-Received: by 10.152.43.46 with SMTP id t14mr28292306lal.15.1410176218800;
 Mon, 08 Sep 2014 04:36:58 -0700 (PDT)
Received: by 10.112.167.3 with HTTP; Mon, 8 Sep 2014 04:36:58 -0700 (PDT)
Subject: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256641>

It seems like there's a bug involving git difftool's -d flag and Beyond Compare.

When using the difftool Beyond Compare, git difftool <..> <..> -d
immidiatly shuts down once the diff tree has been created. Beyond
Compare successfully shows the files that differ.
However, since git difftool doesn't wait for Beyond Compare to shut
down, all temporary files are gone. Due to this it's impossible to
view changes made inside files using the -d flag.

I haven't tested if this issue also happens with other difftools.

I'm using the latest versions of both Beyond Compare 3 (3.3.12, Pro
Edition for Windows) and Git (1.9.4 for Windows).


Thanks in advance for your help!
