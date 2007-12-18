From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH w/ test] rebase -p -i: handle "no changes" gracefully
Date: Tue, 18 Dec 2007 12:24:18 -0800
Message-ID: <7vabo7zr7x.fsf@gitster.siamese.dyndns.org>
References: <2791F15A-EB72-4FE4-8DB3-7A4B4DCB07B3@frim.nl>
	<47623129.2030303@viscovery.net>
	<9CC305E7-3325-4D17-A43E-0A2072F52084@ai.rug.nl>
	<Pine.LNX.4.64.0712171649420.9446@racer.site>
	<7vprx56pfn.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712172100450.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4izr-0001xN-Rs
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbXLRUYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbXLRUYf
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:24:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbXLRUYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:24:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0736A616C;
	Tue, 18 Dec 2007 15:24:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D5C06164;
	Tue, 18 Dec 2007 15:24:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68804>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Since commit 376ccb8cbb453343998e734d8a1ce79f57a4e092, unchanged
> SHA-1s are no longer mapped via $REWRITTEN.  But the updating
> phase was not prepared for the old head not being rewritten.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	On Mon, 17 Dec 2007, Junio C Hamano wrote:
>
> 	> Hmph, care to add a test to t3404?
>
> 	How about this?

Looks good.  Thanks.
