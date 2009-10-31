From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 0/2] Set Makefile variables from configure
Date: Sat, 31 Oct 2009 16:41:33 -0400
Message-ID: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 21:41:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Klm-00068J-SP
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 21:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233AbZJaUlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 16:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbZJaUlf
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 16:41:35 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:38875 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223AbZJaUlf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 16:41:35 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:41959 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N4KlX-0003LC-5m; Sat, 31 Oct 2009 16:41:39 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N4KlX-0005bH-3L; Sat, 31 Oct 2009 16:41:39 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n9VKfc9F021527;
	Sat, 31 Oct 2009 16:41:38 -0400
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131855>

These patches add support for setting the newly created DEFAULT_EDITOR
and DEFAULT_PAGER from the configure script.  I also tacked in
ETC_GITCONFIG, since I can't currently toggle this without setting a
command line value when building, but have need to alter it.

The function added is generic, and will allow for setting new
variables as needed in the future.  No validation is done on the
values.  It is less specific than the *_PATH setting functions that
already exist.

Ben Walton (2):
  configure: add function to directly set Makefile variables
  configure: allow user to set gitconfig, pager and editor

 configure.ac |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
