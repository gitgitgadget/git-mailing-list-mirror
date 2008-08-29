From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Allow 'git cmd -h' outside of repository
Date: Fri, 29 Aug 2008 13:52:55 +0200
Message-ID: <20080829115255.GD8000@neumann>
References: <1219958917-22780-1-git-send-email-szeder@ira.uka.de>
	<alpine.DEB.1.00.0808291333010.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 13:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ2YR-0007t4-SY
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 13:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398AbYH2Lw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Aug 2008 07:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756204AbYH2Lw6
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 07:52:58 -0400
Received: from francis.fzi.de ([141.21.7.5]:31103 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756398AbYH2Lw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 07:52:57 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 13:52:55 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808291333010.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 29 Aug 2008 11:52:55.0657 (UTC) FILETIME=[C64BC590:01C909CD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 29, 2008 at 01:35:02PM +0200, Johannes Schindelin wrote:
> You miss the fact that "git grep -h" does not mean "show usage".  Oh,=
 and=20
> "git ls-remote -h" neither.  Three times's a charm: "git show-ref -h"=
 does=20
> not show the help either.
you are right with grep and show-ref.  However, ls-remote does not
require a repository, so it would not be affected by this patch.

> I am also not quite certain if we should not just tout "git help <cmd=
>" as=20
> the official way to request help.
Well, I would prefer to keep the short usage.

But anyway, having this inconsistency with the -h option across git
commands is bad.

Regards,
G=E1bor
