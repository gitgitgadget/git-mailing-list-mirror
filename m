From: Jonas 'Sortie' Termansen <Sortie@Maxsi.org>
Subject: Re: [PATCH 4/9] autoconf: Check for timer_t
Date: Fri, 29 Aug 2014 20:20:54 +0200
Message-ID: <5400C486.6060909@Maxsi.org>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com> <1409330561-11806-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 20:21:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNQnE-0001Y7-Hg
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbaH2SU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:20:56 -0400
Received: from csmtp2.one.com ([91.198.169.22]:56927 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbaH2SUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:20:55 -0400
Received: from [192.168.1.2] (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp2.one.com (Postfix) with ESMTPA id 9E75140014706;
	Fri, 29 Aug 2014 18:20:53 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1409330561-11806-4-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256173>

For the record, this commit doesn't contain my errata for OS X:

ifeq ($(uname_S),Darwin)
...
 	HAVE_DEV_TTY = YesPlease
+	NO_TIMER_T = UnfortunatelyYes
 	COMPAT_OBJS += compat/precompose_utf8.o
...
endif
