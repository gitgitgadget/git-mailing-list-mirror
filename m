From: Brad Roberts <braddr@puremagic.com>
Subject: Re: [PATCH] libgit
Date: Sun, 17 Apr 2005 00:30:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504170027500.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 17 09:27:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN4BO-0005qB-Mp
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 09:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVDQHaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 03:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVDQHae
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 03:30:34 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:45026 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261277AbVDQHaa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 03:30:30 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3H7USa1026919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 00:30:28 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3H7USBh026915
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 00:30:28 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Converted git to libgit. Moved all the main() calls into a single
> multi-call binary - git-main.
> Made extern a bunch of functions that were static. Verified it at least
> still minimally worked.
> Note: this is only a first step towards creating a generic library.
> Figuring out what functions and variables *truly* need to be exported,
> renaming them to a git_<function> api, making it thread safe
> ... and not least of all, keeping up with everybody working out of the
> base tree... are problems that remain. Also - cleaning up the UI.

Why do all that static and main rearrangement?  It would be a lot simpler
and cleaner to simply rename the main's in place and add the new
dispatcher by itself.

Later,
Brad

