From: <mdconf@seznam.cz>
Subject: Git Feature Request - show current branch
Date: Thu, 19 Feb 2015 14:14:33 +0100 (CET)
Message-ID: <13b.3lxh{.41MsIT3sthY.1KvU6v@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.2)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 14:14:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOQwI-0008RX-Sq
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 14:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbbBSNOh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2015 08:14:37 -0500
Received: from smtp2.seznam.cz ([77.75.76.43]:55716 "EHLO smtp2.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752949AbbBSNOh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 08:14:37 -0500
Received: from email.seznam.cz
	by email-smtpc9a.ng.seznam.cz (email-smtpc9a.ng.seznam.cz [10.2.92.48])
	id 0d8e443fd514b48a0e31fecf;
	Thu, 19 Feb 2015 14:14:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
	t=1424351674; bh=yHNH9S54bIS7SjRNz84LOUfxCIlwKYXPT85nr3Pzo1E=;
	h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=PBSYERWiJzL+x6qBuAVOlUxA0KQTbU4ePmlDqmGlZ9o1OXnCxIHwIuMavW6lhIgmx
	 CMnI4c136dmD/Fwcil/0AA9YE2hr8tEB/it68bFvcjTpGfFI7uh1APsaq3xsARk04C
	 jzWIVt2TjOuJse+gf0rlo+YN/3yPdWm0xXz2DW6M=
Received: from ip-94-113-145-153.net.upcbroadband.cz
	(ip-94-113-145-153.net.upcbroadband.cz [94.113.145.153])
	by email.seznam.cz (szn-ebox-4.4.268) with HTTP;
	Thu, 19 Feb 2015 14:14:33 +0100 (CET)
X-Mailer: szn-ebox-4.4.268
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264096>

Hello,

To start with, I did not find an official way to submit feature request=
 so hopefully this is the right way to do so - if not then my apologize=
 & appreciate if somebody could re-submit to the proper place.

I'd like to request adding a parameter to 'git branch' that would only =
show the current branch (w/o the star) - i.e. the outcome should only b=
e the name of the branch that is normally marked with the star when I d=
o 'git branch' command. This may be very helpful in some external scrip=
ts that just simply need to know the name of the current branch. I know=
 there are multiple ways to do this today (some described here: http://=
stackoverflow.com/questions/6245570/how-to-get-current-branch-name-in-g=
it) but I really think that adding simple argument to 'git branch' woul=
d be very useful instead of forcing people to use 'workarounds'.

My suggestion is is to name the parameter '--current' or '--show-curren=
t'.
Example:

Command: git branch
Outcome:
=C2=A0branchA
=C2=A0branchB
* master

Command: git branch --current
Outcome:
master

Thank you,
Martin
