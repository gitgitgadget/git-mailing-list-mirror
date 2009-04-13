From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] make get_short_ref a public function
Date: Mon, 13 Apr 2009 04:15:43 -0400
Message-ID: <20090413081543.GA9846@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net> <20090407071420.GD2924@coredump.intra.peff.net> <36ca99e90904070039m15869c34jc9e12d5ccc48d82@mail.gmail.com> <20090409081857.GC17221@coredump.intra.peff.net> <36ca99e90904090205g8a6a5a6nea96f8c5f44e076a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 10:17:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtHLz-0003Cr-QN
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 10:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbZDMIPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 04:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbZDMIPp
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 04:15:45 -0400
Received: from peff.net ([208.65.91.99]:48859 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026AbZDMIPp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 04:15:45 -0400
Received: (qmail 30828 invoked by uid 107); 13 Apr 2009 08:15:47 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 04:15:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 04:15:43 -0400
Content-Disposition: inline
In-Reply-To: <36ca99e90904090205g8a6a5a6nea96f8c5f44e076a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116418>

On Thu, Apr 09, 2009 at 11:05:06AM +0200, Bert Wesarg wrote:

> > you the one you want). An alternative would be to show:
> >
> > =C2=A0heads/master
> > =C2=A0remotes/master
> >
> > in this case.
> Right, and the idea was to choose the alternatives based on the
> core.warnAmbiguousRefs setting, i.e. the former for false, the latter
> for true.
>=20
> For what I posted a patch some time ago:
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/96464

Ah, OK, now I understand what you meant. I think that is the right
solution. Thanks.

-Peff
