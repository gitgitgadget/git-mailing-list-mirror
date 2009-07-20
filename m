From: Peter Simons <simons@cryp.to>
Subject: Re: [PATCH] post-update.sample referenced obsolete binary "git-update-server-info"
Date: Mon, 20 Jul 2009 16:46:47 +0200
Organization: private
Message-ID: <87r5wb5s4o.fsf@write-only.cryp.to>
References: <874otb724d.fsf@write-only.cryp.to> <4A60A2DC.90506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 16:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSu94-0003Br-1Z
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 16:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbZGTOrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbZGTOrF
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 10:47:05 -0400
Received: from main.gmane.org ([80.91.229.2]:55692 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbZGTOrE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 10:47:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MSu8o-0005Av-QK
	for git@vger.kernel.org; Mon, 20 Jul 2009 14:46:58 +0000
Received: from p54bd1642.dip0.t-ipconnect.de ([84.189.22.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 14:46:58 +0000
Received: from simons by p54bd1642.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 14:46:58 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54bd1642.dip0.t-ipconnect.de
Cancel-Lock: sha1:kn4N0CzCm+AVGC8qozJ9KMFzjh8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123606>

Hi Michael,

 >> -exec git-update-server-info
 >> +exec git update-server-info
 >>
 >
 > t/t5540-http-push.sh should fail if this really needed a fix (libexec
 > is in $PATH for hooks).

you are right, the call to git-update-server-info does succeed, so there
is no need to make that change.

Personally, I find it unfortunate, though, that those scripts rely on
commands that won't exist when a normal user runs them.

Just my 2 cents,
Peter
