From: Jeff King <peff@peff.net>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Tue, 6 Nov 2007 13:09:10 -0500
Message-ID: <20071106180910.GA25934@sigill.intra.peff.net>
References: <20071105175654.GD6205@artemis.corp> <20071106175627.GB9517@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 19:09:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpSri-0000dG-26
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 19:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbXKFSJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 13:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbXKFSJO
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 13:09:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1301 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbXKFSJO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 13:09:14 -0500
Received: (qmail 32172 invoked by uid 111); 6 Nov 2007 18:09:12 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 06 Nov 2007 13:09:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2007 13:09:10 -0500
Content-Disposition: inline
In-Reply-To: <20071106175627.GB9517@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63695>

On Tue, Nov 06, 2007 at 06:56:27PM +0100, Pierre Habouzit wrote:

>   On the same vein, with today's next:
> 
>     $ git push origin :teaser
>     To ssh://git.corp/srv/git/mmsx.git
>      - [deleting]        teaser
>     refs/heads/teaser: 05518bc7df1af680447f58b034b108f66668db03 -> deleted
>     Everything up-to-date
>     fatal: Invalid revision range 05518bc7df1af680447f58b034b108f66668db03..0000000000000000000000000000000000000000
>     fatal: ambiguous argument 'refs/heads/teaser': unknown revision or path not in the working tree.
>     Use '--' to separate paths from revisions

I can't replicate this output; can you provide more information on your
test repo?

If it is related to the bug we have been discussing, there haven't been
any fixes applied yet. :)

-Peff
