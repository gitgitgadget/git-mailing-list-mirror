From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix the MacOS X compile of gitk by pinching po2msg.sh from git-gui
Date: Wed, 9 Jan 2008 13:52:49 +0000
Message-ID: <20080109135249.GA12869@hashpling.org>
References: <20080109132953.GA12489@hashpling.org> <alpine.LSU.1.00.0801091339390.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 09 14:53:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCbN0-0000b4-E6
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 14:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbYAINw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 08:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYAINw6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 08:52:58 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:50471 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYAINw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 08:52:57 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1JCbMV-0008WA-J4; Wed, 09 Jan 2008 13:52:55 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m09DqqD6013363;
	Wed, 9 Jan 2008 13:52:52 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m09DqneW013362;
	Wed, 9 Jan 2008 13:52:49 GMT
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801091339390.31053@racer.site>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69991>

On Wed, Jan 09, 2008 at 01:40:46PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 9 Jan 2008, Charles Bailey wrote:
> 
> > --- snip ---
> 
> Since gitk and git-gui are separate projects (pulled at irregular 
> intervals into git.git), your patch looks sane, but would be better done 
> as a patch against gitk.git.
> 
> Ciao,
> Dscho

I'm sorry, I think I knew this once, but had forgotten.  Of course, as
a patch against gitk, I think it gets quite verbose as the patch
includes a full copy of the po2msg.sh script.

Is there a simple way to generate a gitk.git patch from a git.git
clone, or do I need to clone a gitk repository from somewhere?

Perhaps I could just flag this as a reasonably important MacOS X
1.5.4-rc issue until I can sort out a more suitable patch?

Thanks,

Charles.
