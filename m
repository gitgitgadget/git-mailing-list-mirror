From: norricorp <john@norricorp.f9.co.uk>
Subject: Re: Building git 2.4.5 on AIX 6.1 problems
Date: Thu, 16 Jul 2015 07:49:35 -0700 (MST)
Message-ID: <1437058175744-7635699.post@n2.nabble.com>
References: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net> <xmqqwpy9uqth.fsf@gitster.dls.corp.google.com> <a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net> <xmqq1tggmwdc.fsf@gitster.dls.corp.google.com> <1436596266437-7635513.post@n2.nabble.com> <CAPc5daWJ7T9UFi_457MvTBN7hoxAD0mEwwbQE1R076=Z+BWu7w@mail.gmail.com> <20150712041818.GA17595@peff.net> <1436775899179-7635578.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 16:49:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFkTk-0003wW-3l
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 16:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbbGPOtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 10:49:35 -0400
Received: from mwork.nabble.com ([162.253.133.43]:61427 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbbGPOte (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 10:49:34 -0400
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 4726023AF2FD
	for <git@vger.kernel.org>; Thu, 16 Jul 2015 07:49:35 -0700 (PDT)
In-Reply-To: <1436775899179-7635578.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274030>

The problem was down to the linker and archiver. I had to make sure that I
used the ar and ld in /usr/bin (rather than aix ld and gnu ar) and the gnu
compiler.  Also, I did not realise I had already created libs so had to run
clean and start with the right PATH to pick up the above.
Finally, have to use the gnu install, not the /usr/bin/install.
But getting there so thanks for all of the help that people have taken the
time for.
Regards,
John



--
View this message in context: http://git.661346.n2.nabble.com/Building-git-2-4-5-on-AIX-6-1-problems-tp7635435p7635699.html
Sent from the git mailing list archive at Nabble.com.
