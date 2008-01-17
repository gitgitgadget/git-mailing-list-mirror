From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 17:51:40 +1300
Message-ID: <46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com>
References: <478E1FED.5010801@web.de>
	 <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
	 <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
	 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
	 <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
	 <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
	 <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
	 <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
	 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
	 <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mark Junker" <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 05:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFMkA-0008VU-DE
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 05:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbYAQEvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 23:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbYAQEvp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 23:51:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:2018 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYAQEvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 23:51:43 -0500
Received: by ug-out-1314.google.com with SMTP id z38so299174ugc.16
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 20:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xSirYr7HesLWRrwVQ3uTNLayK86hx/dgUWN2E7Scv4s=;
        b=JGpZKyIBdsPA+UbeAaMcde2Xep10XSVqm/OB7UIuBakommpksACPaLESvVB2yq/wPEUCqFKCszi8iAt5YxUc8713ee1CmnKIIL7RS9JH8Q51iaRjVhPcJN0BH8U0pSFNrfuw8GFsaw5qbvqLTnW+sQum2AeQlZR4ci6EoKY3RfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JDEIjqKZ2Ds91J1jIylHufbMliRtEdVlc9MGxZbBzaRitcx/uOZYj61I82NnaQXmHr4xQtHRDOdtlx1L6G2G1nLkXJOdylQmEbXnyoi7oWqSywFD9hbfFoMprVjgUuO5R/GmEwAkXA9MPJ0ngRRU4AheBlIyk6AODooYbvRJJOk=
Received: by 10.66.249.16 with SMTP id w16mr2935074ugh.32.1200545500270;
        Wed, 16 Jan 2008 20:51:40 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Wed, 16 Jan 2008 20:51:40 -0800 (PST)
In-Reply-To: <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70825>

On Jan 17, 2008 5:30 PM, Kevin Ballard <kevin@sb.org> wrote:
> Those of us who grew up on a case-insensitive filesystem don't find
> there to be any problem with it. I can count on one hand the number of

I guess you haven't used unix tools much. The ever-popular HEAD perl
utility (which does an HTTP HEAD against a URL), when installed,
silently overwrites the head shell utility, which is used for all
sorts of things, some even in startup scripts. Ooops! I've been hit by
this more than once - and if you google for it, it hurt a lot of
people.

> That's only true if you don't know what type of filesystem you're on.
> And, in the vast majority of cases (in fact, a content tracker is the
> only exception I can think of), it doesn't matter. If the user said

Hmmm. Many important tools - that I wouldn't want to ever fail! - have
similar needs to git. Backup/restore and file replication tools for
example.

> > This is why case-insensitivity is so hard: you have a very real
> > "aliasing"
> > on the filesystem level, where all those really *different*
> > pathnames end
> > up being the same thing.
>
> I don't see that as being a problem. Think of it, if you will, as if
> every single file simply had an implicit hardlink for every possible
> case or normalization variant. The whole point of the filename is that

Ok - but how do you track the directory then (in git's terms, the
tree). There's no way to tell what the user wants. Does the user want
a copy of the file with different capitalization, or is the OS playing
games?
> it is meta-information, used as an identifier and not as actual
> content, and thus it is perfectly fine for it to be a real string,
> subject to interpretation,

I don't think you *actually* want it subject to interpretation.

> Again, as someone who grew up in a case-insensitive world, there's no
> problems here. I wish I could tell you that it causes problems, I wish
> I could agree with you, but I can't.

Probably because you have been surrounded by tools that have a lot of
extra code to cope with the case insensitive way of life, and learned
to not do things that are completely valid, just to avoid trouble.
Which is ok, but I don't think it makes the OS design decision
defensible.

cheers,


m
