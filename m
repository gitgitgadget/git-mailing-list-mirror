X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [EGIT PATCH] Convert author and comment on demand.
Date: Sun, 3 Dec 2006 10:08:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612030955320.3476@woody.osdl.org>
References: <200612030145.09576.robin.rosenberg@dewire.com>
 <20061203021655.GA26668@spearce.org> <200612031318.33332.robin.rosenberg@dewire.com>
 <ekug7o$35c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 18:08:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ekug7o$35c$1@sea.gmane.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33121>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqvl9-0007ld-4d for gcvg-git@gmane.org; Sun, 03 Dec
 2006 19:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759955AbWLCSIK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 13:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759954AbWLCSIJ
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 13:08:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:3267 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1759950AbWLCSIH (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 13:08:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB3I83jQ026489
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 3
 Dec 2006 10:08:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB3I82fU025506; Sun, 3 Dec
 2006 10:08:03 -0800
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 3 Dec 2006, Jakub Narebski wrote:
> 
> It is easier to comment on patch if it is embedded in the mail, and not
> in attachement.

This is why I _hate_ patches in attachments.

Sure, I can make my mail reader show the attachments. But when I "reply", 
I want the patch to be indented with the regular "> " thing and visible in 
the reply, so that I can say "I like the patch in general, but <this> part 
of it is seriously broken".

And yes, the personal mailreader I have has a "include attachements in 
reply" mode. But I don't generally want to include attachments in any 
reply, I just want it for _patches_.

[ Side ntoe: besides, many people send broken attachments that aren't 
  marked as text, but as 8-bit binary data or something, even if it's a 
  text-patch - so "attachement problems" are almost as common as the 
  non-attachement "line wrap" or whitespace problems are - people who 
  think that attachments automatically means that the thing is correct are 
  just deluding themselves.

  The fact is, you can get attachments wrong exactly the same way you get 
  linewrapping wrong. It's just that the pure binary data is likely to 
  always make it through correctly with an attachment, but if it gets 
  marked as a binary MIME-type, that doesn't much help, because while the 
  data is there, it's still going to act the wrong way for any 
  _discussion_ about it. ]

In other words: there are lots of things that make sense as true 
attachments. It's just that "patch" is not one of them.

Patches, unlike for example full files or tar-balls, by their very design 
are (a) text and (b) something where the whole _point_ is discussion and 
quoting about them. If we didn't want to discuss the patch contents, we 
wouldn't send them as patches in the first place, they'd be git-to-git 
transfers.

So this all boils down to one thing:

	PATCHES ARE NOT SEPARATE FILES TO BE ATTACHED TO AN EMAIL.

Patches are to be considered part of the discussion, not separate. And 
thus they should be in the main body of the email, exactly so that people 
(regardless of mailer settings and details like that) will automatically 
quote them, and they get passed around as integral to the discussion as 
the discussion itself.

I just jumped in because this is a pet peeve of mine. Some people seem to 
think that patches are "binary files" just because they have whitespace 
requirements and line-wrapping matters. But whitespace and line wrapping 
is important even in regular discussion, and patches really _are_ about 
the _human_ communication, just as much - and perhaps more so - as they 
are about feeding to the "patch" program.

