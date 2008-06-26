From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: how do I merge completely unrelated repositories ?
Date: Thu, 26 Jun 2008 13:42:08 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302389CAA@emailmn.mqsoftware.com>
References: <46d6db660806260239xc57ffaag6469967ae2257cb1@mail.gmail.com> <20080626094522.GA29404@genesis.frugalware.org> <alpine.DEB.1.00.0806261224020.9925@racer> <20080626161941.GX20723@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Oliver Kullmann" <O.Kullmann@swansea.ac.uk>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:43:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwR5-0007zM-L9
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 20:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbYFZSmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbYFZSmN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 14:42:13 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:45225 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYFZSmM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2008 14:42:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20080626161941.GX20723@cs-wsok.swansea.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how do I merge completely unrelated repositories ?
Thread-Index: AcjXuu10phevFfnURvuFgn3tFF6EwQAAMO3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86472>


> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Oliver Kullmann
> Sent: Thursday, June 26, 2008 11:20 AM
> To: git@vger.kernel.org
> Subject: Re: how do I merge completely unrelated repositories ?
> 
> Hi,
> 
> since a similar question burdens my soul for quite some
> time, I would like to take the opportunity to extend
> the question a bit:
> 
> I have around 10 CVS repositories, each with around 5 modules.
> This has developed over time, and now I want to combine them
> all into a single Git repository, with a new directory
> structure introduced.
> 
> One possibility would be to convert these 50 CVS modules
> into git repositories, then for each of these git repositories
> introduce the new tree structure (that is, what is relevant
> for this part), move all files to their new location (via
> "git mv"), and finally pull everything in into the common
> repository.
> 
> This is all fine, except of the inability to follow the history
> nicely (for example, via gitk I will only see the history
> from the point on where in those temporary git-repositories
> the files have been moved to their new place).
> 
> To avoid this break in the history, it would be great if
> cvsimport could already move the files to the right place
> in the directory hierarchy, that is, if an additional
> parameter P could be given, the initial path, and files
> will be imported as P/file. Then I could import everything right away
> into
> the final git repository, without problems with clashes.
> I can't find something like that in the documentation.
> 
> Is there perhaps some other possibility?
> It seems easiest to me to do this little bit of surgery
> at the time of the import, before git gets into his
> troubles with hash-values.
> 
> thanks!
> 
> Oliver
> 
> 
Oliver,
  I wrote a little (314 line) perl script to blend multiple cvsps output
streams together before handing them to git-cvsimport, it seems to work
fine.  It should (but I haven't tested it) even still allow the
incremental approach.

Not sure if I should just attach it here (it's not that big, but still),
but if you need/want a copy of "cvsps_blender.pl", just send me an email
and I'll send it out....

-Kelly
