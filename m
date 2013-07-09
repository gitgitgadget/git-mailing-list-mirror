From: Jeff King <peff@peff.net>
Subject: Re: A local shared clone is now much slower
Date: Tue, 9 Jul 2013 00:30:09 -0400
Message-ID: <20130709043008.GD27903@sigill.intra.peff.net>
References: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au>
 <20130708073041.GA25072@sigill.intra.peff.net>
 <CACsJy8Chmm0=wDV4NQ+4Gh7KZYpbd9qkb=pNzkPeG-a-xiwVmw@mail.gmail.com>
 <7vbo6d2j2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Git Mailing List <git@vger.kernel.org>,
	Linus <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 06:30:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwPZC-0000Qx-7F
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 06:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab3GIEaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 00:30:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:35301 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725Ab3GIEaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 00:30:12 -0400
Received: (qmail 1807 invoked by uid 102); 9 Jul 2013 04:31:27 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Jul 2013 23:31:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 00:30:09 -0400
Content-Disposition: inline
In-Reply-To: <7vbo6d2j2e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229907>

On Mon, Jul 08, 2013 at 08:00:09AM -0700, Junio C Hamano wrote:

> I think this deserves to be backported to 'maint' track for
> 1.8.3.x.  Here is an attempt to do so.

Agreed. As it makes certain local-clone workflows really painful, I
think my original can be considered a performance regression for those
cases.

Your back-port looks good to me. Thanks.

-Peff
