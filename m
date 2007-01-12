From: Jeff King <peff@peff.net>
Subject: Re: Removing files
Date: Thu, 11 Jan 2007 19:17:55 -0500
Message-ID: <20070112001754.GD16042@coredump.intra.peff.net>
References: <87bql5cok3.fsf@morpheus.local> <87bql5xhbi.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 01:18:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5A7O-0001i6-76
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXALAR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXALAR6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:17:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4421 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751460AbXALAR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 19:17:58 -0500
Received: (qmail 32673 invoked from network); 11 Jan 2007 19:18:10 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Jan 2007 19:18:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2007 19:17:55 -0500
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87bql5xhbi.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36641>

On Thu, Jan 11, 2007 at 03:41:05PM -0800, Carl Worth wrote:

>     git commit -a
> 
> 	Commit the working-tree content of all files known to git.
> 
>     git commit paths...
> 
> 	Commit changes from the working-tree content of the specified
> 	paths.
> 
>     git commit
> 
> 	Commit changes from all content that has been staged with
> 	"git stage".
> 
[...]
> I really like the simplicity of explanation that this model
> provides. And I'd love to hear any feedback that anybody has about it.

I think this is a very easy way of explaining it in the documentation.
But what do you think 'git status' should say about changed files?
Currently we make recommendations about how to stage the various files.
It would certainly be simpler to recommend 'git commit -a' for changes,
but that feels wrong.

-Peff
