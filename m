From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 2/6] send-email: --smtp-server-port should take an
 integer
Date: Tue, 07 Apr 2009 16:20:13 -0700
Message-ID: <7v8wmcxd8y.fsf@gitster.siamese.dyndns.org>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 01:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrKc6-00027O-RV
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 01:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZDGXUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 19:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbZDGXUT
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 19:20:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZDGXUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 19:20:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2553CA8707;
	Tue,  7 Apr 2009 19:20:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 107CEA8706; Tue,
  7 Apr 2009 19:20:14 -0400 (EDT)
In-Reply-To: <1239139522-24118-2-git-send-email-mfwitten@gmail.com> (Michael
 Witten's message of "Tue, 7 Apr 2009 16:25:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A84735E4-23CA-11DE-A22E-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116008>

I think this makes sense but you made it depend on your --delay patch, so
it won't apply without wiggling the patch by hand.

I can do that, but a good rule of thumb when preparing a series is to have
this kind of obvious clean-up first, leaving enhancement patches later in
the series.
