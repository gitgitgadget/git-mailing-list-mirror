From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 18 Mar 2014 00:18:55 -0400
Message-ID: <20140318041855.GB7252@sigill.intra.peff.net>
References: <5110BD18.3080608@alum.mit.edu>
 <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
 <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
 <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
 <20140311014945.GB12033@sigill.intra.peff.net>
 <CACsJy8A1=U2=TGoKyo5mo1fLW+hBR1psn1J6S0=391fei2JULw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 05:19:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPlUU-0007R7-Lb
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 05:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbaCRES5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 00:18:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:41610 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbaCRES5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 00:18:57 -0400
Received: (qmail 18424 invoked by uid 102); 18 Mar 2014 04:18:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Mar 2014 23:18:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2014 00:18:55 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8A1=U2=TGoKyo5mo1fLW+hBR1psn1J6S0=391fei2JULw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244325>

On Sat, Mar 15, 2014 at 08:23:08AM +0700, Duy Nguyen wrote:

> > The default would start at false, and people who know their server is
> > very up-to-date can turn it on. And then when many server
> > implementations support it, flip the default to auto. And either leave
> > it there forever, or eventually just set it to "true" and drop "auto"
> > entirely as a code cleanup.
> 
> I would add that upload-pack also advertises about the availability of
> upload-pack2 and the client may set the remote.*.useUploadPack2 to
> either yes or auto so next time upload-pack2 will be used.

Good idea. If our auto probe is "try 1, learn to upgrade to 2 for next
time", we do not have to be so conservative about flipping it on (as
compared to my "try 2, fall back to 1").

-Peff
