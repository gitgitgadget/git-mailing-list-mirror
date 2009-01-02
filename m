From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to track the history of a line in a file
Date: Fri, 02 Jan 2009 14:54:54 -0800
Message-ID: <7vvdsxb9oh.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm>
 <20090102212655.GA24082@coredump.intra.peff.net>
 <alpine.DEB.1.10.0901021459480.21567@asgard.lang.hm>
 <alpine.DEB.1.10.0901021544580.21567@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Jan 02 23:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIswL-0007K5-7c
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbZABWzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758282AbZABWzE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:55:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758216AbZABWzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:55:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32D488DA51;
	Fri,  2 Jan 2009 17:55:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 668778DA4E; Fri,
  2 Jan 2009 17:54:56 -0500 (EST)
In-Reply-To: <alpine.DEB.1.10.0901021544580.21567@asgard.lang.hm>
 (david@lang.hm's message of "Fri, 2 Jan 2009 15:48:03 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6246A984-D920-11DD-83D6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104442>

david@lang.hm writes:

> I was misunderstanding git blame

You may find the --porcelain output format of git-blame useful to make
your script safer and more robust.
