From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: git-describe: what is the '-g' prefix good for?
Date: Thu, 16 Jul 2009 18:20:16 +0200
Message-ID: <4A5F5340.9030908@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 18:20:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRTh7-00018H-Bf
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 18:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbZGPQUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 12:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbZGPQUT
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 12:20:19 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.29]:39112 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbZGPQUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 12:20:19 -0400
Received: from [84.176.118.241] (helo=[192.168.2.100])
	by smtprelay06.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MRTgu-0007E8-Sn
	for git@vger.kernel.org; Thu, 16 Jul 2009 18:20:17 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123406>

Hello there,

I'm a bit surprised about the output of git-describe: if I'm on a tag,
git-describe tells the tag's name. Fine. If I commit sth. on top of
that, it tells how far I'm away from that tag and the current commit's
SHA1. Very fine. But then the SHA1 is preceeded with a '-g'. What's that
for?

I really don't want to ask for dropping it (I guess all people rely
on it), but does anybody know about the initial intention of that '-g'?
Cannot be easier parsing in porcelain scripts because either way the
actual state is unambiguously.

Just a curious
     Dirk
