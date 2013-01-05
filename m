From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Sat, 5 Jan 2013 14:57:40 -0800
Message-ID: <20130105225740.GC3247@elie.Belkin>
References: <20121222173649.04C5B44119@snark.thyrsus.com>
 <50E5A5CF.2070009@alum.mit.edu>
 <20130103205301.GD26201@thyrsus.com>
 <1E7F9F86-F040-42E4-98C4-152B8CCE47CE@quendi.de>
 <20130105151106.GA1938@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <postbox@quendi.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Yann Dirson <ydirson@free.fr>, Heiko Voigt <hvoigt@hvoigt.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 23:58:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trcgn-0002KG-83
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 23:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab3AEW5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 17:57:47 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:60868 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab3AEW5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 17:57:45 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so8103080dak.30
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 14:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sED/MktjjxhKR2OuecfVyiQdcaelIE4tp+xsUkhOBRs=;
        b=A4RKA1BKWUJxsYKgqG+8ejlOjLlXUFcTruxWcNIUqLmGcYDBefWe86pXv1lQIQkug3
         BsCl+/5LRkeYYPvorFTPqj0Tdind8H3nF0haG2twXK+IkU/wJZZ+gE615sCkEulR2qcr
         8O/hgfLr6HCt2f6ADQ9a58uVZM6j07VZJ6yl2TyIIUoF41t6F6j+eCvUs4F5FZjB8ObV
         vzdw2Q+MTwd4nsl+UV5/f2nCUFZ0mXM+B7TEaBLSwNeKGJV6b0hi8cSXa3qDVTHvFe1A
         0EPTvIO/50UByjrOSBuHWCQ/t0+LTdaEOkUVPOslAO041fT4tr6IATN3lyJ33Fbmw6V/
         S9cQ==
X-Received: by 10.66.80.65 with SMTP id p1mr165372904pax.20.1357426665177;
        Sat, 05 Jan 2013 14:57:45 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id a4sm35742367pax.25.2013.01.05.14.57.43
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 14:57:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130105151106.GA1938@thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212735>

Eric S. Raymond wrote:

> Michael Haggerty wants me to trust that cvs2git's analysis stage has
> been fixed, but I must say that is a more difficult leap of faith when
> two of the most visible things about it are still (a) a conspicuous
> instance of interface misdesign, and (b) documentation that is careless and
> incomplete.

For what it's worth, I use cvs2git quite often.  I've found it to work
well and its code to be clear and its developers responsive.  But I
don't mind if we disagree, and multiple implementations to explore the
design space of importers doesn't seem like a terrible outcome.

Thanks for your work,
Jonathan
