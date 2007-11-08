From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH PARSEOPT 1/4] parse-options new features.
Date: Thu, 08 Nov 2007 15:59:27 -0800
Message-ID: <7vbqa4z3ts.fsf@gitster.siamese.dyndns.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
	<1194430832-6224-2-git-send-email-madcoder@debian.org>
	<1194430832-6224-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 03:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqK0O-0003L8-Tc
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 03:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746AbXKICxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 21:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758728AbXKICxo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 21:53:44 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:53167 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbXKICxn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 21:53:43 -0500
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by lollipop.listbox.com (Postfix) with ESMTP id 85DEC4550A6
	for <git@vger.kernel.org>; Thu,  8 Nov 2007 19:01:59 -0500 (EST)
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D18922FA;
	Thu,  8 Nov 2007 18:59:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7301B93A42;
	Thu,  8 Nov 2007 18:59:51 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64121>

Pierre Habouzit <madcoder@debian.org> writes:

> options flags:
> ~~~~~~~~~~~~~
>   PARSE_OPT_NONEG allow the caller to disallow the negated option to exists.

Good addition; writing OPT_CALLBACK was tricky without this when
I tried to add --with=<commit> to git-branch.

	s/to exists/to exist/
