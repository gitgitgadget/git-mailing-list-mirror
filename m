From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Fri, 09 Nov 2007 00:04:34 -0800
Message-ID: <7v7ikrx2st.fsf@gitster.siamese.dyndns.org>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
	<11945685732608-git-send-email-dsymonds@gmail.com>
	<47340895.6000403@viscovery.net>
	<ee77f5c20711082324s39a9d441tc05c5a27e6d39f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 09:05:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqOrL-0003mp-Pu
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 09:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbXKIIEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 03:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbXKIIEo
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 03:04:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60124 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbXKIIEn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 03:04:43 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AD6792F2;
	Fri,  9 Nov 2007 03:05:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BC3291DE5;
	Fri,  9 Nov 2007 03:04:57 -0500 (EST)
In-Reply-To: <ee77f5c20711082324s39a9d441tc05c5a27e6d39f3e@mail.gmail.com>
	(David Symonds's message of "Fri, 9 Nov 2007 18:24:15 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64138>

"David Symonds" <dsymonds@gmail.com> writes:

> Looking at the existing tests which, when they change directories,
> don't cd back to where they were; they "cd .." at the start of the
> next test. I'll add a "cd .." to the relevant bits of my tests.

Do not follow the bad examples, please.
