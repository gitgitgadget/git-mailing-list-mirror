From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/9] mark Windows build scripts executable
Date: Mon, 25 Nov 2013 12:52:44 -0800
Message-ID: <20131125205244.GR4212@google.com>
References: <20131125205119.GQ4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 22:00:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3H3-0003Mf-QJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 22:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab3KYVAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 16:00:49 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:47168 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab3KYVAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 16:00:49 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so3309780yhz.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 13:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=apD10ITkLpWcz+6fRzXjF0q97surNGj/BFQVCENzCs4=;
        b=V+eIjWAvNfo1V6V9l1CzpsHu8k6q3oDlVyp+dbxAr/99VsTvfeg3KsRkIlLsR2Fg2v
         xz9qOLIotFQm1sf9SlPwAlm3qXAtYyydgjwikymd7WbUo5UaLzOA1u+aP33oyObsx8VW
         RHM5ooNk/ef31mBTLWNzZeDWAmRmgXj7q2MIZPujc19wPvc9MB2FgQsS7E6NkEwWRK7j
         GgFjsnyuWHLUBmm1HWcGryGJ5/iQ2TecCbo7ocVggftB9bAy4mkS9kBEtt2OTK5o6vj4
         PaT9oqAss7kh2n7M20jP06vrQMtYFr4RQ0G87LlivCudtfOIG4P0a3wWQjlpiGUMNkMT
         Kx9A==
X-Received: by 10.236.150.202 with SMTP id z50mr9014406yhj.49.1385412767592;
        Mon, 25 Nov 2013 12:52:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m29sm76379259yho.14.2013.11.25.12.52.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 12:52:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131125205119.GQ4212@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238353>

On Windows the convention is to rely on filename extensions to decide
whether a file is executable so Windows users are probably not relying
on the executable bit of these scripts, but on other platforms it can
be useful documentation.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 compat/vcbuild/scripts/clink.pl | 0
 compat/vcbuild/scripts/lib.pl   | 0
 contrib/buildsystems/engine.pl  | 0
 contrib/buildsystems/generate   | 0
 contrib/buildsystems/parse.pl   | 0
 5 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 compat/vcbuild/scripts/clink.pl
 mode change 100644 => 100755 compat/vcbuild/scripts/lib.pl
 mode change 100644 => 100755 contrib/buildsystems/engine.pl
 mode change 100644 => 100755 contrib/buildsystems/generate
 mode change 100644 => 100755 contrib/buildsystems/parse.pl

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
old mode 100644
new mode 100755
diff --git a/compat/vcbuild/scripts/lib.pl b/compat/vcbuild/scripts/lib.pl
old mode 100644
new mode 100755
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
old mode 100644
new mode 100755
diff --git a/contrib/buildsystems/generate b/contrib/buildsystems/generate
old mode 100644
new mode 100755
diff --git a/contrib/buildsystems/parse.pl b/contrib/buildsystems/parse.pl
old mode 100644
new mode 100755
-- 
1.8.4.1
