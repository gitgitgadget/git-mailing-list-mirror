From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] log-tree: make name_decoration hash static
Date: Tue, 26 Aug 2014 13:43:36 -0400
Message-ID: <20140826174336.GA17101@peff.net>
References: <20140826102051.GA4885@peff.net>
 <20140826102353.GB25687@peff.net>
 <xmqq38cjjgjp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:43:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKmV-0003i4-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbaHZRnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:43:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:59399 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752955AbaHZRni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:43:38 -0400
Received: (qmail 2794 invoked by uid 102); 26 Aug 2014 17:43:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 12:43:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 13:43:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38cjjgjp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255929>

On Tue, Aug 26, 2014 at 10:40:10AM -0700, Junio C Hamano wrote:

> I may have called it lookup_name_decoration() to match, though, if I
> were doing this patch ;-)

Hmph. I called it "get" because that was the opposite of "add" to me,
and I was matching "add_name_decoration". Of course, in the regular
decoration code, the add function is also "add" and its opposite is
"lookup". So mine is gratuitously different. I do not mind if you adjust
while applying.

-Peff
