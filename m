From: Jeff King <peff@peff.net>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Thu, 27 Sep 2012 13:39:32 -0400
Message-ID: <20120927173932.GE1547@sigill.intra.peff.net>
References: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:39:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THI3r-0005L3-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab2I0Rjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:39:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32930 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab2I0Rje (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:39:34 -0400
Received: (qmail 3861 invoked by uid 107); 27 Sep 2012 17:40:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 13:40:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 13:39:32 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206496>

On Thu, Sep 27, 2012 at 08:51:51AM -0700, Shawn O. Pearce wrote:

> On Thu, Sep 27, 2012 at 5:17 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > I'd like to see some sort of extension mechanism like in
> > $GIT_DIR/index, so that we don't have to increase pack index version
> > often. What I have in mind is optional commit cache to speed up
> > rev-list and merge, which could be stored in pack index too.
> 
> Can you share some of your ideas?

Some of it is here:

  http://article.gmane.org/gmane.comp.version-control.git/203308

-Peff
