From: Ryan Anderson <ryan@michonline.com>
Subject: [RFC+PATCH 0/2] Clean up root directory
Date: Mon, 10 Jul 2006 00:54:07 -0400
Message-ID: <1152507249880-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Jul 10 06:55:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FznnU-0003Ee-5O
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 06:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWGJEyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 00:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWGJEyq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 00:54:46 -0400
Received: from h4x0r5.com ([70.85.31.202]:3848 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751334AbWGJEyp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 00:54:45 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythical)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Fznn6-0004Du-LJ
	for git@vger.kernel.org; Sun, 09 Jul 2006 21:54:40 -0700
Received: from ryan by mythical with local (Exim 4.62)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1Fznmb-0003VH-Iw
	for git@vger.kernel.org; Mon, 10 Jul 2006 00:54:09 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g6bdc-dirty
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23587>

A second send of my patch to clean up the root directory a bit.

This series moves the "SCM interoperability" tools into interop/ and
builtin-*.c into builtin/.

All tests pass, and all finished scripts and binaries are dropped into the root
after a "make all".


GIT: Please enter your email below.
GIT: Lines beginning in "GIT: " will be removed.
GIT: Consider including an overall diffstat or table of contents
GIT: for the patch you are writing.
