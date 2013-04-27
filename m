From: Ilya Basin <basinilya@gmail.com>
Subject: git-svn --preserve-empty-dirs: Failed to strip path
Date: Sat, 27 Apr 2013 11:28:32 +0400
Message-ID: <917648658.20130427112832@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 09:30:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVzaT-0001oO-HP
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 09:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab3D0HaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 03:30:14 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:51954 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab3D0HaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 03:30:13 -0400
Received: by mail-lb0-f177.google.com with SMTP id x10so4393124lbi.36
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=+aHdi8ex4h1JXCQNo8tAygwHnv8umnDo62Yj/3sT8eI=;
        b=UAgh1ElSwstp8blGz0WP2N8+LOGMuWadjDE+rGq7QFkCyEFxUrdbhcwhTi+meehYwo
         s0rDkvJcv8JOWunO/oBURQ9m25Bm+UcxFV6TmonAZeYPYOnxzDqb4F4MoDWyM/veyquo
         1wUq13Sk0WLfJ8yzOU8WXQV/BJVptlrxWksYFu57S3P2WeKECdB8MlezaLKCo6EXiceU
         om3DCKXAfCQ/IFQ8/pdUu8nsgaikG1riz27iSMfRI0aZUAbUfACzisW1DvBvnBSFWBCq
         JmXS3neVyStayc/8KezWcBnWnyRMkYrduP3aN/qgW5bLbHINtdQc24OJSpsPk+5Qk2jD
         GEEA==
X-Received: by 10.112.147.38 with SMTP id th6mr6675981lbb.119.1367047809064;
        Sat, 27 Apr 2013 00:30:09 -0700 (PDT)
Received: from [192.168.0.78] (92-100-233-116.dynamic.avangarddsl.ru. [92.100.233.116])
        by mx.google.com with ESMTPSA id w6sm5897590law.8.2013.04.27.00.30.07
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 00:30:07 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222623>

Hi.
I ran 'git svn init', then
    git config svn-remote.svn.preserve-empty-dirs true
    git config svn-remote.svn.placeholder-filename ".gitignore"
then 'git svn fetch' and I get this:
    ...
    r897 = dc26a4628a0e1fb79452a3f1953fbdc1feae69d1 (refs/remotes/svn/trunk)
            M       pom.xml
    Failed to strip path 'ADDBackEnd/api/src/main/java/com/sicap/dmc/addbe/api/services/local/.gitignore' ((?-xism:^trunk(/|$)))
