From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Possible bug in Git
Date: Fri, 16 Apr 2010 18:39:37 +0200
Message-ID: <201004161839.37731.trast@student.ethz.ch>
References: <4BC6EECE.6060408@gestiweb.com> <k2n32541b131004151713s51498b01s34c5a95c0f360901@mail.gmail.com> <alpine.LFD.2.00.1004160845350.15116@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"David =?iso-8859-1?q?Mart=EDnez_Mart=ED?=" <desarrollo@gestiweb.com>,
	<git@vger.kernel.org>, <deavidsedice@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 18:39:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2oa5-0002sP-IW
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870Ab0DPQjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 12:39:41 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:48603 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247Ab0DPQjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:39:40 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Apr
 2010 18:39:38 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Apr
 2010 18:39:38 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <alpine.LFD.2.00.1004160845350.15116@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145072>

Linus Torvalds wrote:
> I guess the issue is that combine-diff decides that there is nothing in 
> the result that isn't in either of the sources (because there is nothing 
> at all in the result), and as such it's not "interesting" after all.

It does give me a warm and fuzzy feeling when you are devising and
discussing test cases for a bug that I believe I fixed before this
branch of the thread even began:

  http://article.gmane.org/gmane.comp.version-control.git/144982

:-)

[scnr]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
