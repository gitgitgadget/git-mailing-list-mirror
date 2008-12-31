From: jidanni@jidanni.org
Subject: man pages to subsections 1git...?
Date: Wed, 31 Dec 2008 08:12:15 +0800
Message-ID: <87hc4lnqxs.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 03:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHrF0-0004uy-9H
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 03:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbYLaCyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 21:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbYLaCyF
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 21:54:05 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:56813 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755234AbYLaCyD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 21:54:03 -0500
Received: from jidanni.org (122-127-43-96.dynamic.hinet.net [122.127.43.96])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 17F33D25E0
	for <git@vger.kernel.org>; Tue, 30 Dec 2008 18:54:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104242>

It seems like there are enough git man pages that they deserve their
own "honorary" subsections. Compare:
$ ls -R /usr/share/man/man?|sed ...|sort|uniq -c
     19 1p
    175 1posix
     45 1ssl
     10 1x
    487 3perl
    403 3pm
OK, the subsections would be 1git, 5git, and 7git.

However git-whatever is not something one can exactly can invoke from
the shell anymore, is it proper to have such a named man page?
Choices are e.g.,:
$ apropos apply
git-apply (1git)     - Apply a patch on a git index file and a working tree
git apply (1git)     - Apply a patch on a git index file and a working tree
apply (1git)         - Apply a patch on a git index file and a working tree
Oh no, something wrong with each. You guys fight it out. I'm outta here.
