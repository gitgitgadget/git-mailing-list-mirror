From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: do not accept non-blobs as new notes
Date: Tue, 8 May 2012 12:03:34 -0400
Message-ID: <20120508160334.GA26838@sigill.intra.peff.net>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 18:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRmt3-0002c0-Mr
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab2EHQDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:03:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34130
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426Ab2EHQDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:03:36 -0400
Received: (qmail 4475 invoked by uid 107); 8 May 2012 16:03:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 May 2012 12:03:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2012 12:03:34 -0400
Content-Disposition: inline
In-Reply-To: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197378>

On Tue, May 08, 2012 at 08:11:32PM +0700, Nguyen Thai Ngoc Duy wrote:

> While at it, check if current notes are blobs before using them.

Hmm. There has been discussion in the past on whether trees could be
stored in notes. Here's one such thread:

  http://thread.gmane.org/gmane.comp.version-control.git/139165

There didn't seem to be any consensus. It might be a useful concept, but
it might introduce some complexity. That discussion is two years old
now, and notes are even older. So I don't know that there is some
pressing use case that is cut off by disallowing non-blob notes.

At the same time, is there any reason not to allow experimentation in
this area? We don't know what other people might be putting in their
private notes trees, and the current interface does allow this.

Is this fixing some important problem that justifies making such
experimentation harder?

-Peff
