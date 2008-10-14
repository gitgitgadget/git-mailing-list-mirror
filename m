From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: How many users of parsecvs are there?
Date: Tue, 14 Oct 2008 11:10:00 +0100
Message-ID: <b2cdc9f30810140310l647eb2fbld3f6a1c608d029a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: keithp@neko.keithp.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 12:11:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpgs0-00087d-Sw
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 12:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbYJNKKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 06:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754801AbYJNKKE
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 06:10:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:24740 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbYJNKKC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 06:10:02 -0400
Received: by yw-out-2324.google.com with SMTP id 9so490004ywe.1
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 03:10:01 -0700 (PDT)
Received: by 10.90.102.15 with SMTP id z15mr3085609agb.95.1223979000153;
        Tue, 14 Oct 2008 03:10:00 -0700 (PDT)
Received: by 10.90.105.11 with HTTP; Tue, 14 Oct 2008 03:10:00 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: cb566a319688d94f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98178>

I'm wondering how many people are there still using parsecvs to to
track a live CVS tree?

I've been using it for a while at work to track a rather monster CVS
repository. The main reasons are:

1. It's the fastest import I've come across so far. Given the size of
the CVS repo other solutions took far too long to do the conversion
2. It's simple to configure (if you can call "find" configuring),
assuming you have access to the CVS repo proper
3. It reliably regenerates the repository so you can run the entire
conversion from scratch the next day and hapily pull into working
repos (I assume if I got tother working they should exhibit this
property).

However I have come across a few problems. One of which involves files
not getting put into branches which I've managed hack a band-aid
solution for that involves ignoring date discrepancies. However having
mailed keith he made it clear he doesn't use it any more having
converted his stuff so it's currently not being actively maintained.

So the question really is are there people out there still using it?
If not I'll hang up my code exploring boots and have another go at
whatever is considered the best in class iterative CVS to GIT gateway.
If it's still a useful tool for other people as well I'm happy to
delve deeper into the code and seeing if any of the crinkles can be
ironed out.

It's interesting to note from the Git Users Survey 2008 that CVS is
still the second most used legacy version control system. One could
draw the conclusion that having a well supported bullet proof
incremental CVS import mechanism as part of git should still be a
fairly important goal. There are a lot (too many?)  out of tree
solutions out there which makes approaching the task somewhat daunting
when first coming to git.

-- 
Alex, homepage: http://www.bennee.com/~alex/
