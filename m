From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] convert bare readlink to strbuf_readlink
Date: Mon, 25 May 2009 15:23:53 -0700
Message-ID: <7v1vqcvn2e.fsf@alter.siamese.dyndns.org>
References: <20090522153426.GA10390@coredump.intra.peff.net>
	<20090525104609.GA26895@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Jarosch <thomas.jarosch@intra2net.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 26 00:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iaw-0000Z1-GG
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbZEYWYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbZEYWX5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:23:57 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59081 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbZEYWXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 18:23:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525222354.UJHZ20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 May 2009 18:23:54 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id vyPt1b00F4aMwMQ04yPtir; Mon, 25 May 2009 18:23:54 -0400
X-Authority-Analysis: v=1.0 c=1 a=W3GNerQxZLEA:10 a=neRRWQZ9sZMA:10
 a=PKzvZo6CAAAA:8 a=iAfmomAi-3bjVCUzuUYA:9 a=3F0LueSVAfbMozTVQGgjg-v-BI8A:4
 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119977>

Jeff King <peff@peff.net> writes:

> This is a re-post with the missing strbuf_release added.

Thanks.
