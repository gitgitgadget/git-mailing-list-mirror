From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement selectable group ownership in git-init
Date: Sat, 03 Nov 2007 15:31:51 -0700
Message-ID: <7v640jx8o8.fsf@gitster.siamese.dyndns.org>
References: <472CC676.3000603@gmail.com>
	<7vabpvx8uu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 23:32:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoRXM-0002HJ-0S
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 23:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbXKCWcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 18:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755578AbXKCWcB
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 18:32:01 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:56758 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215AbXKCWcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 18:32:00 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3261B2EF;
	Sat,  3 Nov 2007 18:32:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CE3F891CE2;
	Sat,  3 Nov 2007 18:32:19 -0400 (EDT)
In-Reply-To: <7vabpvx8uu.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 03 Nov 2007 15:27:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63320>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect this is good only for init-db.  When normal codepaths
> create a new file under .git/ and call adjust_shared_perm(), who
> initializes owner_group and to what value with your patch?
>
> The way the world works is that adjust_shared_perm() relies on a
> new directory and/or file in .git/ being created in the same
> group as its parent directory .git/ ways the case).

sorry, did not finish editing before sending.

	s| \.git.*.$|.|;
