From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Sun, 02 Dec 2007 21:25:43 -0800
Message-ID: <7vmyssqrhk.fsf@gitster.siamese.dyndns.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org>
	<20071202212224.GA22117@midwinter.com>
	<20071203040108.GS14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 06:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz3ow-00078Z-2r
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 06:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbXLCFZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 00:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbXLCFZv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 00:25:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50300 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbXLCFZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 00:25:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 620B02EF;
	Mon,  3 Dec 2007 00:26:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C26EB996EB;
	Mon,  3 Dec 2007 00:26:07 -0500 (EST)
In-Reply-To: <20071203040108.GS14735@spearce.org> (Shawn O. Pearce's message
	of "Sun, 2 Dec 2007 23:01:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66862>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This probably requires exporting the name of the ref we currently
> have locked in an environment variable (and teach lockfile.c it)
> so we can effectively do recursive locking.  That way the update
> hook can still use git-update-ref to change the ref safely.

Heh, I like that, although I suspect getting this right would mean the
topic should be post 1.5.4 (which I do not mind).  
