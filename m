From: Willy Tarreau <w@1wt.eu>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 16:24:53 +0100
Message-ID: <20120312152453.GB12405@1wt.eu>
References: <20120312002046.041448832@1wt.eu> <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:25:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S777f-0002y0-6K
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017Ab2CLPZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:25:15 -0400
Received: from 1wt.eu ([62.212.114.60]:63178 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673Ab2CLPZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:25:13 -0400
Received: (from willy@localhost)
	by mail.home.local (8.14.4/8.14.4/Submit) id q2CFOrOv013538;
	Mon, 12 Mar 2012 16:24:53 +0100
Content-Disposition: inline
In-Reply-To: <20120312152004.GB9380@kroah.com>
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192887>

On Mon, Mar 12, 2012 at 08:20:04AM -0700, Greg KH wrote:
> > > Two relevant patches:
> > > 
> > >   f7e5ea17 (am: learn passing -b to mailinfo, 2012-01-16)
> > >   ee2d1cb4 (mailinfo: with -b, keep space after [foo], 2012-01-16)
> > > 
> > > are in "master" and 1.7.10-rc0 and were not part of any earlier release.
> > >
> > > Kudos to Thomas for writing them.
> > 
> > Ah, thank you very much for this useful info, I'll update my version !
> 
> I don't see a -b option to 'git am' in the manpage, am I missing
> something here?

It's in the master tree only right now, and the option is "--keep-non-patch"
(could have been shorter). Currently rebuilding to test it :-)

Willy
