From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 1/4] Add a simple option parser for use by builtin-commit.c.
Date: Wed, 3 Oct 2007 22:11:29 +0200
Message-ID: <20071003201129.GB25856@diku.dk>
References: <1190868632-29287-1-git-send-email-krh@redhat.com> <20070930131133.GA11209@diku.dk> <1191255975.25093.26.camel@hinata.boston.redhat.com> <Pine.LNX.4.64.0710011909291.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 22:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAbM-0004ta-P1
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbXJCUNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbXJCUNl
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:13:41 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:58394 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603AbXJCUNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:13:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id E0A4C52C408;
	Wed,  3 Oct 2007 22:13:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ue5j53lrGQh0; Wed,  3 Oct 2007 22:13:36 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 6BA6A52C520;
	Wed,  3 Oct 2007 22:11:29 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A3EFE6DF8B9; Wed,  3 Oct 2007 22:06:14 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 4A46F632F1; Wed,  3 Oct 2007 22:11:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710011909291.28395@racer.site>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59879>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote Mon, Oct 01, 2007:
> On Mon, 1 Oct 2007, Kristian H?gsberg wrote:
> > On Sun, 2007-09-30 at 15:11 +0200, Jonas Fonseca wrote:
> > > > +
> > > > +extern int parse_options(const char ***argv,
> > > > +			 struct option *options, int count,
> > > > +			 const char *usage_string);
> > > 
> > > I think the interface could be improved a bit. For example, it doesn't 
> > > need to count argument since the last entry in the options array is 
> > > OPTION_LAST and thus the size can be detected that way.
> > 
> > Hehe, yeah, that's how I did it first.  I don't have a strong preference 
> > for terminator elements vs. ARRAY_SIZE(), but Junio prefers the 
> > ARRAY_SIZE() approach, I guess.  At this point I'm just trying the get 
> > the patches upstream...
> 
> FWIW I like the ARRAY_SIZE() approach better, too, since it is less error 
> prone.

OK, I must have missed that comment. Good point.

Thanks for the comments both of you. It's great to have something to
work from. However, I also fear it will also require that some extra
flags or information is added to the option information to make it more
generally usable. But I guess that is easier to discuss in the context
of a patch.

-- 
Jonas Fonseca
