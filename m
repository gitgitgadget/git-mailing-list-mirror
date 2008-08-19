From: Jeff King <peff@peff.net>
Subject: Re: Dumb "continuous" commit dumb question
Date: Tue, 19 Aug 2008 13:55:20 -0400
Message-ID: <20080819175520.GB10142@coredump.intra.peff.net>
References: <48AA4263.8090606@gmail.com> <e1dab3980808190732i303f06ach50e36e13a624bd23@mail.gmail.com> <20080819144853.GD20947@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tweed <david.tweed@gmail.com>,
	Pat LeSmithe <qed777@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:56:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVVRS-0002BI-Ee
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 19:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYHSRzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 13:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbYHSRzW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 13:55:22 -0400
Received: from peff.net ([208.65.91.99]:3265 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbYHSRzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 13:55:22 -0400
Received: (qmail 2900 invoked by uid 111); 19 Aug 2008 17:55:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Aug 2008 13:55:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2008 13:55:20 -0400
Content-Disposition: inline
In-Reply-To: <20080819144853.GD20947@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92888>

On Tue, Aug 19, 2008 at 07:48:53AM -0700, Shawn O. Pearce wrote:

> Actually you can do something like this:
> 
> 	export GIT_INDEX_FILE=.git/temp-branch-index &&
> 	cp .git/index $GIT_INDEX_FILE &&
> 	git add . &&
> 	git add -u &&
> 	git update-ref refs/heads/temp $(date | git commit-tree $(git write-tree) -p temp)

Get with the times, Shawn. It's "git add -A" now. ;)

-Peff
