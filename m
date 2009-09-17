From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] archive: Refuse to write the archive to a terminal.
Date: Wed, 16 Sep 2009 18:49:10 -0700
Message-ID: <20090917014854.GD3274@feather>
References: <20090916103129.GA21430@feather>
 <4AB0C7DE.7030109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 03:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo6Co-000139-Q6
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 03:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759841AbZIQBt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 21:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758176AbZIQBt2
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 21:49:28 -0400
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:50733 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206AbZIQBt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 21:49:27 -0400
Received: from feather (65-122-183-162.dia.static.qwest.net [65.122.183.162])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 6A14A362AF;
	Thu, 17 Sep 2009 03:49:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AB0C7DE.7030109@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128703>

On Wed, Sep 16, 2009 at 01:11:26PM +0200, Johannes Sixt wrote:
> Josh Triplett schrieb:
> > I considered adding a -f/--force option, like gzip has, but writing an
> > archive to a tty seems like a sufficiently insane use case that I'll let
> > whoever actually needs that write the patch for it. ;)
> 
> How about '--output -' instead?

Yeah, that seems significantly better than --force.  Though I don't
particularly care for the '-' convention to mean 'stdout'; in principle
that ought to create a file named '-' in the current directory.
/dev/stdout makes more sense, and doesn't require any work on git's
part beyond this patch.

- Josh Triplett
