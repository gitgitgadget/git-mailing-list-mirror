From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 15:52:31 -0400
Message-ID: <20130909195231.GA14021@sigill.intra.peff.net>
References: <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
 <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
 <20130909000153.GG5359@vauxhall.crustytoothpaste.net>
 <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
 <vpqr4cy4g5q.fsf@anie.imag.fr>
 <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 21:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ7Vm-0005DF-16
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 21:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab3IITwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 15:52:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:57471 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645Ab3IITwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 15:52:33 -0400
Received: (qmail 22080 invoked by uid 102); 9 Sep 2013 19:52:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Sep 2013 14:52:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Sep 2013 15:52:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234365>

On Mon, Sep 09, 2013 at 11:47:45AM -0700, Junio C Hamano wrote:

> You are in favor of an _option_ to allow people to forbid a pull in
> a non-ff situation, and I think other people are also in
> agreement. So perhaps:
> 
>  - drop jc/pull-training-wheel and revert its merge from 'next';
> 
>  - update Felipe's series with a bit of tweak to make it less
>    impactful by demoting error into warning and advice.
> 
> would be a good way forward?

I think that would address the concern I raised, because it does not
create a roadblock to new users accomplishing their task. They can
ignore the warning, or choose "merge" as the default to shut up the
warning (and it is easy to choose that if you are confused, because it
is what git is doing by default alongside the warning).

-Peff
