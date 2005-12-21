From: Pavel Roskin <proski@gnu.org>
Subject: getFileAnnotation: no revision
Date: Wed, 21 Dec 2005 11:56:59 -0500
Message-ID: <1135184219.5602.25.camel@dv>
References: <1135133300.3202.6.camel@dv>
	 <e5bfff550512210417p1d363017p9d08e3c55fc841d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 17:58:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep7HG-0001lr-J5
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 17:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVLUQ5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 11:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVLUQ5T
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 11:57:19 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:51336 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751139AbVLUQ5S
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 11:57:18 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ep7F3-00032L-0y
	for git@vger.kernel.org; Wed, 21 Dec 2005 11:55:10 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Ep7Gt-0001Ep-U9; Wed, 21 Dec 2005 11:56:59 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550512210417p1d363017p9d08e3c55fc841d5@mail.gmail.com>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13881>

On Wed, 2005-12-21 at 13:17 +0100, Marco Costalba wrote:
> I cannot reproduce the bug but please Pavel, add qDebug() lines
> in git.cpp as following:

Please use a mail client that doesn't damage inline attachments, or use
attachments.  The diff was wrapped before it was base64 encoded.  I had
to unwrap it manually.  Although, I guess you don't have much choice
with Google.

I had to replace %i with %li and (int) with (long) to make the compiler
happy.  It's a 64-bit platform.

> Then, please, try to reproduce the crash and send me the output.

$ bin/qgit
Git::cancelAnnotate 0
Git::getFileHistory src/commitimpl.cpp
Git::startAnnotate 7943344
Git::runAnnotate 7943344
ASSERT getFileAnnotation: no revision
bbf2abcbcafc2e458343034c8f249ac4956ec4fb
cancelingAnnotate 0
Segmentation fault

-- 
Regards,
Pavel Roskin
