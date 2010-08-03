From: Jeff King <peff@peff.net>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 08:44:56 -0400
Message-ID: <20100803124456.GA11608@coredump.intra.peff.net>
References: <i372v0$3np$1@dough.gmane.org>
 <m3hbjcptyr.fsf@localhost.localdomain>
 <4C57D997.5010003@drmicha.warpmail.net>
 <FF986C58-37A5-41ED-B2AF-1EA4C045B9F7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 14:45:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgGro-0003Qo-76
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 14:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab0HCMpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 08:45:05 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38160 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756209Ab0HCMpE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 08:45:04 -0400
Received: (qmail 12336 invoked by uid 111); 3 Aug 2010 12:45:01 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 03 Aug 2010 12:45:01 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Aug 2010 08:44:56 -0400
Content-Disposition: inline
In-Reply-To: <FF986C58-37A5-41ED-B2AF-1EA4C045B9F7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152507>

On Tue, Aug 03, 2010 at 02:32:06AM -0700, Joshua Juran wrote:

> >- use signed long long as our git_time_t (I think long is less system
> >dependent then long but I could be wrong)
> 
> Obviously you mean "I think long long is less system dependent than
> long".
> 
> Does any system exist where long long is not 64 bits?  In any case,
> you can future-proof it by spelling it "int64_t".  That symbol is not
> guaranteed to exist (nor is <stdint.h>), but neither is the long long
> type in the first place.

C99 specifies that "short" and "int" be at least 16 bits, that "long" be
at least 32 bits, and that "long long" be at least 64 bits. See section
5.2.4.2.1.

-Peff
