From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 15:03:03 -0800
Message-ID: <20130218230303.GC4022@elie.Belkin>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <20130218193424.GC3234@elie.Belkin>
 <20130218205532.GB27308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 00:03:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ZkF-0007iw-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 00:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535Ab3BRXDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 18:03:11 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:37901 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3BRXDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 18:03:10 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so1875797pbb.13
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 15:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/euKEzm0pPJh7Re80QdVDtF74dqYYkhSpeJMeZDcN84=;
        b=Q2k/5phDey0Mw31RG33i4SWtRMcqbU1iG+A0Db6NyvArCRNobOe4bmO5BLZLFJVYxW
         DyqgBfTyB39QDKvlYx3FruTDnU+OSbABVjXZX+phEYzY4yO1R6adM0ojbmOGgsDjKVal
         ffqao/FaQtGeav5XF8D27YARYoSCShSR/kKwSSY1tEJIIJM2K9bnZ2xcJzInMGlhvaFU
         0G6CTYXf2x++fSiSyex2TnLE+sXoglTVyY/LfYz11dps1+kYIHr/B9SyGgaHb+rWsM2L
         Li3S4KdpmW3Bc74vKG91HbGXsikxAc5udIcBW+iGjsDOP+dSZ4usDNw9SCDEYti8tSHD
         Ro4w==
X-Received: by 10.66.243.169 with SMTP id wz9mr40140137pac.34.1361228589027;
        Mon, 18 Feb 2013 15:03:09 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id b9sm15753602pba.6.2013.02.18.15.03.06
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 15:03:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218205532.GB27308@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216547>

Jeff King wrote:
> On Mon, Feb 18, 2013 at 11:34:24AM -0800, Jonathan Nieder wrote:

>> Some potential projects (unfiltered --- please take them with a grain
>> of salt):
>> [...]
>>  - collaborative notes editing: fix the default notes refspec,
>>    make sure the "notes pull" workflow works well and is documented
>>    well, offer an easy way to hide private notes after the fact
>>    without disrupting public history
>
> I know you said a grain of salt, so please don't feel like I'm beating
> up on your idea. I'm picking this one because I think it has some
> characteristics of projects that have not gone well in the past, so it's
> a good illustrative example.
>
> IMHO, this is the type of project that is likely to fail, because most
> of the work is not technical at all, but political. Changing the default
> refspecs is a few lines of code. But the hard part is figuring out where
> they should go, the implications of doing so, and how people are going
> to react.

I think I agree, if by "likely to fail" you mean "easy to underestimate
the difficulty of".  I actually think it would be a pretty good summer
student project, for a few related reasons:

 * Years of evidence show it is a hard problem.  It would be a good
   notch in the belt of whoever takes the project on.

 * It does not require a deep understanding of git internals.  A good
   familiarity with the git user interface, on the other hand, would
   be essential, but I hope that is becoming more common among
   students these days.

 * It requires good taste and design sense, which are something it
   would be nice to cultivate and encourage.

 * The change is necessary and the satisfaction of helping a student
   through the process might be enough to finally get it done.

 * If an amazing candidate finishes the "make collaboration possible"
   task early, there's plenty of valuable, interesting, and technically
   complicated follow-on work regarding the related "share some notes
   while hiding others" to fill the rest of the summer.

The code change for the most basic subset of "make collaboration
possible" would presumably be a changed refspec, some documentation,
and some tests.  On top of that there is presumably some automagic
incorporation of upstream notes to be cooked into "git pull".  Some
better conflict-resolution magic.  Example scripts to generate notes.
Support for the format-patch / am workflow.  gitweb support for
showing notes.

It's a good example of when it's useful to not be afraid of failing to
please everybody and just get something done.

I also can't think of any examples of such technically straightforward
student projects being tried before.

Jonathan
