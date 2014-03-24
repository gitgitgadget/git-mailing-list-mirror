From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/10] pickaxe: move pickaxe() after pickaxe_match()
Date: Mon, 24 Mar 2014 17:21:02 -0400
Message-ID: <20140324212101.GC13728@sigill.intra.peff.net>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
 <1395508560-19893-9-git-send-email-l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:21:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCIy-0007LB-77
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbaCXVVF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 17:21:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:46045 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750972AbaCXVVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:21:04 -0400
Received: (qmail 7974 invoked by uid 102); 24 Mar 2014 21:21:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 16:21:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 17:21:02 -0400
Content-Disposition: inline
In-Reply-To: <1395508560-19893-9-git-send-email-l.s.r@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244871>

On Sat, Mar 22, 2014 at 06:15:58PM +0100, Ren=C3=A9 Scharfe wrote:

> pickaxe() calls pickaxe_match(); moving the definition of the former
> those after the latter allows us to do without an explicit function
> declaration.

s/those //

-Peff
