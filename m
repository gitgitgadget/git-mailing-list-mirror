From: tytso@mit.edu
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 13:12:31 -0400
Message-ID: <20100706171231.GL25518@thunk.org>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
 <20100705192201.GI25518@thunk.org>
 <20100706080322.GA2856@burratino>
 <DD1E6EE4-1196-4FCA-87DA-EB9EBCA3AC83@mit.edu>
 <20100706150917.GA1558@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jeffpc@josefsipek.net, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 19:12:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWBhO-0006wq-Io
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab0GFRMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 13:12:36 -0400
Received: from THUNK.ORG ([69.25.196.29]:47058 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461Ab0GFRMf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 13:12:35 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OWBhB-0000t0-6z; Tue, 06 Jul 2010 13:12:33 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OWBh9-0006p3-AI; Tue, 06 Jul 2010 13:12:31 -0400
Content-Disposition: inline
In-Reply-To: <20100706150917.GA1558@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150369>

On Tue, Jul 06, 2010 at 10:09:17AM -0500, Jonathan Nieder wrote:
> 
> I have never heard of any version of Git copying poorly with #1
> (commits with the same timestamp).  Avoiding it artificially leads
> inevitably to timestamps in the future when you somehow try to assign
> 100 timestamps for the series you have rebased on top of a patch
> committed a few seconds ago.
> 
> Incrementing the timestamp to ensure strictly monotonic commits seems
> like a recipe for trouble to me.

Um, I'm guessing you spent a lot of time typing your note, but not a
lot of time looking at my most recent patch?  My most recent patch for
guilt simply will set the time of the patch to the current time to
avoid setting it into the future.

      	      				- Ted
