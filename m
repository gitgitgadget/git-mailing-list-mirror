From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Fri, 02 Nov 2007 13:29:19 -0700
Message-ID: <7vd4us1jds.fsf@gitster.siamese.dyndns.org>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:29:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io39H-0001CJ-Ap
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbXKBU3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbXKBU3c
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:29:32 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:37049 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbXKBU3b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 16:29:31 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 072D22F0;
	Fri,  2 Nov 2007 16:29:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B87F917C6;
	Fri,  2 Nov 2007 16:29:48 -0400 (EDT)
In-Reply-To: <1194004427-26934-1-git-send-email-pkufranky@gmail.com> (Ping
	Yin's message of "Fri, 2 Nov 2007 19:53:47 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63170>

How does this work when you are a toplevel developer and do not
have the submodule cloned and checked out?

Our code should treat having the submodule directory and not
having it when there is a mode 160000 entry in the index equally
likely.  Cloning and checking-out is _not_ the norm (nor the
exception).
