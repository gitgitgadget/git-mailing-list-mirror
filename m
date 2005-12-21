From: Pavel Roskin <proski@gnu.org>
Subject: Random notes about qgit
Date: Tue, 20 Dec 2005 21:48:20 -0500
Message-ID: <1135133300.3202.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 03:50:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eou1q-0008QA-0v
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 03:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVLUCsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 21:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVLUCsY
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 21:48:24 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:10426 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932252AbVLUCsY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 21:48:24 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Eotzi-0001Ki-Vr
	for git@vger.kernel.org; Tue, 20 Dec 2005 21:46:23 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Eou1c-0000xq-SF; Tue, 20 Dec 2005 21:48:20 -0500
To: Marco Costalba <mcostalba@gmail.com>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13862>

Hello, Marco!

Here's some assorted notes about current qgit.

Thanks for making the range dialog optional, but now I don't see any way
to see the local changes unless I re-enable the dialog.  I think it
should be an action activated from the menu - "diff local files to this
revision".  Or maybe the "local" radio button in the diff pane.

Current qgit seems to have another crash, also annotation related.  Run
qgit on its own repository.  Select "Add range select dialog options",
then double click on src/commitimpl.cpp in the file list.  Sometimes it
works, sometimes it crashes like this:

ASSERT getFileAnnotation: no revision
9771bea705024b3d0a59e1b9144adf5d77ca82d1

Sometimes you need to select other revisions and double click on other
files.  Another assert I got was:

ASSERT getFileAnnotation: no revision
bbf2abcbcafc2e458343034c8f249ac4956ec4fb

"git-cat-file commit" works fine on both revisions.  Just in case, I'm
seeing this on x86_64.

"View->Revision Diff" and "View->Archive Tree" work differently.  The
former doesn't allow to turn the pane off.  I'd like it to work like
"View->Archive Tree".  Neither can "Revision Diff" be closed from the
popup menu.

-- 
Regards,
Pavel Roskin
