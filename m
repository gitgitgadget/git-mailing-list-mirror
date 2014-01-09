From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5537: fix incorrect expectation in test case 10
Date: Thu, 9 Jan 2014 16:57:47 -0500
Message-ID: <20140109215746.GC32069@sigill.intra.peff.net>
References: <20140108112543.GA4419@sigill.intra.peff.net>
 <1389183199-6496-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 22:57:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1Nbt-0004jq-2R
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 22:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbaAIV5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jan 2014 16:57:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:58028 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751330AbaAIV5s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 16:57:48 -0500
Received: (qmail 9029 invoked by uid 102); 9 Jan 2014 21:57:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jan 2014 15:57:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jan 2014 16:57:47 -0500
Content-Disposition: inline
In-Reply-To: <1389183199-6496-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240277>

On Wed, Jan 08, 2014 at 07:13:19PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Commit 48d25ca adds a new commit "7" to the repo that the next test c=
ase
> in commit 1609488 clones from. But the next test case does not expect
> this commit. For these tests, it's the bottom that's important, not
> the top. Fix the expected commit list.

Given the test output, I had a feeling it was something like this but
didn't dive in (and figured it would be obvious to you).

Patch looks sane. Thanks for a quick turnaround.

-Peff
