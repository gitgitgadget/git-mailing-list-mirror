From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: measuring the % change between two commits
Date: Thu, 23 Feb 2012 17:00:40 +0530
Message-ID: <CAMK1S_gXQaE+RZxe4S7vqAyPka9N9PAoe+557FaLO+JJoJFshA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 12:30:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Wsp-0001S0-9w
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 12:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab2BWLal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 06:30:41 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:45572 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752777Ab2BWLak (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 06:30:40 -0500
Received: by obcva7 with SMTP id va7so1270838obc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 03:30:40 -0800 (PST)
Received-SPF: pass (google.com: domain of sitaramc@gmail.com designates 10.182.231.97 as permitted sender) client-ip=10.182.231.97;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sitaramc@gmail.com designates 10.182.231.97 as permitted sender) smtp.mail=sitaramc@gmail.com; dkim=pass header.i=sitaramc@gmail.com
Received: from mr.google.com ([10.182.231.97])
        by 10.182.231.97 with SMTP id tf1mr325449obc.32.1329996640339 (num_hops = 1);
        Thu, 23 Feb 2012 03:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=g/aaeMAYj6K1nT069JDMdd7UnUtwJQNqh2ZOr0xR44c=;
        b=iHJs8Yq/f1t9rYR5TDSkn1bplrayU2Ep4ogB8auFdynHhI0J/6wQ170fDwSwNc5YT0
         Uv75wbIfIEDuDZ2Z5gaaIq6ZbzpFTVDv4wXZ3/48/GgPRuQ9SQqWQB8HTwVMDBCPHCm2
         36nRLNKQw778F0vWr3ifkxI4Epq31oyBVz32k=
Received: by 10.182.231.97 with SMTP id tf1mr287099obc.32.1329996640261; Thu,
 23 Feb 2012 03:30:40 -0800 (PST)
Received: by 10.182.175.106 with HTTP; Thu, 23 Feb 2012 03:30:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191352>

I'm trying to come up with a % measure for the changes between two commits.

I don't mind how precisely it is calculated, since this is only for a
thresholding purpose where we can adjust the threshold if the way it
is calculated is not what we think it should be.

The logging options that put out a % figure only do so for
copied/renamed files.  Merely modified files do not get a % figure
attached.

I could do a --numstat and then do a 'wc -l' on each file I guess, but
I was hoping to avoid that.

--dirstat gives you a percentage but does not count the top level directory.

Any ideas?

-- 
Sitaram
