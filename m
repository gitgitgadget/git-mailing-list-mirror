From: Jeff King <peff@peff.net>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 16:52:44 -0500
Message-ID: <20101203215244.GA4278@sigill.intra.peff.net>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
 <7v8w07rje3.fsf@alter.siamese.dyndns.org>
 <AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
 <AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
 <20101203175212.GA8267@sigill.intra.peff.net>
 <AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
 <20101203211158.GA2632@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:52:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POdYh-0007j5-PC
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab0LCVwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 16:52:47 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55843 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab0LCVwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 16:52:46 -0500
Received: (qmail 26720 invoked by uid 111); 3 Dec 2010 21:52:46 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.205)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 03 Dec 2010 21:52:46 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Dec 2010 16:52:44 -0500
Content-Disposition: inline
In-Reply-To: <20101203211158.GA2632@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162863>

On Fri, Dec 03, 2010 at 04:11:58PM -0500, Jeff King wrote:

> > Yes this does make sense to me. Although it is not necessary to have
> > conflicts during the merge - recursive merge as i understand also can
> > create new blobs.
> 
> I haven't thought about it too hard, but I don't see why any merge would
> create a new blob unless there is a conflict. Otherwise you are always
> taking one of the blobs that already exists in some other part of
> history.

Er, sorry, this is totally wrong. For some reason I said "conflict"
(repeatedly) when I meant "trivial merge". I guess my brain is not
working today.

Any time you have to do file-level merging (i.e., because both sides
of the merge touched that path) you will create a new blob, conflicts or
no.

-Peff
