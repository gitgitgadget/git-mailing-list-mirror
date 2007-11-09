From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Fri, 09 Nov 2007 01:06:54 -0800
Message-ID: <7vfxzfvlch.fsf@gitster.siamese.dyndns.org>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
	<11945685732608-git-send-email-dsymonds@gmail.com>
	<47340895.6000403@viscovery.net>
	<ee77f5c20711082324s39a9d441tc05c5a27e6d39f3e@mail.gmail.com>
	<7v7ikrx2st.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20711090014qfed56e7y446c014399e47a82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 10:07:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqPpk-0002iv-9X
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 10:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbXKIJHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 04:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbXKIJHI
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 04:07:08 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36409 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbXKIJHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 04:07:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0AE732F2;
	Fri,  9 Nov 2007 04:07:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 710AC91EFB;
	Fri,  9 Nov 2007 04:07:18 -0500 (EST)
In-Reply-To: <ee77f5c20711090014qfed56e7y446c014399e47a82@mail.gmail.com>
	(David Symonds's message of "Fri, 9 Nov 2007 19:14:44 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64145>

"David Symonds" <dsymonds@gmail.com> writes:

> So what would you prefer? Bracketing the whole test in parentheses
> looks ugly, but I can do that if that's the only option. If I look at
> t5510-fetch.sh (one of yours, Junio), there is no directory
> restoration in the case of test failure, as in my original patch.

Yes, that is what I was referring to as "bad examples".  The way
t4116 goes down to different directory do not look ugly to me.
