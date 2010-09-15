From: Torgny Nyblom <kde@nyblom.org>
Subject: Strange log results
Date: Wed, 15 Sep 2010 20:02:03 +0200
Message-ID: <20100915200203.754a312f@explosive.nyblom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 20:26:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovwgd-000075-In
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 20:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab0IOS0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 14:26:11 -0400
Received: from mailrelay.veberod.com ([193.12.238.77]:54868 "EHLO
	mailrelay.veberod.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab0IOS0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 14:26:10 -0400
Received: from dx.nyblom.org ([212.247.117.70])
	by mailrelay.veberod.com (8.13.8/8.13.8) with ESMTP id o8FFREb9004820
	for <git@vger.kernel.org>; Wed, 15 Sep 2010 17:27:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by dx.nyblom.org (Postfix) with ESMTP id 30F306168FA
	for <git@vger.kernel.org>; Wed, 15 Sep 2010 20:03:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dx.nyblom.org
Received: from dx.nyblom.org ([127.0.0.1])
	by localhost (dx.nyblom.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QUH0Jd7a9SVD for <git@vger.kernel.org>;
	Wed, 15 Sep 2010 20:03:01 +0200 (CEST)
Received: from explosive.nyblom.org (explosive.nyblom.org [192.168.0.201])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dx.nyblom.org (Postfix) with ESMTPS id D45A3134A0E
	for <git@vger.kernel.org>; Wed, 15 Sep 2010 20:03:01 +0200 (CEST)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156243>

Hi,

I'm working on converting the KDE subversion repository to git, as
a part of this I'm trying to validate that the conversion hasn't missed
any revisions or merges but when I run "git log" with different options
I get (in my mind) strange results.

git log <file> -> produces a list of commits
git log --follow <file> -> produces an empty list (no output)
git log --name-status <file> -> no info about file

It seems like this occurs when there is a merge only commit as the
first commit in the list returned by the "bare" log command.

Is there any legit situation where this might happen?
If so what?
If not is this a bug in my convert program or in git?

/Regards
Torgny
