From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Tue, 10 Apr 2012 14:00:44 -0400
Message-ID: <20120410180044.GA23758@sigill.intra.peff.net>
References: <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do>
 <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
 <7vvcmzczku.fsf@alter.siamese.dyndns.org>
 <CAA01Cso0bjN5d40p0jRKdWt_vJ06C+X+Q1PJqtEsAheYfHBiSw@mail.gmail.com>
 <7vbomzqzuc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:00:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHfN7-00045J-PX
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 20:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab2DJSAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 14:00:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56097
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab2DJSAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 14:00:46 -0400
Received: (qmail 31496 invoked by uid 107); 10 Apr 2012 18:00:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Apr 2012 14:00:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Apr 2012 14:00:44 -0400
Content-Disposition: inline
In-Reply-To: <7vbomzqzuc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195112>

On Tue, Apr 10, 2012 at 09:23:59AM -0700, Junio C Hamano wrote:

> > could I ask what is the status of this? There were some patches
> > posted, but I think nothing final?
> 
> I do not think you meant to address your inquiry to me, but I think these
> patches tried out some ideas, got issues discovered in them and then got
> abandoned before resulting in a working code that is ready for testing.

Yes. I think we decided that we needed some pretty good testing to add
the cache_tree handling back into unpack_trees. I'd still like to do
that testing, but haven't done it yet.

-Peff
