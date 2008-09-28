From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Implementation of a "textconv" filter for easy custom diff.
Date: Sun, 28 Sep 2008 04:06:53 +0200
Message-ID: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 04:10:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjlkK-0004Jm-Bu
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 04:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYI1CJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 22:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYI1CJ3
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 22:09:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:60022 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbYI1CJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 22:09:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8S26wFY026007
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 28 Sep 2008 04:06:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KjlgY-0001da-6W
	for git@vger.kernel.org; Sun, 28 Sep 2008 04:06:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KjlgY-00060G-3m
	for git@vger.kernel.org; Sun, 28 Sep 2008 04:06:58 +0200
X-Mailer: git-send-email 1.6.0.2.312.g1ef81a
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Sep 2008 04:06:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96932>


This patch serie give an implementation of a "textconv" filter for
"git diff", that allows one to diff anything that can easily be
converted to text with just a few lines in ~/.gitconfig and
.gitattributes.

The really cool thing in comparison with GIT_EXTERNAL_DIFF is that one
gets all the cool things of "git diff" (colors & cie) for free.

I had already posted a prototype of this a long time back[1], but I
finally got time to clean up the code a bit.

http://article.gmane.org/gmane.comp.version-control.git/56896
