From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG?] HEAD detached at HEAD
Date: Fri, 18 Sep 2015 18:59:15 +0200
Message-ID: <vpqk2rnirz0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 18 18:59:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcz0Q-0000FE-It
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 18:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbbIRQ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 12:59:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38352 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbbIRQ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 12:59:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IGxDrO020220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 18:59:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IGxFTT016809;
	Fri, 18 Sep 2015 18:59:15 +0200
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 18 Sep 2015 18:59:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8IGxDrO020220
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443200356.3658@FFx3+mO+FW1JeYCMv7DxKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278208>

Hi,

I did a "git checkout --detached", and now I get:

$ git status           
HEAD detached at HEAD
nothing to commit, working directory clean
$ git branch
* (HEAD detached at HEAD)
  master

The "HEAD detached at HEAD" is not very helpful. I thought there was an
abbreved sha1 here before, but I'm getting the same with latest Git in
master and Git 2.0, so it doesn't seem to be new.

I'm getting it even if there's a tag and/or a branch pointing to the
same commit.

Any idea what's going on?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
