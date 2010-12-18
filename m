From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 0/4] --word-regex sanity checking and such
Date: Sat, 18 Dec 2010 17:24:29 +0100
Message-ID: <201012181724.29916.trast@student.ethz.ch>
References: <254678.14296.qm@web110704.mail.gq1.yahoo.com> <cover.1292688058.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 17:24:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTzaH-0007uI-Th
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 17:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803Ab0LRQYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 11:24:32 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:55259 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756308Ab0LRQYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 11:24:32 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 18 Dec
 2010 17:24:26 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 18 Dec
 2010 17:24:31 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <cover.1292688058.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163921>

I wrote:
>   diff.c: pass struct diff_words into find_word_boundaries
>   diff.c: implement a sanity check for word regexes
>   userdiff: fix typo in ruby and python word regexes
>   t4034: bulk verify builtin word regex sanity

BTW, Junio, you could move the third patch to the front and merge it
to maint.  I think it's an obvious fix to a real bug, and it does not
depend on the other patches except that the test in 4/4 will fail
without the fix.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
