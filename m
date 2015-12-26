From: lee <lee@yagibdah.de>
Subject: how to put existing git repo on web server
Date: Sat, 26 Dec 2015 14:27:14 +0100
Message-ID: <87ege9tk5p.fsf@heimdali.yagibdah.de>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 26 15:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCpjj-0000yT-ME
	for gcvg-git-2@plane.gmane.org; Sat, 26 Dec 2015 15:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbLZOVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2015 09:21:43 -0500
Received: from acheron.yagibdah.de ([185.55.75.245]:48477 "EHLO
	acheron.yagibdah.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbLZOVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 09:21:42 -0500
X-Greylist: delayed 2982 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Dec 2015 09:21:42 EST
Received: from br-dmz-ip.yagibdah.de ([192.168.1.1] helo=heimdali.yagibdah.de)
	by acheron.yagibdah.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <lee@yagibdah.de>)
	id 1aCoww-0003JP-PR
	for git@vger.kernel.org; Sat, 26 Dec 2015 14:31:58 +0100
Received: from lee by heimdali.yagibdah.de with local (Exim 4.85)
	(envelope-from <lee@heimdali.yagibdah.de>)
	id 1aCoww-0006Mz-ND
	for git@vger.kernel.org; Sat, 26 Dec 2015 14:31:58 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282998>

Hi,

I hope this is the right mailing list to ask this:

I have an existing git repo and I would like to make the repo available
through my web server so that remote users can clone/fetch the repo.
They don't need to commit.

So far, I've found some documentation basically telling me to create a
bare repo which the web server can serve and then to put the existing
repo into the bare one.  However, all my attempts to somehow put the
existing repo into the bare one have failed.

Why can't I simply copy the whole repo into a directory the web server
can serve from and perhaps make some adjustments, or something similarly
simple?  How can I make it so that the repo can be cloned/fetched via
the web server?
