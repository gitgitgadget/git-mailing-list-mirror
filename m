From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 16:20:30 -0500
Message-ID: <20120210212030.GD5381@thunk.org>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki>
 <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <vpqbop6tyj6.fsf@bauges.imag.fr>
 <FC56A942-EE70-48B7-A2D3-CF53A189A55E@mit.edu>
 <1328900154.3171.27.camel@i5.mricon.com>
 <20120210195736.GA5381@thunk.org>
 <7vhayyphlw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konstantin Ryabitsev <icon@mricon.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:20:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvxtb-0000F9-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438Ab2BJVUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 16:20:39 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:35652 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758959Ab2BJVUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:20:38 -0500
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1RvxtQ-000161-Mz; Fri, 10 Feb 2012 21:20:32 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1RvxtO-0001be-47; Fri, 10 Feb 2012 16:20:30 -0500
Content-Disposition: inline
In-Reply-To: <7vhayyphlw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190455>

On Fri, Feb 10, 2012 at 12:18:35PM -0800, Junio C Hamano wrote:
> That would not work very well without changing the historical directory
> structure (which I think was the point of this discussion "please keep
> these stale links alive").
> 
> The toplevel index.html in the pub/software/scm/git/docs/ directory and
> its pointees were the set of docs for the latest version, and older
> versions were rooted at pub/software/scm/git/docs/vX.Y.Z/.  Links that
> point at software/scm/git/docs/git-cat-file.html still need to work, and
> the path needs to be updatable without having to include the preformatted
> documentation for all the historical versions in the same tarball.

Hmm... good point.  That does make it hard.  I could imagine making it
work by having separate hierarchies, and then using apache rewrite
rules so that anything that doesn't begin with vX.Y.Z in the top level
of software/scm/git/docs/* gets redirected to LATEST/*, where LATEST is
a symlink that is managed via kup.

I don't know if the k.org folks would consider that acceptable, though.

  	     	    	  	      	   - Ted
