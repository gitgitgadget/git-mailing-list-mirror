From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 15:11:46 -0400
Message-ID: <20130506191146.GA3056@sigill.intra.peff.net>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
 <1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
 <20130506123111.GB3809@sigill.intra.peff.net>
 <CAMP44s2rvu2PaazHEx-OXaZbuBAX7sZb04Oh38ifyAEG6kcxkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 21:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQpF-0003Bm-LC
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab3EFTLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:11:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:40705 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768Ab3EFTLs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:11:48 -0400
Received: (qmail 23794 invoked by uid 102); 6 May 2013 19:12:09 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 14:12:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 15:11:46 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2rvu2PaazHEx-OXaZbuBAX7sZb04Oh38ifyAEG6kcxkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223485>

On Mon, May 06, 2013 at 02:02:13PM -0500, Felipe Contreras wrote:

> > I did a double-take on reading this subject line and first paragraph,
> > thinking "surely fast-export needs to actually output blobs?".
> 
> If you think that, then you are not familiar with the code.
> 
> --export-marks=<file>::
> [...]

My point was that nothing in the subject line nor that first paragraph
(nor, for that matter, the entire commit message) says that we are
talking about marks here.

> > Reading the patch, I see that this is only about not bothering to load
> > blob marks from --import-marks. It might be nice to mention that in the
> > commit message, which is otherwise quite confusing.
> 
> The commit message says it exactly like it is: we don't care about blobs.

If you guess that "we" means the marks code and not all of fast-export,
then yes. But I do not have any desire to get into another debate trying
to convince you that there is value to having a clear commit message.
Junio has already proposed a much more readable one.

-Peff
