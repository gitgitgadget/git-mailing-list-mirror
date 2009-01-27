From: David Abrahams <dave@boostpro.com>
Subject: Re: friendlier names
Date: Tue, 27 Jan 2009 11:40:17 -0500
Message-ID: <87vds04s9a.fsf@mcbain.luannocracy.com>
References: <87mydc6a2r.fsf@mcbain.luannocracy.com>
	<20090127153837.GB1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 17:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRr7o-0000JQ-5F
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 17:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbZA0Qrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 11:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbZA0Qry
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 11:47:54 -0500
Received: from boost-consulting.com ([206.71.190.141]:63741 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbZA0Qrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 11:47:53 -0500
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jan 2009 11:47:53 EST
Received: from mcbain.luannocracy.com.boostpro.com (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 240431CC1E;
	Tue, 27 Jan 2009 08:29:34 -0800 (PST)
In-Reply-To: <20090127153837.GB1321@spearce.org> (Shawn O. Pearce's message of
	"Tue, 27 Jan 2009 07:38:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107361>


on Tue Jan 27 2009, "Shawn O. Pearce" <spearce-AT-spearce.org> wrote:

> David Abrahams <dave@boostpro.com> wrote:
>> 
>> For example, why couldn't the "index" be called the "stage" instead?
>> That, along with knowing that "git add" was a synonym for "git stage"
>> would have flattened the learning curve considerably for me.
>
> Historical reasons...
>
> Waaay back the "index" was an index of the files git knows about in
> your working directory.  It made sense to call it an index, as like
> a book index it was a full listing of what's here, sorted by name.
>
> That's pre-1.0 days.  Like the very first version Linus ever
> released.  Aka commit e83c5163316f89bfbde7d9ab23ca2e25604af290.

I'm not saying "index" doesn't make sense.  It _still_ makes sense.  It
just doesn't make as much sense as "stage."  Index is a very generic
term; it doesn't communicate enough.

> Much, much later, over many months, the index morphed into what
> you see today, which is a "staging area", accessed by "git add".
>
> This was all incremental, in small parts.  Nobody set out to
> design a "staging area" or to have "staging actions".  Back
> when it was really the index you updated it with a tool called
> git-update-index.  Adding new files required the --add flag.
>
> People found --add annoying, so they wrote "git add" as a
> wrapper around it.  But modified existing files still had
> to be updated with git-update-index.  Then someone pointed
> out that add of an existing file and add of a new file are
> similiar enough that they should just be the same command,
> "git add".
>
> Only late last October at the GitTogether did we start to talk about
> creating a command called "git stage", because people have started to
> realize we seem to call it a "staging area" as we train newcomers...

Sounds like, from everything you've said, "stage" rather than "index"
would have been just as sensible in the beginning as it is today; it's
just that you have a much nicer interface for working with it.

> The tools are _all_ slowly evolved over time.  Nothing in git
> was ever set out from the beginning as a "this is what we are
> going to do".  The only part of Git that is like that is the core
> data structure on disk for the object store.  That hasn't changed
> since Linus switched from SHA1(COMPRESS(data)) to SHA1(data) for
> the object naming algorithm, and even that was done in the first
> couple of weeks.

OK, thanks for the history lesson.  It's good to know someone is paying
attention to these things.  Is there any movement toward addressing
them outside of GitTogether talk?

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
