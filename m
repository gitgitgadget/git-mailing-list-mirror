From: "Long, Martin" <martin@longhome.co.uk>
Subject: One way GIT SVN sync (no rebase)
Date: Tue, 5 Jul 2011 16:17:20 +0100
Message-ID: <CANfMb__rUdhCP7=nu0mgnSf652fkp-V5-iA+CscthVD+B-j3yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 17:17:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe7NQ-00038y-IU
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 17:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab1GEPRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 11:17:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44403 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab1GEPRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 11:17:21 -0400
Received: by vws1 with SMTP id 1so4251728vws.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 08:17:21 -0700 (PDT)
Received: by 10.220.86.140 with SMTP id s12mr2578692vcl.205.1309879040352;
 Tue, 05 Jul 2011 08:17:20 -0700 (PDT)
Received: by 10.220.54.76 with HTTP; Tue, 5 Jul 2011 08:17:20 -0700 (PDT)
X-Originating-IP: [192.165.213.18]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176611>

Hi,

I forgot to announce this when I created it.

svnExport.pl by Martin Long, has been written to allow a one way sync
to a subversion repository, without the need to rebase or write commit
details back to the GIT repository. This makes is suitable for syncing
a central or shared GIT repository to a SVN repo for backup, or to
satisfy corporate/project requirements. The removal of the need to
rebase prevents issues with downstream repositories. Works on multiple
repositories, creating new branches in SVN automatically. For
non-linear histories without a branch in tack, only the first-parent
chain is committed.

https://github.com/martinlong1978/Git-Svn-push

A little rough around the edges, but feel free to fork, and send me a
pull request if you have anything to contribute.

-- 
Martin
