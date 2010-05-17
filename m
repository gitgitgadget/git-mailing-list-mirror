From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/4] rev-parse: deprecate use as an option sifter
Date: Mon, 17 May 2010 16:26:40 +0200
Message-ID: <201005171626.41175.trast@student.ethz.ch>
References: <20100505033536.GB8779@coredump.intra.peff.net> <4BED9C09.8010801@drmicha.warpmail.net> <201005142101.16317.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 16:27:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE1Hs-0008Vv-AE
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 16:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab0EQO1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 10:27:06 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:32627 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991Ab0EQO1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 10:27:05 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 16:27:02 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 16:26:41 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <201005142101.16317.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147240>

Jakub Narebski wrote:
> 
> "git rev-parse --parseopt" is not deprecated.  What is deprecated is
> --revs-only, --flags, etc.

git-filter-branch uses --revs-only and --no-revs, and I'm not sure how
it could avoid doing so without losing a lot of flexibility (or
knowing a list of options, which is worse)...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
