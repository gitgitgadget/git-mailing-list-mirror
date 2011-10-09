From: "fkater@googlemail.com" <fkater@googlemail.com>
Subject: Check revision and if no files modified (looking for svnversion
 equivalent)
Date: Sun, 9 Oct 2011 18:29:02 +0200
Message-ID: <20111009162902.GA3000@comppasch2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 18:28:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCwEq-0003NZ-Bj
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 18:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab1JIQ2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 12:28:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64577 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab1JIQ2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 12:28:21 -0400
Received: by bkbzt4 with SMTP id zt4so7352129bkb.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=/lXXp9uFPwoJ2VfIq+7KVoJ6qdiDZXjlFl8sdMbQ47o=;
        b=tWdKB4V0O5wMn4m9iv8PZL8lBZkq4N+vxObwdSEOHsaPafzhSTAEf+3hvrkXc7BVIB
         dBXnj/fTqnfoc33F/MvUJYDPUyvsvtnjk8S52swZ2DS/7560zOmowp+suGamf7ZHe8aP
         aA15039nGneVUp4VG635U0eXgpSBwRTKa8TZ8=
Received: by 10.204.135.24 with SMTP id l24mr1774744bkt.57.1318177700217;
        Sun, 09 Oct 2011 09:28:20 -0700 (PDT)
Received: from googlemail.com (g225045091.adsl.alicedsl.de. [92.225.45.91])
        by mx.google.com with ESMTPS id e14sm15033231bka.0.2011.10.09.09.28.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Oct 2011 09:28:19 -0700 (PDT)
Received: by googlemail.com (nbSMTP-1.00) for uid 1100
	(using TLSv1/SSLv3 with cipher RC4-SHA (128/128 bits))
	fkater@googlemail.com; Sun,  9 Oct 2011 18:29:04 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183204>

Hi,

in my subversion software repository I use the 'svnversion'
command to do both:

- get the last revision (e.g. r1001)
- check for modified files not yet checked in (e.g. r1001 M)

Both information is required for the application's build
process (Makefiles):

- to display the version in the application
- to refuse to build a proper 'release' version if something
  was not checked in

Would there be a way to do both in git somehow?

 Felix
