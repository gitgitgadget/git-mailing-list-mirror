From: Mike Hommey <mh@glandium.org>
Subject: Announcing git-cinnabar 0.1.0 (Was: Announcing a new (prototype)
 git-remote-hg tool)
Date: Wed, 11 Feb 2015 18:32:09 +0900
Message-ID: <20150211093209.GA21128@glandium.org>
References: <20141205205335.GA28935@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 10:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLTev-00059W-FU
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 10:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbbBKJcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 04:32:22 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:33303 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbbBKJcS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 04:32:18 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YLTeT-0005Yc-UV
	for git@vger.kernel.org; Wed, 11 Feb 2015 18:32:09 +0900
Content-Disposition: inline
In-Reply-To: <20141205205335.GA28935@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263670>

Hi,

Cinnabar is the common natural form in which mercury can be found on
Earth. It contains mercury sulfide and its powder is used to make the
vermillion pigment.

What does that have to do with git?

Hint: mercury.

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

If you've already seen the original thread this message is spawned from,
this is the same tool, with a new name, and two months worth of
additional work and testing.

Where git-cinnabar stands out compared to other similar tools is that it
doesn't use a local mercurial clone under the hood (unlike all the
existing other such tools), and is close to an order of magnitude faster
to clone a repository like http://hg.mozilla.org/mozilla-central than
the git-remote-hg tool that used to be shipped in contrib/.

I won't claim it is exempt of problems and limitations, which is why it's
not a 1.0. I'm however confident enough with its state to make the
first "official" release.

Code on https://github.com/glandium/git-cinnabar

Cheers,

Mike
