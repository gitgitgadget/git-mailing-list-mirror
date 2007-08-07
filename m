From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: 'pu' branch for StGIT
Date: Tue, 7 Aug 2007 04:20:43 +0200
Message-ID: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 04:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIEh2-0000fE-Si
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765608AbXHGCVF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765656AbXHGCVE
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:21:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3027 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765544AbXHGCVD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:21:03 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IIEge-0002Jz-00; Tue, 07 Aug 2007 03:20:44 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55199>

So I finally got my act together and published a 'pu'-like branch for
StGIT. Get it at git://repo.or.cz/stgit/kha.git; gitweb at
http://repo.or.cz/w/stgit/kha.git.

The idea is that I grab the StGIT patches that are posted to the list,
put each series in its own topic branch (based on Catalin's master),
and publish a merge of them. _After_ having made sure that the test
suite passes, naturally. It then becomes much easier for everyone to
test these patches.

This should lessen the pressure on Catalin to include patches in his
master branch as soon as possible, which should in turn reduce the
number of reverts in the official history.

Here's what's currently in there:

Karl Hasselstr=F6m (8):
      Teach StGIT about core.excludesfile
      New test: make sure that popping doesn't change patch order
      Verify patch status during the test
      Make use of the get_patch() utility function
      Compute patch appliedness from commit DAG
      Test the new DAG appliedness machinery
      Fix bash completion after the DAG appliedness patch
      Speed up the appliedness test

Pavel Roskin (1):
      Add support for SMTP over Transport Layer Security (TLS)

Yann Dirson (7):
      Include contrib scripts in the release tarball.
      Improve stg-fold-files-from doc.
      New contrib scripts: stg-dispatch and stg-show.
      Add -O flag to stg-fold-files-from.
      Add a no-act flag to stg-dispatch and stg-fold-file-from.
      Provide file completion for add/resolved/refresh based on status.
      Fixed completion function hardcoding .git/.

(Does anyone know the incantation for Junio's status mails, with topic
branches grouped nicely?)

NOTE: The DAG appliedness patch series is in there. They will upgrade
the format of any stgit branch they touch, and there's no convenient
way to change it back if you change your mind.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
