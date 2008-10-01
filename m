From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: interactive rebase not rebasing
Date: Wed, 1 Oct 2008 11:31:35 -0700
Message-ID: <20081001183135.GL21310@spearce.org>
References: <20080928235013.5c749c6e.stephen@exigencecorp.com> <48E078BF.5030806@op5.se> <20081001010306.01cc34eb.stephen@exigencecorp.com> <48E32BD4.1050107@op5.se> <20081001095225.d28de16a.stephen@exigencecorp.com> <48E396AF.2000100@op5.se> <20081001121321.5761fc7e.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 20:34:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl6Vf-0000Pf-Pi
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 20:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbYJASbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 14:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754197AbYJASbg
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 14:31:36 -0400
Received: from george.spearce.org ([209.20.77.23]:46720 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbYJASbg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 14:31:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 43B5E3835F; Wed,  1 Oct 2008 18:31:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081001121321.5761fc7e.stephen@exigencecorp.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97252>

Stephen Haberman <stephen@exigencecorp.com> wrote:
> 
> > > I've attempted to do that. Now that I sent in the patch, if you could
> > > review it, I would appreciate your feedback.
> > 
> > I'm heading home from work now. I'll look it over tonight or tomorrow
> > morning.
> 
> Cool, thanks.
> 
> Question: how taboo is it to just add another test file?
> 
> I can suffer through getting it to work, but a t3409 would be much
> easier, and probably easier to read as well as a I could setup my own
> DAG instead of hacking onto 3404s.

Usually folks prefer to add stuff to an existing test file, but
if the DAG is already a mess and you need a different DAG I find
it easier to just add new test file.  Thus far Junio hasn't pushed
back when I've done that.  Maybe I'm just lucky.  :-)

-- 
Shawn.
