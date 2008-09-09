From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 22:25:03 +0200
Message-ID: <20080909202503.GB13634@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <20080909195930.GA2785@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:26:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd9mu-0004WT-Q3
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbYIIUZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 16:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbYIIUZF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:25:05 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59350 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbYIIUZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:25:05 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 013C75465; Tue,  9 Sep 2008 22:25:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080909195930.GA2785@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95425>

Jeff King wrote:
>On Tue, Sep 09, 2008 at 09:43:54PM +0200, Stephen R. van den Berg wrote:
>> >Besides I very much prefer using 'origin <sha1> <sha2>' (as proposed

>> The simplicity sounds inviting.  I'd like to hear from others who have
>> more experience (than I have) with the git vs. changeset paradigms about
>> this.  This allows a bit more flexibility in specifying the origin, the
>> question is if it's needed.

>And yes, you can get _too_ general to the point where your semantics
>become meaningless. But I don't think that is the case here. You are
>defining the origin field as "by the way, the difference between state X
>and state Y was used to make this commit". cherry-pick just happens to
>make Y=X^, but something like rebase could use a series.

>As for "git vs changeset": this is git. So you have a sequence of tree
>states whether that is what you want or not. Thus you are specifying
>the difference between _some_ pair of commits. I don't see any benefit
>to restricting it to a commit and one of its parents.

Quite.  I'll drop the old format and adapt my proposal to use the double
hash.

As far as the naming of the field is concerned: a changeset is what the
field describes, but changeset implies no sense of direction; origin
makes it clear that the current commit was derived *from* the changeset
represented by "origin".
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
