From: norricorp <john@norricorp.f9.co.uk>
Subject: Re: Building git 2.4.5 on AIX 6.1 problems
Date: Mon, 13 Jul 2015 01:24:59 -0700 (MST)
Message-ID: <1436775899179-7635578.post@n2.nabble.com>
References: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net> <xmqqwpy9uqth.fsf@gitster.dls.corp.google.com> <a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net> <xmqq1tggmwdc.fsf@gitster.dls.corp.google.com> <1436596266437-7635513.post@n2.nabble.com> <CAPc5daWJ7T9UFi_457MvTBN7hoxAD0mEwwbQE1R076=Z+BWu7w@mail.gmail.com> <20150712041818.GA17595@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 10:25:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEZ2t-0004dD-BD
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 10:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbbGMIY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 04:24:58 -0400
Received: from mwork.nabble.com ([162.253.133.43]:63699 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbbGMIY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 04:24:58 -0400
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 09EA62355EB5
	for <git@vger.kernel.org>; Mon, 13 Jul 2015 01:25:00 -0700 (PDT)
In-Reply-To: <20150712041818.GA17595@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273909>

Hi Jeff,
So running with the ar in binutils gave the usual result.
I think this boils down to knowing which library those undefined symbols are
defined in. The git code uses those variables so the library should be
around somewhere. It is just knowing which library it is in.
Regards,
John



--
View this message in context: http://git.661346.n2.nabble.com/Building-git-2-4-5-on-AIX-6-1-problems-tp7635435p7635578.html
Sent from the git mailing list archive at Nabble.com.
