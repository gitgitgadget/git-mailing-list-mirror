From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Real-life kernel debugging scenario
Date: Wed, 09 Nov 2005 12:17:13 -0600
Message-ID: <1131560233.23046.26.camel@cashmere.sps.mot.com>
References: A<Pine.LNX.4.64.0511090901370.6744@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 09 19:24:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZuVb-0007ED-Ns
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 19:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030653AbVKISRQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 13:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbVKISRQ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 13:17:16 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:6536 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1030653AbVKISRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 13:17:16 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id jA9ITGCK024901;
	Wed, 9 Nov 2005 11:29:16 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id jA9INN7E010396;
	Wed, 9 Nov 2005 12:23:23 -0600 (CST)
To: wa1ter@myrealbox.com
In-Reply-To: A<Pine.LNX.4.64.0511090901370.6744@x2.ybpnyarg>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11406>

On Wed, 2005-11-09 at 11:40, wa1ter@myrealbox.com wrote:
> 
> On Mon, 7 Nov 2005, Linus Torvalds wrote:
> 
> [...]
> > The way to use "git bisect" couldn't be easier.
> 
> I see that Junio just added your entire response to
> Documentation/howto/
> isolate-bugs-with-bisect.txt where even I could manage to find it :o)

Why, thank you. :-)


> The built-in variable ORIG_HEAD isn't explained anywhere AFAICT, or at
> least it wasn't until today.  Are there other such magic variables
> which
> might be useful for us to know about?

Hey Junio,

I'm going to call "I told you so!" on this one! :-)

Ref:
    Message-ID:  <E1EXTw5-00063o-Gt@jdl.com>
    From: Jon Loeliger <jdl@freescale.com>
    Subject: Now What?
    Date: Wed, 2 Nov 2005 18:30:37 -0700

Where in I mumbled:

    I feel that an explanation of all of the behind-the-scripts-
    in-.git communication files is needed.  In particular these:

        FETCH_HEAD
        MERGE_HEAD
        LAST_MERGE
        MERGE_MSG

    These need to be mentioned and explained because they
    frequently form exactly the critical missing link or
    starting point after a failed fetch or merge.

You know.

jdl
