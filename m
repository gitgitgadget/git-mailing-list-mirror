From: Wolfgang Denk <wd@denx.de>
Subject: Cannot get git any more?
Date: Mon, 18 Jul 2005 00:49:04 +0200
Message-ID: <20050717224904.D1ED735258B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Jul 18 00:51:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuHyQ-0006k1-9b
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 00:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVGQWuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 18:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVGQWuj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 18:50:39 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:32232 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261437AbVGQWug (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 18:50:36 -0400
Received: from fwd20.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1DuHxx-0008BL-03; Mon, 18 Jul 2005 00:50:33 +0200
Received: from denx.de (rXRIYwZXZeukaO7hjx-pPy341zXG-WznfaFfs3UkqAt9sINWBiyyrJ@[84.150.113.51]) by fwd20.sul.t-online.de
	with esmtp id 1DuHxv-1II0My0; Mon, 18 Jul 2005 00:50:31 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id B5BF74308F
	for <git@vger.kernel.org>; Mon, 18 Jul 2005 00:50:30 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id D1ED735258B
	for <git@vger.kernel.org>; Mon, 18 Jul 2005 00:49:04 +0200 (MEST)
To: git@vger.kernel.org
X-ID: rXRIYwZXZeukaO7hjx-pPy341zXG-WznfaFfs3UkqAt9sINWBiyyrJ@t-dialin.net
X-TOI-MSGID: ef745fe9-34e0-428d-9079-8ab1ab2b2d76
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I cannot access the git repositorey any more:

-> rpm -q cogito
cogito-0.12.1-1
-> cd git
-> cat .git/branches/origin 
rsync://rsync.kernel.org/pub/scm/git/git.git
-> cg-update
@ERROR: Unknown module 'pub'
rsync: connection unexpectedly closed (41 bytes read so far)
rsync error: error in rsync protocol data stream (code 12) at io.c(342)
cg-pull: unable to get the head pointer of branch master

-> cd ..
-> mv git git.OLD
-> cg-clone rsync://rsync.kernel.org/pub/scm/git/git.git
/usr/local/src/git
defaulting to local storage area
@ERROR: Unknown module 'pub'
rsync: connection unexpectedly closed (41 bytes read so far)
rsync error: error in rsync protocol data stream (code 12) at io.c(342)
cg-pull: unable to get the head pointer of branch master
cg-init: pull failed

-> rm -fr git
-> cg-clone http://www.kernel.org/pub/scm/git/git.git
/usr/local/src/git
defaulting to local storage area
00:44:43 URL:http://www.kernel.org/pub/scm/git/git.git/refs/heads/master [41/41] -> "refs/heads/origin" [1]
progress: 2 objects, 4252 bytes
error: File 6ff87c4664981e4397625791c8ea3bbb5f2279a3 (http://www.kernel.org/pub/scm/git/git.git/objects/6f/f87c4664981e4397625791c8ea3bbb5f2279a3) corrupt

Cannot obtain needed blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
cg-init: pull failed


Am I missing something?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It's all Klatchian to me.
        - Terry Pratchett & Stephen Briggs, _The Discworld Companion_
