From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 0/4 (take 4)] Fetch: branch properties for fetch.
Date: Sat, 23 Sep 2006 22:49:27 +0200
Message-ID: <87ac4qfgvc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 23 22:49:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRERO-00064l-FP
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 22:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWIWUtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 16:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWIWUtg
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 16:49:36 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:52149 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S964904AbWIWUtf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 16:49:35 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8NKnTQ04102
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 22:49:32 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27626>


Hi *,

This patch series implements the following branch properties for fetch:

 - default repository to fetch
 - default remotes branches to merge from the default repository

and adds some tests.

It passes all the tests.

Santi

---
 Documentation/config.txt |    7 +++++
 git-fetch.sh             |    9 +++---
 git-parse-remote.sh      |   43 ++++++++++++++++++++++++------
 t/t5510-fetch.sh         |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 13 deletions(-)
