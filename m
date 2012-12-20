From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Thu, 20 Dec 2012 10:02:52 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121220150252.GA24387@thyrsus.com>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
 <20121220144813.GA27211@sigill.intra.peff.net>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:03:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlhel-0005R8-5k
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114Ab2LTPDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 10:03:13 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35608
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab2LTPDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 10:03:12 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 9EC2B44105; Thu, 20 Dec 2012 10:02:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121220144813.GA27211@sigill.intra.peff.net>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211894>

Jeff King <peff@peff.net>:
> On Thu, Dec 20, 2012 at 09:13:37AM -0500, Eric S. Raymond wrote:
> 
> > diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
> > index bd24395..b55648f 100755
> > --- a/contrib/ciabot/ciabot.py
> > +++ b/contrib/ciabot/ciabot.py
> > @@ -50,6 +50,11 @@
> >  import os, sys, commands, socket, urllib
> >  from xml.sax.saxutils import escape
> >  
> > +if sys.hexversion < 0x02000000:
> > +	# The limiter is the xml.sax module
> > +        sys.stderr.write("import-zips.py: requires Python 2.0.0 or later.")
> > +        sys.exit(1)
> 
> Should the error message say ciabot.py?
> 
> -Peff

Gack.  Yes.  Thaty's what I get for cut-and-pasting too quickly.
The information about xnml.sex is correct, though.

Want me to resubmit, or will you just patch it?

Note by the way that I still think the entire ciabot subtree (which is 
my code) should just be nuked.  CIA is not coming back, wishful thinking 
on Ilkotech's web page notwithstanding.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
