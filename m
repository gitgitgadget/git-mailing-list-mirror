From: arjen@yaph.org (Arjen Laarhoven)
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Wed, 10 Sep 2008 12:03:01 +0200
Message-ID: <20080910100301.GA27748@regex.yaph.org>
References: <20080907184537.GA4148@regex.yaph.org> <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 12:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdMXz-00085N-ET
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 12:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYIJKCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 06:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbYIJKCc
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 06:02:32 -0400
Received: from regex.yaph.org ([193.202.115.201]:42945 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbYIJKCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 06:02:31 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id E9F635B7D5; Wed, 10 Sep 2008 12:03:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95508>

On Wed, Sep 10, 2008 at 09:03:05AM +0100, Mike Ralphson wrote:
> 2008/9/7 Arjen Laarhoven <arjen@yaph.org>
> > The standard libc regex library on OSX does not support alternation
> > in POSIX Basic Regular Expression mode.  This breaks the diff.funcname
> > functionality on OSX.
> >
> > Also, I'm sure the problem occurs on more non-Linux systems (or non
> > GNU libc systems).  If people who have access to those systems (BSD's,
> > HP-UX, AIX, etc) can test it, I'd be happy to add those systems to the
> > patch so it can fix for multiple systems at once.
> 
> I can confirm that the issue shown up by your new testcase is also
> present in AIX 5.3.

Ok, I'll add AIX to the fix and a Tested-by: line.

[snip]

> Adding -lcompat/regex to COMPAT_CFLAGS as per your Darwin hunk
> provokes lots of warnings:

I think your problem is a lowercase ell instead of an uppercase i ;-)

Arjen

-- 
Arjen Laarhoven

The presence of those seeking the truth is infinitely to be preferred to 
those who think they've found it.
                                -- Terry Pratchett, "Monstrous Regiment"
