From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 0/2 (take 3)] Fetch: branch properties.
Date: Sat, 23 Sep 2006 12:04:37 +0200
Message-ID: <87venex5je.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 23 12:05:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR4NX-0003Bw-1q
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 12:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWIWKEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 06:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWIWKEp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 06:04:45 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:160 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751437AbWIWKEp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 06:04:45 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8NA4bQ31347
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 12:04:40 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27576>


Hi *,

This patch series implements the following branch properties for fetch:

  - default repository to fetch
  - default remotes branches to merge from the default repository

 Documentation/config.txt |    7 +++++++
 git-fetch.sh             |    9 ++++-----
 git-parse-remote.sh      |   34 ++++++++++++++++++++++++++--------
 3 files changed, 37 insertions(+), 13 deletions(-)

 Santi
