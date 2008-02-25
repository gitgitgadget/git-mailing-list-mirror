From: Jeff King <peff@peff.net>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 13:35:48 -0500
Message-ID: <20080225183547.GB15131@sigill.intra.peff.net>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <4d8e3fd30802241456l6c02a040te21643c830cf0e46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTiCZ-0002wd-3b
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 19:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759290AbYBYSfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 13:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759275AbYBYSfv
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 13:35:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4890 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759265AbYBYSfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 13:35:50 -0500
Received: (qmail 11612 invoked by uid 111); 25 Feb 2008 18:35:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 25 Feb 2008 13:35:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2008 13:35:48 -0500
Content-Disposition: inline
In-Reply-To: <4d8e3fd30802241456l6c02a040te21643c830cf0e46@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75041>

On Mon, Feb 25, 2008 at 02:26:03AM +0330, Paolo Ciarrocchi wrote:

> I can't think of how to unify the commands from the ui point of view.
> What do you suggest?
> 
> However, i like the idea of a --send commad line option to
> git-format-patch that calls git-send-email to create and send the
> patch series.

I think it makes sense the other way around: have git-send-email invoke
git-format-patch.

My reasoning is that git-send-email users almost always use
git-format-patch, but git-format-patch users frequently do not use
git-send-email.

-Peff
