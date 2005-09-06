From: "Luck, Tony" <tony.luck@intel.com>
Subject: merge noise in git-shortlog output
Date: Tue, 6 Sep 2005 14:44:00 -0700
Message-ID: <200509062144.j86Li04N010540@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 23:45:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EClEc-0001r8-41
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 23:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVIFVoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 17:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVIFVoB
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 17:44:01 -0400
Received: from fmr23.intel.com ([143.183.121.15]:34781 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750909AbVIFVoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 17:44:00 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j86Li0Hv002585
	for <git@vger.kernel.org>; Tue, 6 Sep 2005 21:44:00 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j86Lkavq013203
	for <git@vger.kernel.org>; Tue, 6 Sep 2005 21:46:36 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j86Li0hW010541
	for <git@vger.kernel.org>; Tue, 6 Sep 2005 14:44:00 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j86Li04N010540;
	Tue, 6 Sep 2005 14:44:00 -0700
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8150>

Looking at the shortlog information for 2.6.13 there are a lot (eleven)
of changes attributed to me that look like:

  Auto merge with /home/aegl/GIT/linus

This is valid (I really did make all those commits, they happen every
time I merge the "linus" branch into my release branch, which I like to
do quite often so I'm working near the bleeding edge), but it doesn't
seem all that useful in the "short" log output[1]

If "Auto merge" isn't a good string to match for the purposes of
trimming, then I can make my scripts use something else.

-Tony

[1] unless I can persuade Intel to base my bonus on the number of
commits I get included into the base :-)
