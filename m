From: Torgny Nyblom <kde@nyblom.org>
Subject: git log broken?
Date: Wed, 22 Sep 2010 09:48:08 +0200
Message-ID: <20100922094808.07be1757@explosive.nyblom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 09:49:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyK53-0002LN-Aa
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 09:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab0IVHtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 03:49:15 -0400
Received: from mailrelay.veberod.com ([193.12.238.77]:34602 "EHLO
	mailrelay.veberod.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0IVHtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 03:49:13 -0400
Received: from dx.nyblom.org ([212.247.117.70])
	by mailrelay.veberod.com (8.13.8/8.13.8) with ESMTP id o8M5BspD011087
	for <git@vger.kernel.org>; Wed, 22 Sep 2010 07:11:55 +0200
Received: from localhost (localhost [127.0.0.1])
	by dx.nyblom.org (Postfix) with ESMTP id C00F71532C9
	for <git@vger.kernel.org>; Wed, 22 Sep 2010 09:49:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dx.nyblom.org
Received: from dx.nyblom.org ([127.0.0.1])
	by localhost (dx.nyblom.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jiuUOEH9+DtW for <git@vger.kernel.org>;
	Wed, 22 Sep 2010 09:49:10 +0200 (CEST)
Received: from explosive.nyblom.org (explosive.nyblom.org [192.168.0.201])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dx.nyblom.org (Postfix) with ESMTPS id E89FD134A0E
	for <git@vger.kernel.org>; Wed, 22 Sep 2010 09:49:09 +0200 (CEST)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156789>

Hi,

(Resend as it got no replies and I want to be sure that is wasn't lost
in the noise)

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
