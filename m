From: Jeff King <peff@peff.net>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 13:03:32 -0500
Message-ID: <20110111180332.GD1833@sigill.intra.peff.net>
References: <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
 <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
 <7vmxnc48yt.fsf@alter.siamese.dyndns.org>
 <20110111053653.GB10094@sigill.intra.peff.net>
 <7vr5cj49vi.fsf@alter.siamese.dyndns.org>
 <20110111175031.GA2085@sigill.intra.peff.net>
 <20110111175621.GC15133@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 19:03:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PciZI-0006e4-T4
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 19:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab1AKSDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 13:03:36 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41001 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913Ab1AKSDf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 13:03:35 -0500
Received: (qmail 14590 invoked by uid 111); 11 Jan 2011 18:03:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 18:03:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 13:03:32 -0500
Content-Disposition: inline
In-Reply-To: <20110111175621.GC15133@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164965>

On Tue, Jan 11, 2011 at 11:56:21AM -0600, Jonathan Nieder wrote:

> Maybe something like
> 
> 	git fetch origin refs/views/2009/*:refs/replace/*

Heh, yeah, that is much simpler than what I did. :)

> A potential usability enhancement might be to allow additional
> replacement hierarchies to be requested on a per command basis, like
> 
> 	GIT_REPLACE_REFS=refs/remotes/origin/views/2009 gitk --all
> 
> along the lines of GIT_NOTES_REF.

Yes, that is a much better solution, IMHO.

-Peff
