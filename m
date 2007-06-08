From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: fatal: ambiguous argument 'HEAD': unknown revision or path not
	in the working tree.
Date: Fri, 8 Jun 2007 12:21:13 +0200
Message-ID: <20070608102113.GB2335@cip.informatik.uni-erlangen.de>
References: <20070608100831.GA2335@cip.informatik.uni-erlangen.de> <7vodjqkazp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 12:21:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwbat-0007Zy-5r
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 12:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937741AbXFHKVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 06:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937766AbXFHKVP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 06:21:15 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:41203 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937741AbXFHKVO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 06:21:14 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 851C03F3F9; Fri,  8 Jun 2007 12:21:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vodjqkazp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49455>

Hello Junio,

> ... well that was my initial guess, but even after setting up such a
> funny repository by hand, I cannot seem to reproduce it.

This was on a fresh clone. What I did was:

        (s017241) [/usr/src] git clone 131.188.30.102:/scratch/tg/linux-2.6/
        Initialized empty Git repository in /usr/src/linux-2.6/.git/
        remote: Generating pack...
        remote: Done counting 496189 objects.
        remote: Deltifying 496189 objects...
        remote:  100% (496189/496189) done
        Indexing 496189 objects...
        remote: Total 496189 (delta 401610), reused 496189 (delta 401610)
        100% (496189/496189) done
        Resolving 401610 deltas...
        100% (401610/401610) donedone
        fatal: Not a valid object name HEAD

I see it. Last line. I tried to clone from a repository which itself had a
detached HEAD. Could that be the problem?

        Thomas
