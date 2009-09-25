From: Arkadiusz =?UTF-8?B?TWnFm2tpZXdpY3o=?= <arekm@maven.pl>
Subject: is smarter bisect possible?
Date: Fri, 25 Sep 2009 11:37:06 +0200
Message-ID: <h9hrv3$cao$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 25 09:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr5UU-0007Tp-2v
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 09:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbZIYHpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 03:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbZIYHpG
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 03:45:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:60721 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbZIYHpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 03:45:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mr5UH-0007Mp-03
	for git@vger.kernel.org; Fri, 25 Sep 2009 09:45:05 +0200
Received: from 83.238.65.58 ([83.238.65.58])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 09:45:04 +0200
Received: from arekm by 83.238.65.58 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 09:45:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 83.238.65.58
User-Agent: KNode/4.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129065>


Hi,

I have such problem. Linus kernel tree merged some feature=20
(94e0fb086fc5663c38bbc0fe86d698be8314f82f) that was developed in .31rc9=
 era.

Current Linus kernel tree with that feature merged shows some regressio=
n.=20
Tree just before that merge doesn't show regression.

Now if I start to bisect just that feature (good=20
b7f21bb2e23b4fec16b448a34889f467465be659, bad=20
94e0fb086fc5663c38bbc0fe86d698be8314f82f) then git gets me whole tree b=
ack=20
to .31rc9 era which... doesn't show any problems.

This means that only combined current Linus tree and that feature shows=
 a=20
problem.

Is it possible to make git bisect test current tree + parts of that mer=
ge=20
instead going back to .31rc9 era with the whole tree?

--=20
Arkadiusz Mi=C5=9Bkiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
