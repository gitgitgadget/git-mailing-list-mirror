From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: How to know where a reference name comes from?
Date: Thu, 27 Nov 2008 10:18:30 +0100
Message-ID: <vpqk5ap5xy1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 27 10:23:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5d5Q-0007nF-MY
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 10:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbYK0JVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 04:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbYK0JVj
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 04:21:39 -0500
Received: from imag.imag.fr ([129.88.30.1]:56754 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbYK0JVi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 04:21:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mAR9IcV8029214
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Nov 2008 10:18:38 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1L5d14-00032X-7V; Thu, 27 Nov 2008 10:18:30 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1L5d14-0006y8-59; Thu, 27 Nov 2008 10:18:30 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 27 Nov 2008 10:18:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101801>

Hi,

I faced a simple problem: on a repository, doing almost anything with
the reference "git-svn" complained about ambiguous reference. I know I
have a remotes/git-svn branch, but I didn't know what the other
reference could be.

I didn't find a command telling me _why_ this "git-svn" was ambiguous.
I'd have loved a

$ git rev-parse --all-symbolic-full-names git-svn

or so, but I couldn't find one.

Did I miss anything obvious? (not that the problem was big, I'm just
curious).

(I ended up doing "strace -e open git rev-parse git-svn", and found
out I had a .git/git-svn file lying around)

Thanks,

-- 
Matthieu
