From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] git-pack-objects.txt: fix grammatical errors
Date: Sat, 02 Apr 2011 17:16:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104021713480.28032@xanadu.home>
References: <1301475606-11339-1-git-send-email-bebarino@gmail.com>
 <alpine.LFD.2.00.1104021155230.28032@xanadu.home>
 <7vy63sh6p7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 23:16:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q68B5-0003WT-Le
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 23:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab1DBVQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 17:16:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31828 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026Ab1DBVQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 17:16:08 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LJ100JSWN1XKO40@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 02 Apr 2011 17:15:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vy63sh6p7.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170663>

On Sat, 2 Apr 2011, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> >> index a51071e..442018b 100644
> >> --- a/Documentation/git-pack-objects.txt
> >> +++ b/Documentation/git-pack-objects.txt
> >> @@ -190,9 +190,9 @@ self-contained. Use `git index-pack --fix-thin`
> >>  (see linkgit:git-index-pack[1]) to restore the self-contained property.
> >>  
> >>  --delta-base-offset::
> >> +	A packed archive can express the base object of a delta as
> >> +	either a 20-byte object name or as an offset in the
> >> +	stream, but older versions of git don't understand the
> >>  	latter.  By default, 'git pack-objects' only uses the
> >>  	former format for better compatibility.  This option
> >>  	allows the command to use the latter format for
> >
> > This is misleading and not even true anymore if not using pack-objects.  
> > Most people are using either 'git repack' or even 'git gc', and the 
> > default is to use this parameter since commit 22c79eab.
> 
> This page is on the pack-objects plumbing, and in that context there is
> nothing misleading nor false about it.

True.  But...

> We may however want to do something like the attached to help people who
> might wonder how to pass this option through the Porcelain they use.

That's the kind of precision I was meaning.

> the longer term, it probably makes sense to make the option default at a
> version bump, perhaps at the 1.8.0 boundary.

Agreed.


Nicolas
