From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Thu, 30 Oct 2008 10:34:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810301024300.13034@xanadu.home>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:36:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYdI-00065g-Pj
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbYJ3OfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbYJ3OfF
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:35:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47758 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbYJ3OfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:35:04 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9K005P035VIBD0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Oct 2008 10:34:43 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1225338485-11046-1-git-send-email-sam@vilain.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99472>

On Wed, 29 Oct 2008, Sam Vilain wrote:

> From: Sam Vilain <samv@vilain.net>
> 
> For cross-command CLI changes to be effective, they need to be
> cohesively planned.  Add a planning document for this next set of
> changes.
> 
> Signed-off-by: Sam Vilain <sam@vilain.net>
[...]

> +  * 'git checkout branch' would, if there is a remote branch called
> +    'branch' on exactly one remote, do what
> +    'git checkout -b branch thatremote/branch' does now.  If it is
> +    ambiguous, it would be an error, forcing the explicit notation.

I can't do otherwise but disagree with this.  Currently, when a remote 
branch is checked out, the commit corresponding to that remote branch is 
put on a detached head which is IMHO completely sane and coherent. It 
even tells you how to create a local branch from there if that's what 
you wanted to do.  So if it is still too confusing at that point then 
more explanations are needed and not the removal of a perfectly fine 
feature. Please don't change that behavior.


Nicolas
