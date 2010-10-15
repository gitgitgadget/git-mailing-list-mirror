From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Can I checkout a single file without altering index?
Date: Fri, 15 Oct 2010 21:02:13 +0200
Message-ID: <m2zkufcma2.fsf@igel.home>
References: <loom.20101012T114900-532@post.gmane.org>
	<AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
	<loom.20101014T095743-275@post.gmane.org>
	<i9a6kn$d7o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 21:02:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6pXv-0000qa-KI
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 21:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab0JOTCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 15:02:22 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49676 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077Ab0JOTCV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 15:02:21 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id D3DB41C15D21;
	Fri, 15 Oct 2010 21:02:19 +0200 (CEST)
Received: from igel.home (ppp-93-104-131-117.dynamic.mnet-online.de [93.104.131.117])
	by mail.mnet-online.de (Postfix) with ESMTP id D149B1C003D5;
	Fri, 15 Oct 2010 21:02:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 609D0CA2A0; Fri, 15 Oct 2010 21:02:14 +0200 (CEST)
X-Yow: My CODE of ETHICS is vacationing at famed SCHROON LAKE
 in upstate New York!!
In-Reply-To: <i9a6kn$d7o$1@dough.gmane.org> (Neal Kreitzinger's message of
	"Fri, 15 Oct 2010 13:30:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159132>

"Neal Kreitzinger" <neal@rsss.com> writes:

> However, there is an option in git-commit to copy files directly from the 
> working-tree to the object-store by totally bypassing the index, but no one 
> seems to do this or recommend doing this as normative practice.  None the 
> less, this "exception" in the git-commit manpage does seem to set the 
> precedent, so maybe it is also conceivable to copy objects directly from the 
> object-store to the work-tree by totally bypassing the index.

You can always do "git cat-file blob <object>", though you have to
redirect output manually.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
