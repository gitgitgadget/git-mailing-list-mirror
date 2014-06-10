From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/15] use get_commit_buffer to avoid duplicate code
Date: Tue, 10 Jun 2014 16:34:37 -0400
Message-ID: <20140610203437.GH14974@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140609181247.GJ20315@sigill.intra.peff.net>
 <CAPig+cTztiY3va-oztwe+FRsEgtFh0r6jsYY1Vn5dtvg3fHfZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:34:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSkl-0000og-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbaFJUek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:34:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:41282 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755371AbaFJUei (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:34:38 -0400
Received: (qmail 14760 invoked by uid 102); 10 Jun 2014 20:34:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 15:34:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 16:34:37 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTztiY3va-oztwe+FRsEgtFh0r6jsYY1Vn5dtvg3fHfZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251234>

On Tue, Jun 10, 2014 at 04:01:29AM -0400, Eric Sunshine wrote:

> > For record_author_date, the new behavior is probably better;
> > we notify the user of the error instead of silently ignoring
> > it. And because it's used only for sorting by author-date,
> > somebody examining a corrupt can fallback to the regular
> 
> Missing word here? "examining a corrupt [...] can"

It was "repo". Thanks, fixed this and your other comments for my
re-roll (I'm still looking into the best solution for the strbuf_attach
issue Junio mentioned).

-Peff
