From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Add format.coverauto boolean
Date: Mon, 04 May 2009 16:20:47 -0700
Message-ID: <7v8wlc4fqo.fsf@alter.siamese.dyndns.org>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
	<1241431142-8444-3-git-send-email-ft@bewatermyfriend.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Frank Terbeck <ft@bewatermyfriend.org>
X-From: git-owner@vger.kernel.org Tue May 05 01:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M17T0-000243-TZ
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 01:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbZEDXUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 19:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbZEDXUs
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 19:20:48 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44580 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZEDXUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 19:20:48 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090504232046.CVTA17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Mon, 4 May 2009 19:20:46 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id nbLn1b00H4aMwMQ04bLnnj; Mon, 04 May 2009 19:20:47 -0400
X-Authority-Analysis: v=1.0 c=1 a=hvk-ZFxnSJEA:10 a=cJbXrRuCTcsA:10
 a=02rWKl3eAAAA:8 a=oS-Udu8FqCnmW1e70lAA:9 a=U16LDNXahbY8eFPUL1ucYxndmSEA:4
 a=iVFYgQKhOj0A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118269>

Frank Terbeck <ft@bewatermyfriend.org> writes:

> If set to true, format-patch behaves like it had been started
> using the --cover-letter option.

I thought "If this is set, you can run format-patch without giving an
explicit --cover-letter=foo from the command line" was already done with
the earlier format.coverletter configuration variable.  Why do you need a
separate variable?  It does not make any sense to me, unless I am missing
something.
