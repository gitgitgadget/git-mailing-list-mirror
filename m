From: Moe <moe@signalbeam.net>
Subject: FEATURE REQUEST: Env override GIT_GLOBAL_CONFIG
Date: Fri, 18 Dec 2009 23:54:32 +0100
Message-ID: <4B2C0828.4010505@signalbeam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 23:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLlid-000289-69
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 23:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933296AbZLRWyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 17:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933262AbZLRWyg
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 17:54:36 -0500
Received: from s2.mbox.bz ([85.214.91.204]:35323 "EHLO s2.mbox.bz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933201AbZLRWyf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 17:54:35 -0500
Received: from mini.local (unknown [92.206.21.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by s2.mbox.bz (Postfix) with ESMTPSA id 3A3A7E04B65
	for <git@vger.kernel.org>; Fri, 18 Dec 2009 23:54:33 +0100 (CET)
User-Agent: Postbox 1.1.0 (Macintosh/20091201)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135447>

Hello list,

I'm looking for a way to read a custom config file in
addition to .git/config.

An env var along the lines of GIT_GLOBAL_CONFIG (and perhaps
GIT_SYSTEM_CONFIG) to override the default locations of
~/.gitconfig or $prefix/etc/gitconfig would be most
welcome here.

$GIT_CONFIG doesn't work for this purpose because when set
git will *only* read the referenced file and ignore the
repository settings.

$GIT_CONFIG_LOCAL wouldn't do either and has been
removed from git anyways.


Use-Case:
Multiple users sharing one unix account. Trying to inject the respective
git identity and other preferences without overwriting
the actual .gitconfig-file - because that doesn't work when multiple
users are logged in concurrently to the same unix-account.


Kind regards,
Moe
