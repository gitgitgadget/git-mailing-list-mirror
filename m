From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 11:34:24 -0800
Message-ID: <20130218193424.GC3234@elie.Belkin>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Mon Feb 18 20:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7WUJ-00051D-VD
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757004Ab3BRTeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:34:31 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45349 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756885Ab3BRTea (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:34:30 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so2925110pad.35
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 11:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ys1/XwgQEJgAS0CuRKXyNbJuGx70l3JykETlG5JVDrY=;
        b=o+rFz6Eowj1s4DuerMvYpI/EgmT/s+iIUd3rRIwT0mNoTlx9bS9bhDwh3+ZeUVobhF
         uzekHQg3FGi7Ej+VglQ0SqX7OTZEJUwWI9oXsYmDQmPi2eb7c6EAo2rh/ZGtxY7pq72B
         WhbmE7D7FnF2WC8LviC0vncSrvqfikIKeYLrNKnk5Ib1NTX+z5i2rsHF8mAueib1frrF
         NwthPmbfFFoKFcC4SZ/qwqryB3+rRCYTI+PHao5YqYxv8pk6WabInWj6h7AQ2tVAVHoW
         2E4gLxSt918H9yCwjH4/NYTgBmlaM+LNyAzhxbOUQvwkeVoA/OP/uDXwpkhWOFmR1QRr
         BHRQ==
X-Received: by 10.68.233.4 with SMTP id ts4mr33029311pbc.127.1361216070379;
        Mon, 18 Feb 2013 11:34:30 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ab1sm15317297pbd.37.2013.02.18.11.34.26
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 11:34:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218174239.GB22832@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216500>

Hi,

Jeff King wrote:

> I will do it again, if people feel strongly about Git being a part of
> it. However, I have gotten a little soured on the GSoC experience. Not
> because of anything Google has done; it's a good idea, and I think they
> do a fine of administering the program. But I have noticed that the work
> that comes out of GSoC the last few years has quite often not been
> merged, or not made a big impact in the codebase, and nor have the
> participants necessarily stuck around.

I think that if we can commit enough time to mentor well it's
worthwhile.  Even such a negative result is useful, since it can teach
us how good or poor we are at bringing new contributors in and what
parts of that process need more work.

That said, I won't have time to mentor a project on my own.  It takes
a lot of time (or luck, to get the student that doesn't need
mentoring).  I'd be happy to help on a project with 1 or 2 co-mentors.

Some potential projects (unfiltered --- please take them with a grain
of salt):

 - cross-compilable git

 - incorporation of the cgit web interface, or formalizing a subset of
   libgit.a to export as a stable library to it

 - merging the gitweb-caching fork

 - moving forward on a project that was the subject of a previous
   gsoc project: line-level logging, "rebase --interactive" on top of
   sequencer, usable svn remote helper

 - collapsable --first-parent history in gitk
   http://bugs.debian.org/600001

 - drag-and-drop cherry-pick in gitk

 - a sub-library of code shared with libgit2 (might be hard because
   our notions of strings are different :().

 - assimilating the distro builds: "make deb-pkg", "make rpm-pkg",
   etc along the same lines as the linux kernel's script/package/,
   to help people get recent git installed when they want it

 - "please cherry-pick this before testing that" notes for less
   scary bisecting

 - collaborative notes editing: fix the default notes refspec,
   make sure the "notes pull" workflow works well and is documented
   well, offer an easy way to hide private notes after the fact
   without disrupting public history

Hope that helps,
Jonathan
