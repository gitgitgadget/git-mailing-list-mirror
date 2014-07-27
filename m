From: Guang Chen <cgcgbcbc@gmail.com>
Subject: git add -i failed in 2.0.3
Date: Sun, 27 Jul 2014 23:26:17 +0800
Message-ID: <DB19F40E-912E-42F0-AB63-838BADAF77FB@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 17:26:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBQLE-0001qr-Vt
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jul 2014 17:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbaG0P0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2014 11:26:22 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:42400 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbaG0P0W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jul 2014 11:26:22 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so8455671pdj.29
        for <git@vger.kernel.org>; Sun, 27 Jul 2014 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=tQwaeViASC9Iyadf0eEK5sc+jWeiHagYYDsB4MhtF44=;
        b=xm6gI7zf9I17UQpPLXZyFRvRN9Zl1jA6yvtpd3Ob/44KFODp3rZSLTNZuRQa1Xtf7b
         f/gOnRRsBBO2JjauEy+RWhvOmTE21AOYp5ztHZb1NbC25NRaD+Q9OSg1XU7eGyPHIHs6
         Krs0Wt6lf/EqgSJQrtprEooVwXKqU3LEGcHbi4VINgJ/ayznojOd98Q3AqEJuNo/7EkI
         CAnVemGq3kDL6iops0qJ+JePCc5GdvLd7MEndsgCZk98Gkwucyj5LktXAmdrcAfi1t3P
         fsPUlfBKnu7Q+KhdIEZv8yuCGx8/ft4dOj8Y4kymKjjRQIPOJB2qg4tG/ZQah9biYuGp
         kHTQ==
X-Received: by 10.68.94.34 with SMTP id cz2mr7402068pbb.7.1406474781850;
        Sun, 27 Jul 2014 08:26:21 -0700 (PDT)
Received: from ?IPv6:4006:e024:680:b295:c5fb:726d:5e87:a581? ([2402:f000:1:1501:0:5efe:3b42:51a6])
        by mx.google.com with ESMTPSA id t5sm14868077pbs.4.2014.07.27.08.26.20
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jul 2014 08:26:21 -0700 (PDT)
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254283>


I use brew upgrade git to this version on OSX. And when I use git add -i, it says:

Can't locate Git.pm in @INC (@INC contains: @@@/git/2.0.3/lib/perl5/site_perl /Applications/Xcode.app/Contents/Developer/Library/Perl/5.16/darwin-thread-multi-2level /Library/Developer/CommandLineTools/Library/Perl/5.16/darwin-thread-multi-2level /Users/guangchen/.opam/system/lib/perl5/darwin-thread-multi-2level /Users/guangchen/.opam/system/lib/perl5 /Library/Perl/5.16/darwin-thread-multi-2level /Library/Perl/5.16 /Network/Library/Perl/5.16/darwin-thread-multi-2level /Network/Library/Perl/5.16 /Library/Perl/Updates/5.16.2 /System/Library/Perl/5.16/darwin-thread-multi-2level /System/Library/Perl/5.16 /System/Library/Perl/Extras/5.16/darwin-thread-multi-2level /System/Library/Perl/Extras/5.16 .) at /usr/local/Cellar/git/2.0.3/libexec/git-core/git-add--interactive line 7.
BEGIN failed--compilation aborted at /usr/local/Cellar/git/2.0.3/libexec/git-core/git-add--interactive line 7.
