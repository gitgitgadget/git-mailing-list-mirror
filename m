From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: purpose of -r flag for git-svn fetch
Date: Tue, 29 Jun 2010 22:29:28 -0400
Message-ID: <AANLkTil_iADth0dvcar-nkqjRcmK4p1Sc3UcBmXJ9nQn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 04:29:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTn3U-0002Bj-Oj
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 04:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab0F3C33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 22:29:29 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56991 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab0F3C33 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 22:29:29 -0400
Received: by qwi4 with SMTP id 4so91121qwi.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 19:29:28 -0700 (PDT)
Received: by 10.224.96.209 with SMTP id i17mr5311907qan.154.1277864968189; 
	Tue, 29 Jun 2010 19:29:28 -0700 (PDT)
Received: by 10.229.181.3 with HTTP; Tue, 29 Jun 2010 19:29:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149937>

I've tried doing git-svn fetch in batches because it takes too long to
do it all at once.

=A0=A0 =A0git svn -r1:5000 fetch
=A0=A0 =A0git svn -r5000:10000 fetch
=A0=A0 =A0git svn -r10000:15000 fetch

Strangely, after this is done if I look in the history with "git log",
I only see commits on master branch up through the 5000th revision of
the SVN repository. Someone told me to then call git-svn rebase to fix
it. What does "-r" actually do when invoked on consecutive calls to
"git-svn fetch" and why does git-svn rebase appear to fix it?

I posted this question to Stackoverflow before realizing that this
list is a better audience for it:
http://stackoverflow.com/questions/3144683/master-branch-missing-revisi=
ons-after-sequential-git-svn-fetch-calls

Thanks!
