From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 07 Nov 2007 13:49:25 -0800
Message-ID: <7v7iktafq2.fsf@gitster.siamese.dyndns.org>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
	<Pine.LNX.4.64.0711071110040.4362@racer.site>
	<20071107145434.GB6768@mediacenter.austin.rr.com>
	<Pine.LNX.4.64.0711071501270.4362@racer.site>
	<20071107205101.GE6212@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Wed Nov 07 22:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipsmx-0002vN-QL
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 22:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbXKGVtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 16:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757753AbXKGVte
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 16:49:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33511 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355AbXKGVte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 16:49:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 10F732EF;
	Wed,  7 Nov 2007 16:49:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D31E93477;
	Wed,  7 Nov 2007 16:49:49 -0500 (EST)
In-Reply-To: <20071107205101.GE6212@lavos.net> (Brian Downing's message of
	"Wed, 7 Nov 2007 14:51:01 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63866>

bdowning@lavos.net (Brian Downing) writes:

> This makes sense (to me), as at most you're only adding one extra line
> for the final closing brace, and it makes the whole conditional look more
> "balanced", IMHO.
>
> But regardless, whatever the actual style for Git should be followed.
> Life's too short for arguments about coding style (even if divergence
> from K&R brace style is just plain wrong.  :)

Ok.  We do not have any particularly strong technical reason to
deviate from the kernel style.  Let's follow that.
