From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: "Medium" log format: change proposal for author != committer
Date: Tue, 15 Sep 2015 21:52:33 +0000
Message-ID: <robbat2-20150915T214920-375711965Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 23:52:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zby9d-0008H5-1y
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 23:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbbIOVwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 17:52:40 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:55159 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbbIOVwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 17:52:40 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 60038340C59
	for <git@vger.kernel.org>; Tue, 15 Sep 2015 21:52:34 +0000 (UTC)
Received: (qmail 18628 invoked by uid 10000); 15 Sep 2015 21:52:33 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277985>

Hi,

I want to propose a change to the 'medium' log output format, to improve
readability.

Specifically, if the author is NOT the same as the committer, then
display both in the header. Otherwise continue to display only the
author.

This would aid quick review of changes in git-log & git-show output.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
