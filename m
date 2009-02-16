From: Jeff King <peff@peff.net>
Subject: send-email sending shallow threads by default
Date: Sun, 15 Feb 2009 19:07:32 -0500
Message-ID: <20090216000732.GC3503@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 01:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYr2k-0007VC-6s
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 01:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbZBPAHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 19:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbZBPAHe
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 19:07:34 -0500
Received: from peff.net ([208.65.91.99]:59529 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbZBPAHe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 19:07:34 -0500
Received: (qmail 11413 invoked by uid 107); 16 Feb 2009 00:07:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 19:07:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 19:07:32 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110097>

On Sun, Feb 15, 2009 at 03:53:50PM -0800, david@lang.hm wrote:

>> * git-send-email won't make deep threads by default
>>
>>  Many people said that by default when sending more than 2 patches the
>>  threading git-send-email makes by default is hard to read, and they
>>  prefer the default be one cover letter and each patch as a direct
>>  follow-up to the cover letter.
>>
>>  http://article.gmane.org/gmane.comp.version-control.git/109790
>
> I have mixed feelings about this one, if some messages get delayed in  
> transit the deep threads still keeps them in order, while the 2-layer  
> option doesn't.

Is that the case? mutt at least orders by thread, but by rfc822 date
within a single level of thread. So as long as the date fields (set by
the sender) are correct, it looks right no matter what order they arrive
in.

Are there common readers that thread but do not order by date?

-Peff
