From: Len Brown <lenb@kernel.org>
Subject: Re: Segmentation fault in git read-tree
Date: Fri, 14 Mar 2008 14:24:27 -0400
Organization: Intel Open Source Technology Center
Message-ID: <200803141424.28034.lenb@kernel.org>
References: <200803132359.06745.lenb@kernel.org> <7vejadvrk7.fsf@gitster.siamese.dyndns.org> <7vskytuc55.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 19:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaEbY-0001aR-Hk
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 19:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbYCNSZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 14:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753735AbYCNSZE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 14:25:04 -0400
Received: from hera.kernel.org ([140.211.167.34]:40611 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755596AbYCNSZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 14:25:03 -0400
Received: from t61 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m2EIOYsu026923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2008 18:24:37 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vskytuc55.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.7/6230/Fri Mar 14 14:23:10 2008 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77269>

confirmed fixed.

thanks guys, for the great support!

I'm pleased that I can (almost fearlessly) update git on a daily basis.
On the rare occasion I run into issues, you kill 'em quick.

-Len

[lenb@t61 acpi (test)]$ git merge test suspend
Already up-to-date with 5dceb6d3377c3cbd06f7b3282fec0e201273c302
Trying simple merge with c68a5009ab9938af22af668e0e2d646d2482c866
Merge made by octopus.
 arch/frv/kernel/pm.c            |    8 --
 arch/mips/au1000/common/power.c |   35 +-------
 arch/x86/kernel/apm_32.c        |   15 ---
 kernel/power/Kconfig            |   10 --
 kernel/power/Makefile           |    1 -
 kernel/power/pm.c               |  205 ---------------------------------------
 6 files changed, 1 insertions(+), 273 deletions(-)
 delete mode 100644 kernel/power/pm.c
[lenb@t61 acpi (test)]$ git version
git version 1.5.4.4.551.g1658
