From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: git-rev-list --merge-order hangs
Date: Wed, 08 Jun 2005 08:50:56 +0200
Message-ID: <42A69550.1030105@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 08 08:48:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfuLe-0002gi-Dv
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 08:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVFHGvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 02:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVFHGvT
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 02:51:19 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:19604 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S262121AbVFHGvQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 02:51:16 -0400
Received: (qmail 510 invoked from network); 8 Jun 2005 06:51:12 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 8 Jun 2005 06:51:12 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id 7E7395CDD82
	for <git@vger.kernel.org>; Wed,  8 Jun 2005 08:50:56 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've got a Linux git tree with some merges and some other commits
interwined.
I want to print all my changes in merge order, so I do:

git-rev-list --pretty --merge-order v2.6.12-rc6-astorm1 ^v2.6.12-rc6

It prints the first 3 commits (linear), but then hangs, eating all
available CPU.
Without --merge-order it works fine, but obviously lists the commits by
parent.

AstralStorm
