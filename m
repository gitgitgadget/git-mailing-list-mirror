From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add history graph API
Date: Mon, 05 May 2008 23:41:47 -0700
Message-ID: <7vzlr4gcic.fsf@gitster.siamese.dyndns.org>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
 <1209897414-10091-2-git-send-email-adam@adamsimpkins.net>
 <1209897414-10091-3-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Tue May 06 08:43:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtGt3-0004JQ-Jx
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 08:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbYEFGmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 02:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbYEFGmB
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 02:42:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYEFGl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 02:41:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E16443CBA;
	Tue,  6 May 2008 02:41:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 53A8A3CB8; Tue,  6 May 2008 02:41:55 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 86C3A0CA-1B37-11DD-860D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81338>

Adam Simpkins <adam@adamsimpkins.net> writes:

> +* The graph API does not currently support reverse commit ordering.  In
> +  order to implement reverse ordering, the graphing API needs an
> +  (efficient) mechanism to find the children of a commit.

You might want to take a look at the 'jc/blame' topic that have been
brewing in 'next' for the three weeks, most notably f35f560 (revision
traversal: --children option, 2008-04-03).

This series needs tests.
