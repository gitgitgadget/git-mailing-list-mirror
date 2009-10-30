From: Jeff King <peff@peff.net>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 15:43:33 -0400
Message-ID: <20091030194333.GA4551@coredump.intra.peff.net>
References: <20091029233458.GA32764@ikki.ethgen.de>
 <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org>
 <20091030165903.GA10671@ikki.ethgen.de>
 <20091030173838.GB18583@coredump.intra.peff.net>
 <7vaaz8lleg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Klaus Ethgen <Klaus@Ethgen.de>, 553296@bugs.debian.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:43:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xNz-0005hZ-AY
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756855AbZJ3Tnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756246AbZJ3Tnh
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:43:37 -0400
Received: from peff.net ([208.65.91.99]:47795 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077AbZJ3Tng (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:43:36 -0400
Received: (qmail 2682 invoked by uid 107); 30 Oct 2009 19:47:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 15:47:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 15:43:33 -0400
Content-Disposition: inline
In-Reply-To: <7vaaz8lleg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131738>

On Fri, Oct 30, 2009 at 12:41:27PM -0700, Junio C Hamano wrote:

> I've never understood the use of "ls-files -i" without -o, so in that
> sense, I have done 2. myself already long time ago.
> 
> In other words, I do not really care that much, and the choice would be
> between "0. do not do anything---the patch in question was a bugfix for
> longstanding insanity" and your "4. -i without -o didn't make much sense
> but now it does and here is the new meaning".

OK, I think the patch I sent elsewhere in the thread should be applied,
then, as it should make you, me, and Klaus happy.

-Peff
