From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] MinGW: 64-bit file offsets
Date: Thu, 5 Mar 2009 21:53:45 +0100
Message-ID: <200903052153.45398.j6t@kdbg.org>
References: <cover.1236268730u.git.johannes.schindelin@gmx.de> <ae01b6dfcd430694dad008bbf201ee1490b071a1.1236268730u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Sickboy <sb@dev-heaven.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:55:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKbB-0001I5-L0
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbZCEUxx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 15:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbZCEUxx
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:53:53 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:12716 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306AbZCEUxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 15:53:53 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7D2AF1000B;
	Thu,  5 Mar 2009 21:53:46 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id F3EC81D166;
	Thu,  5 Mar 2009 21:53:45 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <ae01b6dfcd430694dad008bbf201ee1490b071a1.1236268730u.git.johannes.schindelin@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112341>

On Donnerstag, 5. M=E4rz 2009, Johannes Schindelin wrote:
> The type 'off_t' should be used everywhere so that the bit-depth of t=
hat
> type can be adjusted in the standard C library, and you just need to
> recompile your program to benefit from the extended precision.
>
> Only that it was not done that way in the MS runtime library.
>
> This patch reroutes off_t to off64_t and provides the other necessary
> changes so that finally, clones larger than 2 gigabyte work on Window=
s
> (provided you are on a file system that allows files larger than 2gb)=
=2E
>
> Initial patch by Sickboy <sb@dev-heaven.net>.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
