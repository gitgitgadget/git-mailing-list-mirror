From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCHv2 0/3] rebase-i: Ignore comments and blank lines among squash/fixup commands
Date: Tue, 12 Jan 2010 16:38:33 +0100
Message-ID: <cover.1263310175.git.mhagger@alum.mit.edu>
References: <7vr5pw3pwp.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 16:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUipt-0004S1-OO
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 16:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab0ALPjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 10:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840Ab0ALPjI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 10:39:08 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45192 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0ALPjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 10:39:07 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0CFd2FQ019745;
	Tue, 12 Jan 2010 16:39:02 +0100
X-Mailer: git-send-email 1.6.6.140.ga53ad
In-Reply-To: <7vr5pw3pwp.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136725>

Here is v2 of the patch (now patch series) for making "rebase -i"
ignore comments and blank lines while it is processing blocks of
squash/fixup commands.

Please note that this version applies to "next", not "master", because
it depends on some changes to t/t3404-rebase-interactive.sh that were
made in mh/rebase-fixup.  (This dependency is superficial and could be
removed if necessary.)

The first patch in this series is not essential to the functionality
but I found it useful when debugging the tests.

Michael Haggerty (3):
  lib-rebase: Provide clearer debugging info about what the editor did
  lib-rebase: Allow comments and blank lines to be added to the rebase
    script
  rebase-i: Ignore comments and blank lines in peek_next_command

 git-rebase--interactive.sh    |    2 +-
 t/lib-rebase.sh               |   26 +++++++++++++++++++-------
 t/t3404-rebase-interactive.sh |   24 ++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 8 deletions(-)
