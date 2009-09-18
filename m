From: "John Ousterhout" <ouster@cs.stanford.edu>
Subject: Cygwin git dies silently
Date: Fri, 18 Sep 2009 16:48:42 -0700
Message-ID: <A80C2B4F6C34430FA32A24BF94647076@ouster>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 19 03:22:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mooeq-0001VU-3V
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 03:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbZISBW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 21:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbZISBW1
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 21:22:27 -0400
Received: from cs-smtp-1.Stanford.EDU ([171.64.64.25]:41116 "EHLO
	cs-smtp-1.Stanford.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbZISBW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 21:22:26 -0400
X-Greylist: delayed 5625 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2009 21:22:26 EDT
Received: from ouster.stanford.edu ([171.67.64.11] helo=ouster)
	by cs-smtp-1.Stanford.EDU with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.60)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1MonC0-0004Ch-SS
	for git@vger.kernel.org; Fri, 18 Sep 2009 16:48:45 -0700
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Aco4uovgo8sfU29LSsmSbo9TcHed8w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
X-Spam-Score: -101.6
X-Spam-Checker-Version: SpamAssassin 3.0.4-cs-csdcf (2005-06-05) on cs-smtp-1.Stanford.EDU
X-Scan-Signature: 5fb79390a4aad79c01ba7e4883e5f1df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128817>

I am trying to use the standard version of git that comes with Cygwin
(Cygwin says it's version 1.6.1.2-1), but when I invoke git from
Cygwin bash nothing happens: the shell prompt appears again with no
other output. I tried several different sets of git arguments, but
they all behave the same way. "echo $?" says that git is exiting with
status 53.  Does anyone have any suggestions for what might be causing
this?

Thanks in advance for any help you can provide.

-John-
