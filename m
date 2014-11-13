From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: t9902-completion.sh failed
Date: Thu, 13 Nov 2014 16:59:12 +0600
Message-ID: <87mw7v9xhl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: "git\@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:00:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xos8R-0004PT-SR
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbaKMLAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:00:12 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:61588 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbaKMLAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:00:11 -0500
Received: by mail-la0-f42.google.com with SMTP id gq15so13174388lab.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 03:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type;
        bh=Zjm48+/C7Q6hsUgJdhGSMzM/sZLjJtF7m6rxjZSHYh8=;
        b=Gx3kOb2dwRStQVNh2iXxWJgJ1pJuQ/o5U/PPk6G4G4utigRmBWhMLmNz+o/EBZQ/Eh
         E0kgb3+qeF6q03cwF92KNqJcVf/Sbe9va+XXxZYuniZD+FgZ9nWTJrUr8YQsNKYV55aW
         XcrGO79Fm6h6H1VKiQrxmyBBdI7xQdfapspra6RSXkm5QmN7DTkBqgDKAMud7irYBUqC
         ZFrlP9lhhhp16ludPwSD54SmaYTMn81duMOqSbPGixhQBhh1JHsNEzLW3URHXWdikNaA
         3BMzZKZc/IHXQlh5Fb60DGzNUkMb2kqLgkv7g9RiajUtFbSOdcHxSKYLbEKGsaHVyGGf
         1n/A==
X-Received: by 10.112.42.114 with SMTP id n18mr1749028lbl.44.1415876409110;
        Thu, 13 Nov 2014 03:00:09 -0800 (PST)
Received: from alex-desktop ([92.46.69.219])
        by mx.google.com with ESMTPSA id o10sm7375830lal.37.2014.11.13.03.00.07
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 13 Nov 2014 03:00:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello all,

i just got git from master (f6f61cbbad0611e03b712cc354f1665b5d7b087e),
built and installed it successfully, now i'm running make test and got
following error:

*** t9902-completion.sh ***
t9902-completion.sh: 118:
/home/shk/dev/git/t/../contrib/completion/git-completion.bash: Syntax
error: "(" unexpected (expecting "fi")
FATAL: Unexpected exit with code 2
make[2]: *** [t9902-completion.sh] Error 1
make[2]: Leaving directory `/home/shk/dev/git/t'
make[1]: *** [test] Error 2
make[1]: Leaving directory `/home/shk/dev/git/t'
make: *** [test] Error 2

$ bash --version
4.3.11(1)-release (x86_64-pc-linux-gnu)

--
Best regards.
0xAX
