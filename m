From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 19 Sep 2013 23:18:50 -0400
Message-ID: <20130920031850.GB15101@sigill.intra.peff.net>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <20130911191620.GB24251@sigill.intra.peff.net>
 <CAA01CsrN+VLw4WQmObvh72_MoH1Lyh9dQbizJcVhqyJoRyms-Q@mail.gmail.com>
 <CAPc5daVt4Q9twub5KyOQqZHx9CwOnkuwA97sXV44fF2j1e5HVg@mail.gmail.com>
 <CAA01CspCWFMGxXs9M3A1mtTctiUCCeJ9pJjHt=auMjhHHJU3Dg@mail.gmail.com>
 <20130919211659.GB16556@sigill.intra.peff.net>
 <xmqqy56sqxj1.fsf@gitster.dls.corp.google.com>
 <20130919220531.GA13723@sigill.intra.peff.net>
 <xmqqtxhgqvui.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 05:19:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMrFK-0001dn-2p
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 05:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab3ITDTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 23:19:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:40894 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713Ab3ITDTA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 23:19:00 -0400
Received: (qmail 22302 invoked by uid 102); 20 Sep 2013 03:19:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Sep 2013 22:19:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Sep 2013 23:18:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtxhgqvui.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235052>

On Thu, Sep 19, 2013 at 03:40:05PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... "...and
> > no, we do not want to go there". Calling it a booby-trap was meant to be
> > derogatory. :)
> 
> OK, I've resurrected the following and queued on 'pu'.

Looks good to me.

-Peff
