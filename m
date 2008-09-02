From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 02 Sep 2008 16:35:47 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809021634300.23787@xanadu.home>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <vpq3aki1eh6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaccz-0006ve-Nm
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbYIBUgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbYIBUgX
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:36:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10748 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbYIBUgW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:36:22 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6L00HIQ57NI0C1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Sep 2008 16:35:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpq3aki1eh6.fsf@bauges.imag.fr>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94707>

On Tue, 2 Sep 2008, Matthieu Moy wrote:

> Pieter de Bie <pdebie@ai.rug.nl> writes:
> 
> > +       if (!strcmp("HEAD", head))
> > +               printf("You are on a detached head, so this commit "
> > +                       "has not been recorded in a branch.\n"
> > +                       "If you don't want to lose this commit, checkout a "
> > +                       "branch and then run:\n"
> > +                       "       git merge %s\n", sha1_to_hex(sha1));
> 
> I'd say
> 
> +                       "If you don't want to lose this commit, run "
> +                       "git branch <some-name>\n"
> +			"to create a named branch for the commit you just made");
> 
> (or whatever better wording you find, but I think suggesting to name
> the branch makes more sense that merging it)

Agreed. Something that repeat more or less the message that was given 
when detaching HEAD in the first place would be best.


Nicolas
