From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Lots of loose objects
Date: Wed, 10 Oct 2007 21:13:12 +0200
Message-ID: <87myuqwzp3.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifgzl-00052X-T1
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 21:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbXJJTNR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2007 15:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbXJJTNR
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 15:13:17 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:37846 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbXJJTNQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2007 15:13:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 44C43200A230
	for <git@vger.kernel.org>; Wed, 10 Oct 2007 21:13:15 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31972-01-51; Wed, 10 Oct 2007 21:13:14 +0200 (CEST)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id CB377200A233;
	Wed, 10 Oct 2007 21:13:11 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 665197B4080; Wed, 10 Oct 2007 21:13:12 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60529>

I hade a tree that made git-gui complain that I had too many loose
objects every time I started it (3072 to be precise).  Letting git-gui
compress it for me didn't help.  Neither did git-gc, even with the
--aggressive flag.

I noticed that I had a lot of loose files in .git/objects, and
suddenly I remembered that there was a command called "git
prune". Finally I was able to get rid of those loose objects.

The problem here is probably mostly that I couldn't get any help from
git-gui or git-gc.  git-gui claimed it would fix the problem for me,
but failed.  git-gc didn't mention that it left a bunch of files
untouched.

--=20
David K=C3=A5gedal
