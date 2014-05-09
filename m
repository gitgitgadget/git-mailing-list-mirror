From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANNOUNCE] git-remote-bzr 0.2
Date: Fri, 09 May 2014 11:27:00 -0500
Message-ID: <536d01d41a7e1_4725b1d30cbf@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Christophe Simonis <christophe@kn.gl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 18:27:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Windg-0000NP-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 18:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbaEIQ1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 12:27:08 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36079 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbaEIQ1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 12:27:07 -0400
Received: by mail-yk0-f179.google.com with SMTP id 19so3620325ykq.24
        for <git@vger.kernel.org>; Fri, 09 May 2014 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=3WkzjnHlVE8rn12upZv/zBiFMoif5NgUnt9xNZPglfI=;
        b=Jsdpz7Bp34z3ybena36bT459tlqbq5TqzNuZiGxnkKxePaYB+Digbx0Lirn0ODSJp7
         y6Ud0eDK2hNi3WS26bAIzSvQLdiXxOLMzxdlQc+kp+bnies2qQIelorsRceqEfEE4SH+
         MFVYiAvl06BCmD6vNqW70PxjJT1hEKN6ED1xYdqLVHYYbnvI4ct0T+dUCdbSDb9DRo0q
         9AID6a7H2Q1SLgXjDBMiD0XsRiiYcA84qRN6HK5SdSavLuXGZYI8FP/V9fkeByIavjVo
         E9Y0CyzgvOeC32yhn+uk90FrBrywyxc/D/RaYZipZtCPIdDHtqJtDluIDEdsWcAuiAMG
         yCRA==
X-Received: by 10.236.19.99 with SMTP id m63mr15972967yhm.134.1399652826581;
        Fri, 09 May 2014 09:27:06 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id n32sm6793191yhp.53.2014.05.09.09.27.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 09:27:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248583>

Hi,

git-remote-bzr is a bidirectional bridge between Git and Bazaar. It is
production-ready, has been widely tested, and was previously part of
git.git.

As I already explained[1], there is no path forward for git-remote-hg
and git-remote-bzr; Junio C Hamano has retracted from his previous
statements where he wanted these tools to become part of the Git core
and distributed by default.

So it's time to move out-of-tree so they can be packaged and distributed
properly (as properly as any out-of-tree tool can).

Changes from v1.9 upstream:

 * Add manpage
 * Fix regression that will become active in Git v2.0
 * Add support for older versions of bzr

If you use ArchLinux, you can use the package I wrote[2].

Enjoy :)

https://github.com/felipec/git-remote-bzr

Felipe Contreras (10):
      Reorganize test
      Add README
      build: add install instructions
      doc: add manpage
      Add support for older versions
      Trivial test fix
      Store marks only on success
      test: fix redirection style
      travis: add initial configuration
      Use python2 instead of python

dequis (1):
      Include authors field in pushed commits

[1] http://article.gmane.org/gmane.comp.version-control.git/248561
[2] https://aur.archlinux.org/packages/git-remote-bzr/

-- 
Felipe Contreras
