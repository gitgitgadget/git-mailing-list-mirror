From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] status: add --long for default format
Date: Tue, 16 Oct 2012 14:32:33 -0400
Message-ID: <20121016183233.GE27243@sigill.intra.peff.net>
References: <1350404569-9787-1-git-send-email-pclouds@gmail.com>
 <20121016172204.GB27243@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 20:32:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOBwf-0001fK-96
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 20:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab2JPSch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 14:32:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55211 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118Ab2JPSch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 14:32:37 -0400
Received: (qmail 18735 invoked by uid 107); 16 Oct 2012 18:33:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 14:33:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 14:32:33 -0400
Content-Disposition: inline
In-Reply-To: <20121016172204.GB27243@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207868>

On Tue, Oct 16, 2012 at 01:22:04PM -0400, Jeff King wrote:

>   2. When an output format is given to "git commit", we
>      default to "--dry-run". This behavior would now kick in
>      when "--long" is given, too.

I forgot to mention in my previous message: your patch should probably
add "--long" to git-commit for consistency.

-Peff
