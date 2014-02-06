From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t5538: fix default http port
Date: Thu, 6 Feb 2014 14:35:36 -0500
Message-ID: <20140206193533.GB14552@sigill.intra.peff.net>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:35:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBUjf-0005vS-FA
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbaBFTfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 14:35:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:45917 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751500AbaBFTfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 14:35:39 -0500
Received: (qmail 23900 invoked by uid 102); 6 Feb 2014 19:35:39 -0000
Received: from mobile-032-128-012-224.mycingular.net (HELO sigill.intra.peff.net) (32.128.12.224)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Feb 2014 13:35:39 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Feb 2014 14:35:36 -0500
Content-Disposition: inline
In-Reply-To: <1391699439-22781-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241715>

On Thu, Feb 06, 2014 at 10:10:35PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Originally I had t5537 use port 5536 and 5538 use port 5537(!). Then
> Jeff found my fault so I changed port in t5537 from 5536 to 5537 in
> 3b32a7c (t5537: fix incorrect expectation in test case 10 -
> 2014-01-08). Which makes it worse because now both t5537 and t5538
> both use the same port. Fix it.

Yikes. I'm surprised we didn't notice this before, as it would probably
barf intermittently when running the tests in parallel. Perhaps it was
the cause of some intermittent failures that have gone undiagnosed.

Patch looks obviously correct.

-Peff
