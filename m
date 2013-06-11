From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 19:29:36 +0100
Message-ID: <20130611182936.GM22905@serenity.lan>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
 <51B6AA7F.1060505@alum.mit.edu>
 <7v38sod1kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTKP-0007FF-7A
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab3FKS3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:29:53 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:41021 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab3FKS3w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:29:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A5D8DCDA585;
	Tue, 11 Jun 2013 19:29:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RRKeiOcAobTU; Tue, 11 Jun 2013 19:29:49 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 66444CDA583;
	Tue, 11 Jun 2013 19:29:48 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 496C7161E388;
	Tue, 11 Jun 2013 19:29:48 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wt+8eYyNongL; Tue, 11 Jun 2013 19:29:47 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C9DCD161E0B3;
	Tue, 11 Jun 2013 19:29:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v38sod1kn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227487>

On Tue, Jun 11, 2013 at 10:00:56AM -0700, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> > * When reviewing other peoples' code, be tactful and constructive.  Set
> > high expectations, but do what you can to help the submitter achieve
> > them.  Don't demand changes based only on your personal preferences.
> > Don't let the perfect be the enemy of the good.
> 
> I think this is 30% aimed at me (as I think I do about that much of
> the reviews around here).  I fully agree with most of them, but the
> last sentence is a bit too fuzzy to be a practically useful
> guideline.  Somebody's bare minimum is somebody else's perfection.
> An unqualified "perfect is the enemy of good" is often incorrectly
> used to justify "It works for me." and "There already are other
> codepaths that do it in the same wrong way.", both of which make
> things _worse_ for the long term project health.

One thing that I think is missing from these proposals so far is some
clear indication that a review should not be confrontational.  Consider
the following two review comments (taken from a recent example that
happened to stick in my mind, but I don't want to single out any one
individual here):

    Ugh, why this roundabout-passive-past tone?  Use imperative tone
    like this:

        ...

vs.

    We normally use the imperative in commit messages, perhaps like
    this?

        ...

Both say the same thing but the first immediately puts the submitter on
the defensive.  If I see something like that on one of my patches I have
to consciously resist the urge to reply immediately and instead review
what I'm about to send once I've calmed down.

I realise that we shouldn't take offence to review comments, but we are
all human and it is sometimes hard not to take things personally.

In the examples above, the first makes it feel like the submitter is
fighting to get a patch included, but the second feels like we're
collaborating to get to the best result for the project.

As my mother would say, "politeness costs nothing" ;-)
