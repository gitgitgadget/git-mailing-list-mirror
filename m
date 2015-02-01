From: Hans Ginzel <hans@matfyz.cz>
Subject: How to rebase one branch of the merge commit?
Date: Sun, 1 Feb 2015 19:42:14 +0100
Message-ID: <20150201184214.GA89666@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 19:47:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHzYo-0002SI-Pw
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 19:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbbBASrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Feb 2015 13:47:46 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:37833 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbbBASrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 13:47:46 -0500
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Feb 2015 13:47:45 EST
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 1975)
	id 01239468002; Sun,  1 Feb 2015 19:42:14 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263236>

Hello!

Suppose following git history:

A=E2=80=93M=E2=80=93C
  /
B

How to achieve this with commits metadata preserving?

A=E2=80=93M'=E2=80=93C'
  /
B'

I did

git checkout B
git add something_not_in_other_commits
git commit --amend

So I have B'. How to continue, please? My git version is 1.7.1 (Centos =
6.5).

Regards
Hans
