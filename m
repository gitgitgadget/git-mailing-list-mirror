From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Sun, 27 Apr 2014 03:56:40 -0400
Message-ID: <20140427075640.GB19976@sigill.intra.peff.net>
References: <20140421204622.GA9532@logfs.org>
 <20140425182928.GA29904@logfs.org>
 <vpqoazpdz1r.fsf@anie.imag.fr>
 <20140425201048.GB29904@logfs.org>
 <20140426071358.GA7558@sigill.intra.peff.net>
 <CACsJy8ANE+2n6fd-mF5pp+p2sXy_uRzJ2c+O=AiySyre+6KLtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 09:56:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeJx9-0000E0-MF
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 09:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbaD0H4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Apr 2014 03:56:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:39429 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752699AbaD0H4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 03:56:42 -0400
Received: (qmail 4454 invoked by uid 102); 27 Apr 2014 07:56:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 27 Apr 2014 02:56:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Apr 2014 03:56:40 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8ANE+2n6fd-mF5pp+p2sXy_uRzJ2c+O=AiySyre+6KLtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247194>

On Sun, Apr 27, 2014 at 09:12:39AM +0700, Duy Nguyen wrote:

> The intent of the commit was "that is a stupid thing to do, but it's
> not so obvious from the first glance, do not freeze my system for my
> mistake". But if it stops an actual use case, then I agree it should
> be reverted.

Thanks for the explanation. I think we should just go with J=C3=B6rn's =
patch
as-is, then.

-Peff
