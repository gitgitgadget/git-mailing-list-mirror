From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
	threads for packing
Date: Tue, 26 Feb 2008 18:04:52 -0500
Message-ID: <20080226230452.GA6721@sigill.intra.peff.net>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil> <47BF812A.4020205@nrlssc.navy.mil> <20080226074933.GA3485@coredump.intra.peff.net> <47C435DC.2070508@nrlssc.navy.mil> <20080226212118.GA32530@sigill.intra.peff.net> <47C497BF.8080900@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Feb 27 00:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU8rx-0007ds-Sd
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 00:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860AbYBZXEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 18:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbYBZXEz
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 18:04:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1060 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885AbYBZXEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 18:04:54 -0500
Received: (qmail 13325 invoked by uid 111); 26 Feb 2008 23:04:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 26 Feb 2008 18:04:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2008 18:04:52 -0500
Content-Disposition: inline
In-Reply-To: <47C497BF.8080900@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75187>

On Tue, Feb 26, 2008 at 04:50:39PM -0600, Brandon Casey wrote:

> > I don't think it's worth printing output so verbose that the user can
> > manually check that every config option was respected.
> 
> It's hard coming up with examples that someone cannot take to the N'th
> degree and make look ridiculous. Maybe impossible.

I know. I didn't mean to say "this message is ridiculous." I meant to
say "we should strive for consistency in interface, and I don't see
anything that makes this config option any different than, say,
core.followSymlinks."

-Peff
