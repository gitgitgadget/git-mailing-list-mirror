From: Tim Friske <me@tifr.de>
Subject: Why does "git log -G<regex>" works with "regexp-ignore-case" but
 not with other regexp-related options?
Date: Fri, 17 Apr 2015 12:00:55 +0200 (CEST)
Message-ID: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>
Reply-To: Tim Friske <me@tifr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 12:06:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj3Ag-0003f8-GJ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 12:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbbDQKGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 06:06:40 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:35799 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630AbbDQKGj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 06:06:39 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2015 06:06:39 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id ACBD642368
	for <git@vger.kernel.org>; Fri, 17 Apr 2015 12:00:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id tMJyKDNt0r5N for <git@vger.kernel.org>;
	Fri, 17 Apr 2015 12:00:55 +0200 (CEST)
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.2-Rev12
X-Originating-Client: open-xchange-appsuite
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267350>

Hi,

I wonder why  "git log -G<regexp>" works with the "regexp-ignore-case"
option but not with the other regexp-related options? Wouldn't it be
useful to make the "G<regex>" option support the following options?

  * basic-regexp
  * extended-regexp
  * fixed-strings
  * perl-regexp

Similarly I think it is not very consistent that one cannot combine any of
the above options with the "S<string>" but instead have yet another option
called "pickaxe-regex" to toggle between "fixed-string" and
"extended-regexp" semantics for the argument passed to option "S".

The description of the above options in the git-log(1) manpage of Git
version 2.1 do not explicitly say that they do not support the "G<regex>"
and "S<string>" option.

Wouldn't it be nice to have all of the above options collaborate with each
other?
