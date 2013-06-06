From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Thu, 6 Jun 2013 02:44:09 -0400
Message-ID: <20130606064409.GA20334@sigill.intra.peff.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
 <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net>
 <51B02D81.3000700@viscovery.net>
 <20130606063754.GA20050@sigill.intra.peff.net>
 <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 08:44:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkTvk-0004HO-8k
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 08:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403Ab3FFGoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 02:44:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:57499 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259Ab3FFGoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 02:44:12 -0400
Received: (qmail 7101 invoked by uid 102); 6 Jun 2013 06:44:58 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Jun 2013 01:44:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jun 2013 02:44:09 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226482>

On Thu, Jun 06, 2013 at 01:41:05AM -0500, Felipe Contreras wrote:

> > Thanks. I wasn't quite clear on how the signal handling worked on
> > Windows, but from your description, I agree there is not any point in
> > running the test at all.
> 
> Shouldn't we clarify that Git exit codes only work on UNIX-like
> operating systems?

Clarify where? My impression is that this issue is well-known in the
msys world, and it is a platform issue, not a git issue. If somebody
wants to write a note somewhere in the git documentation, that's fine
with me, but I'm not clear on exactly what it would even say.

-Peff
