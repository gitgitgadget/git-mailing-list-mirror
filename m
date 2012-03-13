From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: Introduce diff.algorithm variable
Date: Tue, 13 Mar 2012 16:48:26 -0400
Message-ID: <20120313204826.GA27436@sigill.intra.peff.net>
References: <06652d553040ad6b25608dc69d632f1ee38eaeca.1331300343.git.mprivozn@redhat.com>
 <CALUzUxpR_bPLvnHRJrQ2wVpqJD6Ccg6r3RMa_sCDKHTapnJsdw@mail.gmail.com>
 <7v399cxuk9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Michal Privoznik <mprivozn@redhat.com>, git@vger.kernel.org,
	trast@student.ethz.ch, Lawrence.Holding@cubic.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 21:48:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Ye2-0006U7-T3
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 21:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205Ab2CMUsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 16:48:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48671
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780Ab2CMUs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 16:48:29 -0400
Received: (qmail 1937 invoked by uid 107); 13 Mar 2012 20:48:40 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Mar 2012 16:48:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2012 16:48:26 -0400
Content-Disposition: inline
In-Reply-To: <7v399cxuk9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193066>

On Tue, Mar 13, 2012 at 10:46:46AM -0700, Junio C Hamano wrote:

> Tay Ray Chuan <rctay89@gmail.com> writes:
> 
> > Considering that --minimal isn't really an algorithm,...
> 
> I think this discussion thread already settled that "minimal" *is* an
> algorithm for the purpose of this topic, considering that the --minimal
> option does not apply anything but myers.

I don't know that it is settled. I proposed it as a concept, and nobody
else objected. It is true that right _now_ --minimal doesn't do anything
for non-myers algorithms, but in theory it could. IOW, it is a matter of
the user's perspective whether the flag is "use the minimal Myers diff
algorithm" versus "spend extra effort to make the diff more minimal, no
matter which algorithm is being used". If the latter, it is only that we
have not (yet) implemented the extra effort tweaks to the other
algorithms.

So I think we could go either way.

-Peff
