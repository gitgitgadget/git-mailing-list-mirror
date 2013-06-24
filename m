From: Fraser Tweedale <frase@frase.id.au>
Subject: Re: [PATCH] documentation: fix asterisks in fetch-options
Date: Mon, 24 Jun 2013 21:42:03 +1000
Message-ID: <20130624114202.GT2457@bacardi.hollandpark.frase.id.au>
References: <1372073467-29112-1-git-send-email-frase@frase.id.au>
 <8761x33fny.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 24 13:50:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur5I7-0001ob-DW
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 13:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab3FXLuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 07:50:35 -0400
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:63690
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753147Ab3FXLuc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 07:50:32 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2013 07:50:32 EDT
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r5OBg5LF029495;
	Mon, 24 Jun 2013 21:42:05 +1000 (EST)
	(envelope-from frase@frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r5OBg312029494;
	Mon, 24 Jun 2013 21:42:03 +1000 (EST)
	(envelope-from frase@frase.id.au)
X-Authentication-Warning: bacardi.hollandpark.frase.id.au: fraser set sender to frase@frase.id.au using -f
Content-Disposition: inline
In-Reply-To: <8761x33fny.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228806>

Right you are.  I missed that; apologies for the noise.

Fraser

On Mon, Jun 24, 2013 at 01:35:13PM +0200, Thomas Rast wrote:
> Fraser Tweedale <frase@frase.id.au> writes:
> 
> > diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> > index 9cb6496..f2ac3bc 100644
> > --- a/Documentation/fetch-options.txt
> > +++ b/Documentation/fetch-options.txt
> > @@ -61,11 +61,12 @@ endif::git-pull[]
> >  ifndef::git-pull[]
> >  -t::
> >  --tags::
> > -	This is a short-hand for giving "refs/tags/*:refs/tags/*"
> > -	refspec from the command line, to ask all tags to be fetched
> > -	and stored locally.  Because this acts as an explicit
> > -	refspec, the default refspecs (configured with the
> > -	remote.$name.fetch variable) are overridden and not used.
> > +	This is a short-hand for giving
> > +	"refs/tags/{asterisk}:refs/tags/{asterisk}" refspec from the
> > +	command line, to ask all tags to be fetched and stored
> > +	locally.  Because this acts as an explicit refspec, the
> > +	default refspecs (configured with the remote.$name.fetch
> > +	variable) are overridden and not used.
> 
> Wasn't this already fixed by 9eb4754 (fetch-options.txt: prevent a
> wildcard refspec from getting misformatted, 2013-06-07), currently in
> master?
> 
> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch
