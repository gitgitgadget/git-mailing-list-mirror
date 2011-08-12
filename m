From: Jeff King <peff@peff.net>
Subject: Re: Suggestions to make git easier to understand
Date: Fri, 12 Aug 2011 16:26:27 -0600
Message-ID: <20110812222626.GA7079@sigill.intra.peff.net>
References: <CAGK7Mr5T4-DBK7rXeH-1=SNu5HBOEkLBW=CAh5Lhf7oHKjFAiw@mail.gmail.com>
 <20110811221627.GA32005@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org,
	Rafael Magana <raf.magana@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 00:26:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs0BZ-0000ug-Uw
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 00:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab1HLW0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 18:26:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38144
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab1HLW0c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 18:26:32 -0400
Received: (qmail 10083 invoked by uid 107); 12 Aug 2011 22:27:07 -0000
Received: from cpe-76-167-230-207.socal.res.rr.com (HELO sigill.intra.peff.net) (76.167.230.207)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Aug 2011 18:27:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Aug 2011 16:26:27 -0600
Content-Disposition: inline
In-Reply-To: <20110811221627.GA32005@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179258>

On Thu, Aug 11, 2011 at 05:16:27PM -0500, Jonathan Nieder wrote:

> > http://raflabs.com/blogs/silence-is-foo/2011/04/07/staging-area-index-cache-git/
> >
> > I thought it made some good points about git being kinda confusing,
> > for example sentences like "Changed but not updated" in git status
> > could use a better sentence like "Changed but not in the index".
> 
> Sounds reasonable (well, with some more precise wording to reflect
> that this means "changed but not all changes are reflected in the
> index").

Didn't we fix this already in 8009d83 (Better "Changed but not updated"
message in git-status, 2010-11-02)? Since v1.7.4, "git status" has
"Changes not staged for commit".

-Peff
