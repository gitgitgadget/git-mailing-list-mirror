From: "Timo Sigurdsson" <public_timo.s@silentcreek.de>
Subject: Gitweb: Persistant download URLs for snapshots?
Date: Mon, 30 May 2016 16:12:53 +0200 (CEST)
Message-ID: <20160530141253.AB7586C80ABB@dd34104.kasserver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 16:22:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7O5I-0006a9-Jx
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 16:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbcE3OWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 10:22:16 -0400
Received: from dd34104.kasserver.com ([85.13.151.79]:33070 "EHLO
	dd34104.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbcE3OWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 10:22:03 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 May 2016 10:22:03 EDT
Received: from dd34104.kasserver.com (dd0801.kasserver.com [85.13.143.205])
	by dd34104.kasserver.com (Postfix) with ESMTPSA id AB7586C80ABB
	for <git@vger.kernel.org>; Mon, 30 May 2016 16:12:53 +0200 (CEST)
X-SenderIP: 153.96.32.62
User-Agent: ALL-INKL Webmail 2.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295901>

Hi,

I hope this is the right place to ask this, but I wanted to know whether it is possible to have a persistant URL to obtain a snapshot of the latest master of a repository through Gitweb.

I set up a gitweb instance and it works nicely. I can click on the snapshot link to get a tgz archive of a specific commit hash to quickly receive or distribute files of a repository exposed by Gitweb. However, I have two problems with these links:

1) The link seems to depend on a commit hash. I haven't found a shorter or persitant link that would e.g. always give me the latest master snapshot.

2) Another issue which is actually more problematic: The links only seem to work interactively in my desktop browser. If I right click the link "snapshot", copy the URL and then try to download that link from another (headless) machine using wget, I end up getting a html file instead of a tgz archive.

Is it possible to generate such links that conssitantly work for the latest commit of a repository and that work non-interactively from a command line? Am I doing something wrong (well aside fromt he possibility that I'm trying to use gitweb for something which it might not have been designed for...)?

Thank you!

Kind regards,

Timo
