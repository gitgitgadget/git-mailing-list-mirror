From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [1.8.0] forbid full fetchspecs in git-pull
Date: Tue, 1 Feb 2011 16:14:57 +0100
Message-ID: <201102011614.57366.trast@student.ethz.ch>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <201101312255.59841.trast@student.ethz.ch> <AANLkTikxcd+gzeuJsQX1V5Wses8xWMnshdrOnYTvXgTq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Sean Estabrooks <seanlkml@sympatico.ca>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 16:15:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHwm-0004qL-CN
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 16:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab1BAPPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 10:15:00 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:44014 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab1BAPO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 10:14:59 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 1 Feb
 2011 16:14:52 +0100
Received: from pctrast.inf.ethz.ch (82.130.84.185) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 1 Feb
 2011 16:14:56 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <AANLkTikxcd+gzeuJsQX1V5Wses8xWMnshdrOnYTvXgTq@mail.gmail.com>
X-Originating-IP: [82.130.84.185]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165816>

Dmitry Potapov wrote:
> As to disallowing ':' in refspec completely, I am not so sure... Not
> that I think it is very useful, but also I don't see how it can hurt
> someone provided that the target branch cannot be the current branch.

IRC experience shows that people, while on some topic branch, run

  git pull origin master:master

expecting it to "pull master into master" (or even worse with three
different branch names).  So no, the current branch safeguard does
not prevent the fundamental mistake.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
