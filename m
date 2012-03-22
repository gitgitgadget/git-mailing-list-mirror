From: Michael Schubert <schu@schu.io>
Subject: [GSoC] Finishing network support for libgit2
Date: Thu, 22 Mar 2012 01:09:21 +0100
Message-ID: <4F6A6DB1.1080202@schu.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: libgit2@librelist.org
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 01:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAVmg-0003xD-7n
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 01:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329Ab2CVAVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 20:21:37 -0400
Received: from schu.io ([178.77.73.177]:57090 "EHLO
	lvps178-77-73-177.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754099Ab2CVAVg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 20:21:36 -0400
X-Greylist: delayed 647 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Mar 2012 20:21:36 EDT
Received: from [192.168.1.101] (e178181226.adsl.alicedsl.de [85.178.181.226])
	by lvps178-77-73-177.dedicated.hosteurope.de (Postfix) with ESMTPSA id 81E1514954001;
	Thu, 22 Mar 2012 01:10:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120314 Thunderbird/11.0
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193628>

Hi everybody,

I intend to apply for this year's GSoC to work on libgit2 [1],
namely "Finishing network support for libgit2" as outlined
under [2].

>From my point of view, the idea makes a good GSoC project as
is, but more experienced developers might see potential pitfalls,
for example regarding "pack-objects as a prerequisite".?
(I haven't read / touched pack-related code before.)

So far, there's two things I would like to discuss in advance:

* What do you consider "the best" ssh library to be used?
  libssh [3] seems to be the way to go, though I've never used
  it before nor did I do any ssh related development. What
  about libssh2 [4]? (Site note: libgit2 aims to be as platform
  independent as possible.)

* In your opinion, what features make "a sane API for managing
  the user's SSH keys"?

(In case you want to discuss anything else / share ideas, please
do.)

About me: I study Computer Science at FU Berlin [5], besides I
do a Git-related part time job for a SCM company. As a regular
contributor to libgit2 [6], I'm rather familiar with the community
and the bigger part of the code base. GSoC would allow me to both
gain experience with "Git's network stack" and to add an important
yet missing core part to libgit2.

Thank you.

Michael (m1sc in #git, #git-devel, #libgit2)

[1] http://libgit2.github.com
[2] https://github.com/peff/git/wiki/SoC-2012-Ideas
[3] http://www.libssh.org
[4] http://www.libssh2.org
[5] http://inf.fu-berlin.de/en/index.html
[6] `git log --oneline --author="schu-github"`
 
