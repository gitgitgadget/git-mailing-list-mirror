From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH 4/4] t5526: avoid dependency on submodule order
Date: Thu, 3 Feb 2011 21:56:15 +0100
Message-ID: <201102032156.15646.j6t@kdbg.org>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net> <201102032108.54811.j6t@kdbg.org> <alpine.DEB.1.00.1102031426110.1541@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 03 21:56:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl6E2-00031D-GO
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 21:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab1BCU4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 15:56:17 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:18635 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752160Ab1BCU4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 15:56:17 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9E5B2CDF87;
	Thu,  3 Feb 2011 21:56:13 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B6B8E19F5F2;
	Thu,  3 Feb 2011 21:56:15 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.1102031426110.1541@bonsai2>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165997>

On Donnerstag, 3. Februar 2011, Johannes Schindelin wrote:
> On Thu, 3 Feb 2011, Johannes Sixt wrote:
> > Furthermore, just like Dscho, I'd rather prefer to know why the output
> > is not ordered as expected.
>
> Have you seen my response where I proved that it is a fflush() issue, most
> likely with mingw_spawn()?

Obviously, I haven't. Good catch!

-- Hannes
