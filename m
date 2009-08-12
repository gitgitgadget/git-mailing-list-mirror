From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A tiny documentation patch
Date: Tue, 11 Aug 2009 19:55:22 -0700
Message-ID: <7v1vnhbv1h.fsf@alter.siamese.dyndns.org>
References: <20090810144419.GB24183@headley>
 <200908101659.28291.trast@student.ethz.ch>
 <4A812575.50105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?xaB0xJtww6FuIE7Em21l?= =?utf-8?B?Yw==?= 
	<stepnem@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 04:55:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb404-0006tU-S1
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 04:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbZHLCzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 22:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755753AbZHLCzc
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 22:55:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbZHLCzb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 22:55:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEBA92686E;
	Tue, 11 Aug 2009 22:55:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E671626869; Tue, 11 Aug 2009
 22:55:23 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9A0011B6-86EB-11DE-9A05-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125649>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> In current next's Documentation/, we have 149 lines with `-- and 48
> lines with `\--. How is our policy regarding old AsciiDoc?

We could drop support for AsciiDoc 7 after all mainstream distros stop
shipping it.  If the need to bend backwards in order to support it gets
too much for us, we might be tempted to drop it sooner, but are we getting
to that point?  I hope not.

> (read: volunteer) making these things uniform one way or the other,
> depending which versions we want to support.

Thanks.  150 does not sound too bad to classify between ones that should
be em-dash and that should be double dashes.
